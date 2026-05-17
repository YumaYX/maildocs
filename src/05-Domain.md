
## ドメイン、MXレコードについて

ドメインのMXレコードは、電子メールの配送先であるメールサーバーを決定する際に使用するものである。

| record | domain |
| --- | --- |
| Aレコード | example.com |
| MXレコード | mail.example.com |

## MXレコードの名前解決

MTAから、`user@example.com`にメールが送られる場合：

1. メールアドレスのドメイン(example.com)でDNS問い合わせ
1. MXレコードを取得(mail.example.com)
1. MXレコードのドメイン名をDNS問い合わせ
1. IPアドレスを取得した上で、SMTPなどの通信を行う。

MXレコードが登録されていない場合、Aレコードが使用されることがある（[MXレコードとは？優先度と確認方法 \| Proofpoint JP](https://www.proofpoint.com/jp/threat-reference/mx-record)）。

## メールアドレスのドメインをIPアドレス指定できないか

RFC上は、可能として定義されている（\[\]で指定する）が、そのように実装されないのが通常。

## 参考文献

[【ドメイン】MXレコードの設定方法は？\｜ヘルプ \| ドメイン取るならお名前.com](https://help.onamae.com/answer/7889)
