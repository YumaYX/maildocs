## メールサーバーの構成と用語整理

メールサーバーの構成を調査する。

メールは、世界中のMTAサーバーが繋がっており、送信者から、受信者へ配送される。

### サーバーサイド

- MTA（Mail Transfer Agent）
    - メールの転送経路を決定する
    - `sendmail`やqmail、Postfixなど
- MDA（Mail Delivery Agent）
    - メールを配送（転送）する
    - MTAのソフトに、MDAの機能を内蔵している
    - サーバー内のローカル配送には`procmail`やmaildropなど
- MRA（Mail Retrieval Agent）
    - POPやIMAPのメール受信のための部分
    - `Dovecot`など

### クライアントサイド

- MUA（Mail User Agent）
    - ユーザーインターフェイスを提供
    - Outlook, Thunderbirdなど

構成要素は、参考文献の[図1　メールサーバの構成要素](https://ascii.jp/elem/000/000/439/439105/#eid439106)にて、わかりやすく解説されている。

## 参考文献

[ASCII.jp：メールを受け取る仕組みはどうなっていますか？？ (1/2)](https://ascii.jp/elem/000/000/439/439105/)


---

## 送信、受信、転送、配送

MUAの送受信と、MTAの送受信は、用語を分けるべきではないか。

```
[MUA]
   |
   | submission
   v
[MTA]
   |
   | relay
   v
[相手MTA]
   |
   | delivery
   v
[Mailbox]
   |
   | retrieve
   v
[相手MUA]
```
