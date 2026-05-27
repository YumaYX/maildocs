# 587ポートの使用

submissionポートは587にする。

```sh
#sudo sed -i '/submit/ s/^dnl //' /etc/mail/sendmail.mc
```

sendmailがタイムアウトで、サービス自体アップしなかった。ログを確認すると、原因は、Dovecotで587 Submissionを使っていた。想定外だった。

```
sendmail.service: Can't open PID file /run/sendmail.pid (yet?) after start: Operation not permitted
NOQUEUE: SYSERR(root): opendaemonsocket: daemon MSA: cannot bind: Address already in use problem creating SMTP socket
```

しかし、dovecotの認証情報(OSのPAM)を使えるので、587でsubmissionを受けるのはあり。587はそのままdovecotで受ける。sendmailでは、587使用を諦める。

MUAから25番が使われてしまうのを防ぎたい。→MTA側で、MTA(Relay)の接続、MUA(submmision)の接続の判断できないっぽいので、Firewallで制限するらしい(?)。

## Reference

[Submissionポートの適切な設定について : 迷惑メール対策委員会](https://salt.iajapan.org/wpmu/anti_spam/admin/operation/implement/submissionport/)

## 構成の再検討

構成の再検討を行う。

```
[ MUA ]
  |
  | submission
  v
[ MSA:587 -> MTA:25 ]
  |
  | relay, delivery
  v
[ MTA:25 -> MailBox <- MRA:110 ]
  ^
  | retrieve
  |
[ MUA ]
```

## 設定

- 587 port開放
- user:vagrantのパスワードを設定
- /etc/dovecot/conf.d/10-auth.conf `auth_mechanisms = plain login`に変更
    - loginを追加
- /etc/dovecot/conf.d/10-ssl.conf `ssl = yes`に変更
    - 必須ではなく、サポートに変更。
- /etc/dovecot/conf.d/10-master.conf `port = 587`に変更
- /etc/dovecot/conf.d/20-submission.conf 以下追記
    ```
      submission_relay_host = 127.0.0.1
      submission_relay_port = 25
      submission_relay_trusted = yes
    }
    ```
    - `}`を削除
    - 波括弧外にrelay_host, portを追加しているが、無くてもいい。
- epel-releaseを追加して、swaksをインストール
    - swaksでメールを送信
    - TLS
    - HELO & EHLO それぞれ2通サブミット

## 結果

```
    server1: +OK Dovecot ready.
    server1: +OK
    server1: +OK Logged in.
    server1: +OK 3 messages:
    server1: 1 932
    server1: 2 932
    server1: 3 652
    server1: .
    server1: +OK 932 octets
    server1: Return-Path: <vagrant@server1.local>
    server1: Received: from server2.local (server2.local [172.17.64.101])
    server1: 	by server1.local (8.16.1/8.16.1) with ESMTPS id 64RG188r008623
    server1: 	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
    server1: 	for <vagrant@server1.local>; Wed, 27 May 2026 16:01:08 GMT
    server1: Received: from server2.local (localhost [127.0.0.1])
    server1: 	by server2.local (8.16.1/8.16.1) with ESMTP id 64RG18d7006875
    server1: 	for <vagrant@server1>; Wed, 27 May 2026 16:01:08 GMT
    server1: Received: from server1 ([172.17.64.100])
    server1: 	by server2.local with ESMTPSA
    server1: 	id T4u/IkQVF2raGgAAk97zeA
    server1: 	(envelope-from <vagrant@server1>)
    server1: 	for <vagrant@server1>; Wed, 27 May 2026 16:01:08 +0000
    server1: Date: Wed, 27 May 2026 16:01:08 +0000
    server1: To: vagrant@server1.local
    server1: From: vagrant@server1.local
    server1: Subject: test Wed, 27 May 2026 16:01:08 +0000
    server1: Message-Id: <20260527160108.008292@>
    server1: X-Mailer: swaks v20240103.0 jetmore.org/john/code/swaks/
    server1: 
    server1: This is a test mailing
    server1: 
    server1: 
    server1: .
    server1: +OK 932 octets
    server1: Return-Path: <vagrant@server1.local>
    server1: Received: from server2.local (server2.local [172.17.64.101])
    server1: 	by server1.local (8.16.1/8.16.1) with ESMTPS id 64RG18VE008626
    server1: 	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
    server1: 	for <vagrant@server1.local>; Wed, 27 May 2026 16:01:09 GMT
    server1: Received: from server2.local (localhost [127.0.0.1])
    server1: 	by server2.local (8.16.1/8.16.1) with ESMTP id 64RG18WU006883
    server1: 	for <vagrant@server1>; Wed, 27 May 2026 16:01:08 GMT
    server1: Received: from server1 ([172.17.64.100])
    server1: 	by server2.local with ESMTPSA
    server1: 	id gwqZOEQVF2riGgAAk97zeA
    server1: 	(envelope-from <vagrant@server1>)
    server1: 	for <vagrant@server1>; Wed, 27 May 2026 16:01:08 +0000
    server1: Date: Wed, 27 May 2026 16:01:08 +0000
    server1: To: vagrant@server1.local
    server1: From: vagrant@server1.local
    server1: Subject: test Wed, 27 May 2026 16:01:08 +0000
    server1: Message-Id: <20260527160108.008622@>
    server1: X-Mailer: swaks v20240103.0 jetmore.org/john/code/swaks/
    server1: 
    server1: This is a test mailing
    server1: 
    server1: 
    server1: .
    server1: +OK 652 octets
    server1: Return-Path: <vagrant@server1.local>
    server1: Received: from server2.local (server2.local [172.17.64.101])
    server1: 	by server1.local (8.16.1/8.16.1) with ESMTPS id 64RG1Eki008633
    server1: 	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
    server1: 	for <vagrant@server1.local>; Wed, 27 May 2026 16:01:14 GMT
    server1: Received: from server1 (server1.local [172.17.64.100])
    server1: 	by server2.local (8.16.1/8.16.1) with SMTP id 64RG1EVQ006886
    server1: 	for <vagrant@server1>; Wed, 27 May 2026 16:01:14 GMT
    server1: Date: Wed, 27 May 2026 16:01:14 GMT
    server1: From: vagrant@server1.local
    server1: Message-Id: <202605271601.64RG1EVQ006886@server2.local>
    server1: Subject: this is a testmail ABC
    server1: 
    server1: this is a testmail EFG
    server1: .
    server1: +OK Logging out.
```

- retrieveの110は今後検討する。
- そもそも感があるが、sendmail使用自体が。。

