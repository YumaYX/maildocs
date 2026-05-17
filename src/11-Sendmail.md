## Sendmail

本稿では、Sendmailを使用する。

2026/5時点で、RHELからSendmailの使用は非推奨となっているため、本番環境では使用出来ない。

> Sendmail：古くからある標準的なMTAで、柔軟性が高い反面、設定が難解
> Postfix：Sendmail互換でありながら、セキュリティと性能が向上しており、設定が簡潔

<https://blog.serverspt.com/detail/39>より。

## install

```sh
sudo dnf -y install sendmail m4 sendmail-cf
# 8.16.1-11.el9 
# systemctl enable --now sendmail
```

```sh
sudo m4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf
# サービス停止起動では、regenerateされない。
sudo systemctl restart sendmail
```

## setting

### /etc/mail/sendmail.mc

dnl:Delete to New Lineなので、dnlはコメント行

smtpを受け付けるネットワーク範囲の設定。有効行の場合、localhostのみ。なしor無効行の場合、全リッスン。

```
DAEMON_OPTIONS(`Port=smtp,Addr=127.0.0.1, Name=MTA')dnl
```

```
sudo sed -i 's@^DAEMON_OPTIONS(@dnl DAEMON_OPTIONS(@g' /etc/mail/sendmail.mc
```

### /etc/mail/access

メール転送の中継を制御（許可や拒否）する設定ファイル。

> Connect: 受信メールの接続を開始したリモートシステムのIPアドレスを、条件テストと照合 (connection information ${client_addr}, ${client_name}))
> To: メッセージエンベロープの受信者アドレス(Envelop の RCPT TO の部分)を、条件テストと照合 (envelop recipient)
> From: メッセージエンベロープの送信者アドレス(Envelop の MAIL FROM の部分)を、条件テストと照合 (envelop sender)


> OK: 他のルールにより拒否されるメールでもacceptする
> RELAY: リレーを許可する (trasmission of messages from a site outside your host (class{w}) to another site except yours)
> REJECT: 拒否する

[sendmailのインストール](https://www.bigbang.mydns.jp/sendmail-xx.htm#access)

```
# /はor。実際には、ひとつずつ選択する。
Connect/To/From:domain OK/RELAY/REJECT
```

- server1.local から接続してきたクライアントにはリレーを許可する
- /etc/mail/access.dbを手動で生成する必要はなかった。sendmailを再起動しているから？
- server1より、connect:server1.local realyは動作した。to:server1は動作しなかった。
    - server2からメールを送ると、メールが送られる。他の設定に要因がありそう。

### /etc/mail/local-host-names

server1側：

メール受け取りドメイン設定コンフィグ。

```sh
sudo cat <<'LHN' | sudo tee /etc/mail/local-host-names
server1
LHN
```

### /etc/mail/mailertable

server2側：

特定ドメイン宛てのメールの配送先や配送方法（メーラ）を制御するためのルーティングテーブル。

今回はDNS不使用、MXレコードが使えないため、設定が必要となる。

```sh
cat <<'EOF' | sudo tee /etc/mail/mailertable
server1    esmtp:[172.17.64.100]
EOF
```

## メール送信

```sh
sudo dnf -y install telnet nc

{
  echo "HELO server1"
  echo "MAIL FROM:<vagrant@server2>"
  echo "RCPT TO:<vagrant@server1>"
  echo "DATA"
  echo "Subject: this is a testmail ABC"
  echo ""
  echo "this is a testmail EFG"
  echo "."
  echo "QUIT"
} | nc server2 25
```

