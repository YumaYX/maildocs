## 本稿で扱うソフトウェア

以下のソフトウェアを動作させる。

- sendmail
- procmail
- dovecot

検証用の環境について

- プログラムの動作確認は、Vagrantで行う。コンフィグファイル修正は、基本的にsedで行う。
- Vagrantの挙動として、共通SHELLの後に、個別SHELLが打鍵される。複数サーバーがあるので、前後する可能性がある。
- DNSサーバーは構築しない。

## 実装目標

- メール送信
    - server1 -SMTP-> server2 -SMTP-> server1
    - メールはユーザーのホーム下Maildir/{new, cur, tmp}に保存するようにする。
- メール受信
    - ファイルではなく、プロトコルを使ってメールを確認できること。
    - 接続の暗号化は無し。

### 実装パラメーター

- 172.17.64.100 
    - hostname server1.local
    - mail: vagrant at server1
- 172.17.64.101
    - hostname server2.local
    - mail: vagrant at server2

