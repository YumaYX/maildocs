## Dovecot

受信側を設定する。受信側といっても、サーバーでは受信しており、クライアントからメールを引っ張ってくるだけの話。

### install

```sh
dnf -y install dovecot
```

### setting

#### プロトコル設定

```sh
sed -i 's/^#protocols/protocols/g' /etc/dovecot/dovecot.conf
```

#### Mailbox

procmailに合わせる(`~/Maildir`)。

```sh
sed -i 's@^#   mail_location = maildir@   mail_location = maildir@g' /etc/dovecot/conf.d/10-mail.conf
```

#### 暗号化

証明書など無いので、一部設定を変える。

```sh
sed -i 's@^ssl = required@ssl = no@g' /etc/dovecot/conf.d/10-ssl.conf
```

### 最後に再起動

```sh
systemctl restart dovecot
```

クライアント側から接続確認 => `POP3`:`110`で接続する。

```sh
{
  echo USER vagrant
  echo PASS vagrant
  echo LIST
  echo QUIT
} | nc localhost 110
```

- Q. なぜ接続情報がわかるのか？
    - A. /etc/dovecot/conf.d/に、PAMで認証する設定があるので、そこで判断できる。
- ちなみに`vagrant`には、初期パスワードは設定されていない。


