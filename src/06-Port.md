
## 使用プロトコル・ポート一覧

| プロトコル | 暗号化 | ポート番号 |
|---|---|---|
| SMTP (Simple Mail Transfer Protocol) | 平文 | 25 |
| SMTP (Simple Mail Transfer Protocol) | SSL | 465 |
| サブミッションポート（SMTP認証用）| STARTTLS（またはTLS） | 587 |
| POP3 (Post Office Protocol version 3) | 平文 | 110 |
| POP3 (Post Office Protocol version 3) | SSL | 995 |
| IMAP4 (Internet Message Access Protocol 4) | 平文 | 143 |
| IMAP4 (Internet Message Access Protocol 4) | SSL | 993 |

SSLについて：現在はTLSが必須とされている。

## 暗号化について

> このSMTPSやPOP3S/IMAP4Sを利用した場合に暗号化通信で保護される範囲については、しっかり認識しておく必要がある。なぜなら、この技術ではユーザーのPCとメールサーバ間の区間はSSL通信で保護されているが、メールサーバ間、メールサーバと宛先ユーザー間の通信を暗号化するものではないからだ。

メールサーバー間でも暗号化するものではないため、インターネットで平文で流れている可能性はあるということ。

その他に、PGP、S/MIMEがある。<https://note.com/whale999_/n/nedf6ab4501c0>にまとめられている。

## 参考文献

- [ASCII.jp：メールを受け取る仕組みはどうなっていますか？？ (2/2)](https://ascii.jp/elem/000/000/439/439105/2/)
- [SSLとは - IT用語辞典 e-Words](https://e-words.jp/w/SSL.html)
- [docomo Solutions PLUS \| セキュリティーQ&A「SSL」「TLS」にかかわる脆弱性にどう対処する？](https://www.nttcom.co.jp/comware_plus/security/201606_2.html)
- [The GNU Privacy Guard](https://www.gnupg.org/)
- [危険な現状 \| 日経クロステック（xTECH）](https://xtech.nikkei.com/atcl/nxt/mag/nnw/18/061700139/061700001/)

