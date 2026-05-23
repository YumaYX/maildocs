
# sendmail config files

- /etc/mail/access
    - MTAリレーの許可を記載するファイル
- /etc/mail/aliasesdb-stamp
- /etc/mail/domaintable
    - ドメイン名そのものを別ドメインに書き換えるための設定
    - ドメイン移転、複数ドメインの統合など、引越しの時に使われる。
- /etc/mail/helpfile
    - SMTPのHELPコマンドに対してサーバーが返す応答内容を記録したテキストファイル
- /etc/mail/local-host-names
    - 受信デリバリーするドメインを登録するファイル
- /etc/mail/mailertable
    - どのメールをどの配送方法（ルート）で送るか」を制御する設定
    - ドメイン単位・経路単位の"配送ルーティング表"
- /etc/mail/sendmail.mc
    - Sendmailのコンフィグファイル
- /etc/mail/submit.mc
    - ローカルから送信されるメール（submitd経由）の動作を定義する設定ファイル
- /etc/mail/trusted-users
- /etc/mail/virtusertable
    - 受信したメールの「宛先アドレス」を別のユーザーや外部アドレスに転送するための設定ファイル
- /etc/aliases
    - メールアドレスのエイリアス（別名）を設定するファイル
    - ローカルマシン内のユーザー名・エイリアスを別宛先へ転送する仕組み

---

- make
    - /etc/mail/make
    - /etc/mail/Makefile
- db
    - /etc/mail/access.db
    - /etc/mail/domaintable.db
    - /etc/mail/mailertable.db
    - /etc/mail/virtusertable.db
- cf
    - /etc/mail/sendmail.cf
    - /etc/mail/submit.cf

## Reference

[Sendmailの設定ファイル解説：サーバ設定情報の確認方法と設定例](https://zenn.dev/pe_yan/articles/301837aefce49b)

