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
	- 個別の設定事項についての詳細
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
	iroha boardプロジェクト用のフォルダを作成する
	```terminal
	mkdir iroha
	```
1. **iroha boardのダウンロード**
	プロジェクトフォルダに、横山によるソースセットを丸ごとコピーする
	<small>（2020.09.23 現在は https://github.com/nominalrune/iroha-board-Dockerized.git に公開している。社内向けに、安定的な場所に移動予定）</small>
	- 例：GitHubからリポジトリをクローンして、ブランチを作成
		```terminal
		git clone https://github.com/nominalrune/iroha-board-Dockerized.git　./iroha
		cd iroha
		git checkout -b lbProjectTest
		```
1. **設定**（オプショナル）
	1. MySQLのパスワード設定
		1. rootパスワード（デフォルトでは`root`）
			1. MySQL側の設定
				1. `docker-compose.yml`内の環境変数`MYSQL_ROOT_PASSWORD`の値を変更
				```terminal
				vi docker-compose.yml #編集コマンドを打つ
				~~略~~
				     mysql: #MySQLの項目を見つける
					image: mysql:8.0.21
					restart: unless-stopped
					networks:
					    - iroha_net
					environment:
					    - MYSQL_DATABASE=irohaboard
					    - MYSQL_ALLOW_EMPTY_PASSWORD=yes
					    - MYSQL_ROOT_PASSWORD=root #これ！！
					    - TZ=Asia/Tokyo
					volumes:
					    - ./apache/sql:/var/lib/mysql:rw
					tty: true
					stdin_open: true
				~~略~~
				:wq  #保存してquitコマンドで完了
				```
			1. iroha board側の設定
				1. ディレクトリ`./apache/html/app/Config`内にある、`database.php`の`'password'`変数をMySQLでのパスワードに合わせる
					例ei:
					```terminal
					vi 
					```
#### イメージのビルドと起動
1. ターミナル起動
	1. ターミナルで、iroha boardプロジェクトのディレクトリを開く
(`docker-compose.yml`のあるディレクトリ)

1. コンテナからイメージを作成
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
1. アクセス
	1. ウェブブラウザを開き、`127.0.0.1:10080/install`にアクセスする
1. ユーザー設定
	1. 管理者
		1. 作成
		1. ログイン
		1. 受講者のアカウント作成
		1. 受講者のグループ割り当て
	1. 受講者
		1. ログイン
1. 課題の作成・割り当てテスト
	1. 作成
		1. 題
			1. アップロード上限
	1. 割り当て
		1. ユーザー単位
		1. グループ単位
1. 課題受講確認
	1. DBへの反映
### B. 最新バージョンをインストールする[TBD]
