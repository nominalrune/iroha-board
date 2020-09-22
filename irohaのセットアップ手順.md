# iroha-board Dockerizedのセットアップ手順

## 前提知識
- Windows10の基礎的なファイル操作の知識
## 環境
- Windows10 Home build 19041 以降
- [WSL2]()が導入済であること
- [Docker for Windows]() version 19.03.12 以降が導入済であること
- [git]() が導入済であること

## セットアップ手順

### A. 2020.09.23 現在のバージョンでインストールする
- 以下のバージョンがインストールされます
	- Iroha Board 0.10.4
	- CakePHP 2.10.20
	- MySQL latest (8.0.21)
	- PHP latest (9.4.10)
1. 環境準備
	1. iroha boardプロジェクト用のフォルダを用意
	2. そのフォルダに、横山によるソースセットを丸ごとコピー
	（2020_09_23 現在は https://github.com/nominalrune/iroha-board-Dockerized.git に公開している。社内向けに、安定的な場所に移動予定）
		- GitHubからリポジトリをクローン
			```terminal
			git clone https://github.com/nominalrune/iroha-board-Dockerized.git
			```
	1. 設定
		2. MySQLのパスワードを設定する
			1. ルートパスワード（デフォルトでは`root`）
				1. MySQL側の設定
					1. `docker-compose.yml`内の環境変数`MYSQL_ROOT_PASSWORD`の値を変更
				2. iroha board側の設定
					1. `iroha-board-Dockerized/apache/html/app/Config`内`database.php`の`'password'`変数をMySQLでのパスワードに合わせる
2. `docker-compose`によるイメージのビルドと起動
	2. ターミナルで、iroha boardプロジェクトのディレクトリを開く
	(`docker-compose.yml`のあるディレクトリ)
	3. コンテナからイメージを作成
		```terminal
		docker-compose up --build
		```
	4. サービスが起動するまで待つ
		- mysqlイメージが
			```terminal
			[System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.21'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server - GPL.
			```
			というメッセージを出して待機状態になれば完了
3. 動作確認・初期登録
	5. ウェブブラウザを開き、`127.0.0.1:10800/install`にアクセスする
	6. 管理者名をrootとしてログイン
	7. テスト用受講者アカウントを作成
	8. 課題の作成・割り当て
	4. 課題受講確認
### B. 最新バージョンをインストールする
4. Iroha Boardの入手