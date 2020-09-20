# iroha-board Dockerizedのセットアップ手順
## 前提知識
- Windows10のGUI・CUIにおける基礎的なファイル操作の知識
- google検索
## 環境
- Windows10 Home build1909
- [WSL2]()が導入済であること
- [git]() が導入済であること
- [Docker for Windows]() version x.x以降が導入済であること（`docker-compose`コマンドの実行可能ファイルにパスが通してあること）

## セットアップ手順
### A. 2020.09.09現在のバージョン（筆者の設定で動作が確認できたバージョン）でインストールする
1. 環境準備
	1. 運用に適しているフォルダを用意する
	2. そのフォルダに、横山によるリソースセットを丸ごとコピーする
	（2020_09_19現在は https://github.com/nominalrune/iroha-board-Dockerized.git に公開している。・社内向けに、安定的な場所に移動予定）
		1. ```terminal
			git clone https://github.com/nominalrune/iroha-board-Dockerized.git
			```
2. `docker-compose`によるサービス構築と起動
	3. ターゲットディレクトリにてターミナルを開き、`docker-compose up --build`をコマンド
	4. コンテナからイメージへのビルド作業が終了し、サービスが起動するまで待つ
		1. mysqlイメージが`hogehoge`というメッセージを出して待機している状態になれば完了したと考えてよい。
3. 動作確認・初期登録
	5. サービスが動作しているか確認する。
		1. ウェブブラウザを開き、URL`127.0.0.1:10800/install`をアドレスとして貼り付ける。
		2. 管理者をrootとしてログイン
		3. 受講者アカウントを２つ作成
		4. 
			1. 課題の作成
				1. 全種類の課題を設定
			2. 
		5. 
		6. ### B. 最新バージョンをインストールする
4. Iroha Boardの入手