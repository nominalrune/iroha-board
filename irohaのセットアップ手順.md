# iroha-board Dockerizedのセットアップ手順
last updated: 2020.09.24

---
目次
<!-- @import "[TOC]" {cmd="toc" depthFrom=2 depthTo=6 orderedList=true} -->

<!-- code_chunk_output -->

1. [環境](#環境)
2. [セットアップ手順](#セットアップ手順)
    1. [A. 2020.09.23 現在のバージョンでインストールする](#a-20200923-現在のバージョンでインストールする)
        1. [環境構築](#環境構築)
        2. [イメージのビルドと起動](#イメージのビルドと起動)
        3. [動作確認](#動作確認)
    2. [B. 最新バージョンをインストールする[TBD]](#b-最新バージョンをインストールするtbd)

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

### A. 2020.09.23 現在のバージョンでインストールする

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
		```terminal
		mkdir /projects
		mkdir /projects/iroha
		```
1. **iroha boardのダウンロード**
	- プロジェクトフォルダに、横山によるソースセットを丸ごとコピーする
	<small>（2020.09.23 現在は https://github.com/nominalrune/iroha-board-Dockerized.git に公開している。社内向けに、安定的な場所に移動予定）</small>
	- 例: GitHubからリポジトリをクローンして、ブランチを作成
		```terminal
		git clone https://github.com/nominalrune/iroha-board-Dockerized.git /projects/iroha
		cd /projects/iroha
		git checkout -b lbProjectTest
		```
1. **設定**
	1. apacheへの所有権委譲
		- apacheが外部公開ディレクトリを操作できるよう、所有権をわたす
			- 例:
				```terminal
					chown -R www-data /projects/iroha/apache
				```
	1. MySQLのパスワード設定
	- ルートパスワードを設定する（デフォルトでは`root`）
		1. MySQL側の設定
			1. `docker-compose.yml`内の環境変数`MYSQL_ROOT_PASSWORD`の値を変更
				- 例:
					```terminal
					vi docker-compose.yml # 編集コマンドを打つ
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
					:wq  #保存してquitコマンドで完了
					```
		1. iroha board側の設定
			1. プロジェクトディレクトリ以下`./apache/html/app/Config`内にある、`database.php`の`'password'`変数をMySQLでのパスワードに合わせる
				- 例:
					```terminal
					vi ./apache/html/app/Config/database.php
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
					:wq
					```
#### イメージのビルドと起動
1. コンテナからイメージを作成
	- irohaプロジェクトのルートディレクトリにいることを確認する。（例では`/iroha`）
	- 次のコマンドを打つ。
		```terminal
		docker-compose up --build
		```
1. サービスが起動するまで待つ
	- mysqlイメージが
		```terminal
		[System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.21'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server - GPL.
		```
		というメッセージを出して待機状態になれば完了
#### 動作確認
1. アクセス確認
	1. ウェブブラウザを開き、`127.0.0.1:10080/install`にアクセスする
	1. 管理者パスワード設定画面が表示されれば成功
1. ユーザー設定
	1. 管理者
		1. 初期画面にてパスワードを設定する
		1. 授業コースを作成する
			1.　メニューから［コース］をクリック
			1. ［コース一覧］画面が表示される
			1. ［＋追加］をクリック
			1. コース名を入力して［作成］
			1. ［コース一覧］画面に、作成したコースが表示されていることを確認する
			1. コース名をクリックすると、［コンテンツ一覧］が表示される
			1. ［＋追加］をクリック
			1. コンテンツタイトルを入力
			1. コンテンツ種別は「映像」にする
				1. 上限2MBまでのファイルがアップロードできることを確認する
			1. ［保存］ボタンを押す
			1. ［コンテンツ一覧］に作成したコンテンツが表示されていることを確認する
		1. 受講者のアカウント作成
			1. [ユーザ一覧]画面から、［＋追加］というボタンを押す
			1. 権限を「受講者」に設定する
			1. 「受講コース」に、先ほど作成したコースを割りあてる
			1. その他の必須入力事項を適宜入力して、［保存］をクリック
			1. [ユーザ一覧]に受講者が登録されていることを確認する
		1. 受講者アカウントでのログイン
			1. 管理者アカウントからログアウト
			1. 「管理者ログイン」画面にいたる
			1. 「受講者ログインへ」というリンクをクリック
			1. 先ほど登録した受講者アカウントでログインする
			1. 「コース一覧」にコースが割り当てられていることを確認する
			1. コースが受講できることを確認する
### B. 最新バージョンをインストールする[TBD]
