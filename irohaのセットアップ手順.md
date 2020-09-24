# iroha-board Dockerizedのセットアップ手順
last updated: 2020.09.24

---
目次
[TOC]
---
- この文書で説明すること
	- Docker for Windows上でiroha boardサービスをセットアップする方法

- この文書で説明しないこと
	- iroha board自体の説明
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
1. プロジェクトフォルダ作成
	1. iroha boardプロジェクト用のフォルダを作成する
1. iroha boardのダウンロード
	1. プロジェクトフォルダに、横山によるソースセットを丸ごとコピーする
	<small>（2020.09.23 現在は https://github.com/nominalrune/iroha-board-Dockerized.git に公開している。社内向けに、安定的な場所に移動予定）</small>
		- 例：GitHubからリポジトリをクローン・ブランチ作成
			```terminal
			git clone https://github.com/nominalrune/iroha-board-Dockerized.git　.
			git checkout -b lbProjectTest
			```
1. 設定
	1. MySQLのパスワード設定
		1. rootパスワード（デフォルトでは`root`）
			1. MySQL側の設定
				1. `docker-compose.yml`内の環境変数`MYSQL_ROOT_PASSWORD`の値を変更
			１. iroha board側の設定
				1. ディレクトリ`iroha-board-Dockerized/apache/html/app/Config`内にある、`database.php`の`'password'`変数をMySQLでのパスワードに合わせる
#### イメージのビルドと起動
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
		1. N種類の課題
			1. アップロード上限
	1. 割り当て
		1. ユーザー単位
		1. グループ単位
1. 課題受講確認
	1. DBへの反映
### B. 最新バージョンをインストールする[TBD]
