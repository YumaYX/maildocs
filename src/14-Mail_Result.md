## メール送信記録確認

telnetでの打鍵がメールにどのように反映されているか、確認する。コマンドなどは既出のものを使用する。

### 送信

- フロー: `server1(Client)` => `server2(SMTP Server)` => `server1(SMTP Server)`
- `server2:25`に接続。telnetにて、メール送信。

```
[vagrant@server1 ~]$ telnet server2 25
Trying 172.17.64.101...
Connected to server2.
Escape character is '^]'.
220 server2.local ESMTP Sendmail 8.16.1/8.16.1; Wed, 20 May 2026 13:13:34 GMT
HELO server1
250 server2.local Hello server1.local [172.17.64.100], pleased to meet you
MAIL FROM:<vagrant@server2>
250 2.1.0 <vagrant@server2>... Sender ok
RCPT TO:<vagrant@server1>
250 2.1.5 <vagrant@server1>... Recipient ok
DATA
354 Enter mail, end with "." on a line by itself
Subject: this is a testmail ABC

this is a testmail EFG
.
250 2.0.0 64KDDYBB006414 Message accepted for delivery
QUIT
221 2.0.0 server2.local closing connection
Connection closed by foreign host.
[vagrant@server1 ~]$ 
```

下のリファレンス通りのリターンコードとなっている。

#### リターンコード

##### 正常

| code | description |
| --- | --- |
| ２２０ | サービス開始 |
| ２２１ | サービス終了 |
| ２５０ | 要求処理完了 |
| ３５４ | データ入力開始（．だけの行で入力完了） |

[電子メール＜アプリケーションプロトコル＜ネットワーク＜Ｗｅｂ教材＜木暮仁](https://www.kogures.com/hitoshi/webtext/nw-mail/index.html)より。

### 結果

```
[vagrant@server1 ~]$ cat Maildir/new/1779282857.6584_0.server1.local 
Return-Path: <vagrant@server2.local>
Received: from server2.local (server2.local [172.17.64.101])
        by server1.local (8.16.1/8.16.1) with ESMTPS id 64KDEHgA006582
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
        for <vagrant@server1.local>; Wed, 20 May 2026 13:14:17 GMT
Received: from server1 (server1.local [172.17.64.100])
        by server2.local (8.16.1/8.16.1) with SMTP id 64KDDYBB006414
        for <vagrant@server1>; Wed, 20 May 2026 13:13:58 GMT
Date: Wed, 20 May 2026 13:13:34 GMT
From: vagrant@server2.local
Message-Id: <202605201313.64KDDYBB006414@server2.local>
Subject: this is a testmail ABC

this is a testmail EFG
[vagrant@server1 ~]$ 
```

- `Return-Path`
    - メールが宛先に届かなかった際のエラーメール（バウンスメール）の送信先を指定するメールヘッダー情報
    - 自動で入っている、特に指定していない。
- `Received`
    - Received: from 送信元ホスト名、ＩＰアドレス
    - by 受信（中継）サーバ名 with SMTPなどの転送方法 id 転送時のID番号
    - for 宛先のメールアドレス; 処理時刻
    - `ESMTPS`:server2 → server1 の通信は TLS（暗号化あり）
        - `ESMTP + TLSで保護された通信`を表す表示（ログ上の呼称）
        - 裏で、`HELO`ではなく`EHLO`が送信され、ESMTPが使用された。
        - EHLOへの応答で`TLS対応できる`ので`STARTTLS`が使用されている。
        - その結果、暗号化後のSMTP通信として`ESMTPS`と記録されている
        - Port485の使用は、なかった。25のみ開放状態で、SMTPリレーされた。
    - `verify=NOT`により、証明書検証なしということを示す。
- toとかccは表示されていないが、記載がないと、スパム判定の可能性などがあり得る。実務では付与する。


## Reference

- [STARTTLS](https://e-words.jp/w/STARTTLS.html)

---

## DNS SPFレコード

メール専用として上で、説明した用途で使われる。リスト化した一種のDNS TXTレコード。

### Reference

[DNS SPFレコードとは？ \| Cloudflare](https://www.cloudflare.com/ja-jp/learning/dns/dns-records/dns-spf-record/)
