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
- ちなみにユーザー`vagrant`には、初期パスワードは設定されていない。


## 結果

```
    server1: ####### MAILDIR #######
    server1: +OK Dovecot ready.
    server1: +OK
    server1: +OK Logged in.
    server1: +OK 1 messages:
    server1: 1 652
    server1: .
    server1: +OK 652 octets
    server1: Return-Path: <vagrant@server2.local>
    server1: Received: from server2.local (server2.local [172.17.64.101])
    server1: 	by server1.local (8.16.1/8.16.1) with ESMTPS id 64H6uAJL006512
    server1: 	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
    server1: 	for <vagrant@server1.local>; Sun, 17 May 2026 06:56:10 GMT
    server1: Received: from server1 (server1.local [172.17.64.100])
    server1: 	by server2.local (8.16.1/8.16.1) with SMTP id 64H6uADp006402
    server1: 	for <vagrant@server1>; Sun, 17 May 2026 06:56:10 GMT
    server1: Date: Sun, 17 May 2026 06:56:10 GMT
    server1: From: vagrant@server2.local
    server1: Message-Id: <202605170656.64H6uADp006402@server2.local>
    server1: Subject: this is a testmail ABC
    server1:
    server1: this is a testmail EFG
    server1: .
    server1: +OK Logging out.
```

