# iroha-board Dockerizedのセットアップ手順
last updated: 2020.09.24

---
目次
<!-- @import "[TOC]" {cmd="toc" depthFrom=2 depthTo=6 orderedList=true} -->

<!-- code_chunk_output -->

1. [環境](#環境)
2. [セットアップ手順](#セットアップ手順)
    1. [2020.09.23 現在のバージョンでインストールする](#20200923-現在のバージョンでインストールする)
        1. [環境構築](#環境構築)
        2. [イメージのビルドと起動](#イメージのビルドと起動)
        3. [動作確認](#動作確認)

<!-- /code_chunk_output -->


---
- この文書で説明すること
	- Docker for Windows上でiroha boardサービスをセットアップする方法
- この文書で説明しないこと
	- iroha board自体のサービス特徴
	- 個別の設定事項についての仕様詳細
---
## 環境
- Windows10 Home バージョン 2004 [build 19041] 以降
- [WSL2]()が導入済であること
- [Docker for Windows]() version 19.03.12 以降が導入済であること
- [git]() が導入済であること

## セットアップ手順

### 2020.09.23 現在のバージョンでインストールする

以下のバージョンがインストールされます
|   service   | version |
| :---------: | :-----: |
| Iroha Board | 0.10.4  |
|   CakePHP   | 2.10.20 |
|     PHP     |  9.4.3  |
|    MySQL    | 8.0.21  |

#### 環境構築
1. **プロジェクトフォルダ作成**
	- iroha boardプロジェクト用のフォルダを作成する
		- 例：
		```powershell
		mkdir /projects
		mkdir /projects/iroha
		```
1. **iroha boardのダウンロード**
	- プロジェクトフォルダに、横山によるソースセットを丸ごとコピーする
	<small>（2020.09.23 現在は https://github.com/nominalrune/iroha-board-Dockerized.git に公開している。社内向けに、安定的な場所に移動予定）</small>
	- 例: GitHubからリポジトリをクローンして、ブランチを作成
		```powershell
		git clone https://github.com/nominalrune/iroha-board-Dockerized.git /projects/iroha
		cd /projects/iroha
		git checkout -b lbProjectTest
		```
1. **設定**

	1. MySQLのパスワード設定
	- ルートパスワードを設定する（デフォルトでは`root`）
		1. MySQL側の設定
			1. `docker-compose.yml`内の環境変数`MYSQL_ROOT_PASSWORD`の値を変更
				- 例:
					```powershell
					code docker-compose.yml
					# ~~中略~~
					     mysql: #MySQLの項目を見つける
						image: mysql:8.0.21
						restart: unless-stopped
						networks:
						    - iroha_net
						environment:
						    - MYSQL_DATABASE=irohaboard
						    - MYSQL_ALLOW_EMPTY_PASSWORD=yes
						    - MYSQL_ROOT_PASSWORD=root # パスワードの変更はここ
						    - TZ=Asia/Tokyo
						volumes:
						    - ./apache/sql:/var/lib/mysql:rw
						tty: true
						stdin_open: true
					# ~~中略~~
					```
		1. iroha board側の設定
			1. プロジェクトディレクトリ以下`./apache/html/app/Config`内にある、`database.php`の`'password'`変数をMySQLでのパスワードに合わせる
				- 例:
					```powershell
					code ./apache/html/app/Config/database.php
					# ~~中略~~
					class DATABASE_CONFIG {
					        public $default = array(
					                'datasource' => 'Database/Mysql',
					                'persistent' => true,
					                'host' => 'mysql',
					                'login' => 'root',
					                'password' => 'root', # パスワードの変更はここ
					                'database' => 'irohaboard',
					                'prefix' => 'ib_',
					                'encoding' => 'utf8'
					        );
					}
					# ~~中略~~
					```
#### イメージのビルドと起動
1. コンテナからイメージを作成
	- irohaプロジェクトのルートディレクトリにいることを確認する。（例では`/iroha`）
	- 次のコマンドを打つ。
		```powershell
		docker-compose up --build
		```
1. サービスが起動するまで待つ
	- mysqlイメージが
		```powershell
		[System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.21'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server - GPL.
		```
		というメッセージを出して待機状態になれば完了
#### 動作確認
1. アクセス確認
	1. ウェブブラウザを開き、`127.0.0.1:10080/install`にアクセスする
	1. 管理者パスワード設定画面が表示されれば成功
1. 管理者ログイン
	1. 管理者パスワード設定画面にて、好きなパスワードを入力
	1. ［インストール］ボタンを押す
	1. ［管理者ログイン画面へ］ボタンを押す
	1. ログインする
		（→［ユーザー一覧］画面が表示される）
1. 授業コースを作成
	1. 上部ナビバーから［コース］をクリック
		（→［コース一覧］画面が表示される）
	1. ［＋追加］ボタンをクリック
		1. 「コース名」に`テストコース`と入力して［作成］ボタンをクリック
		（→［コース一覧］画面が表示される）
		1. ［コース一覧］画面に、作成したコース（`テストコース`）が表示されていることを確認する
1. 授業コンテンツのアップロード
	1. ［コース一覧］画面にて、`テストコース`をクリック
	（→［コンテンツ一覧］画面が表示される）
	1. ［＋追加］ボタンをクリック
	1. 「コンテンツタイトル」に`テスト映像`と入力
	1. 「コンテンツ種別」は`映像`にする
		1. mp4動画を用意してアップロード
			- 上限2MBまでの動画ファイルがアップロードできることを確認する
	1. ［保存］ボタンを押す
	1. ［コンテンツ一覧］画面に、作成したコンテンツ（`テスト映像`）が表示されていることを確認する
1. 受講者のアカウント作成
	1. ［ユーザ一覧］画面から、［＋追加］ボタンを押す
		1. 入力事項
			- 「名前」：`テスト受講者`
			- 「パスワード」：`test`
			- 「権限」：`受講者`
			- 「受講コース」：`テスト授業`
		1. ［保存］ボタンをクリック
	1. ［ユーザ一覧］画面に`テスト受講者`が登録されていることを確認する
1. 受講者アカウントでのログイン
	1. 管理者アカウントからログアウト
		- ページ右上に「ログアウト」ボタンがある
	1. 「管理者ログイン」画面が表示される
	1. 「受講者ログインへ」というリンクをクリック
	1. 先ほど登録した受講者アカウントでログインする
		- ログインID：`テスト受講者`
		- パスワード：`test`
	1. 「コース一覧」にコース（`テストコース`）が割り当てられていることを確認する
	1. `テストコース`をクリック
	1. `テスト授業`をクリック
		- 映像が再生できることを確認する
1. テストデータの削除
   1. 管理者アカウントでログインする
   1. 受講者データの削除
      1. ［ユーザー一覧］画面にて、`テスト受講者`の欄の［削除］ボタンを押す
   1. コースデータの削除
      1. ［コース一覧］画面にて、`テストコース`の欄の［削除］ボタンを押す

