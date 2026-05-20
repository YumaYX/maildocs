
## なりすましメール防止策

### SPF

SPF（Sender Policy Framework）：メール送信元のドメイン名とIPアドレスを照合する。
SPFはメール転送等により受信側で正しく判断できない場合もある[SPF（Sender Policy Framework） : 迷惑メール対策委員会](https://salt.iajapan.org/wpmu/anti_spam/admin/tech/explanation/spf/)。

> ![SPFの仕組み](https://ent.iij.ad.jp/wp-content/uploads/2019/07/0726-spf-01.png)

[送信ドメイン認証（SPF / DKIM / DMARC）の仕組みと、なりすましメール対策への活用法を徹底解説 – エンタープライズIT [COLUMNS]](https://ent.iij.ad.jp/articles/172/)より。

#### 送信側

メール使用時に利用するサーバーのIPアドレスをDNSのSPFレコードとして事前に登録

#### 受信側

メール受信時に送信側のSPFレコードと照合

送信元IPアドレスは、グローバルIPアドレスが基本。送信元組織の出口のグローバルIPアドレスらしい、図からも読み取れる。

### DKIM

DKIM（DomainKeys Identified Mail）:電子署名を利用してメール送信元が詐称されていないかどうかを確認する。

- メールサーバーに、秘密鍵
    - MTAで、電子署名化
- DNSサーバーに、公開鍵

送信側(MTA)が署名して、受信者(MTA)がDNSの鍵から、検証する。

> ![電子署名の情報で認証](https://ent.iij.ad.jp/wp-content/uploads/2019/07/0726-spf-02.png)

### DMARC

> これはSPFやDKIMの認証が失敗した場合の対応策を定めたもの。送信側は受信側の認証失敗時の推奨アクションをDNSに「DMARCポリシー」として宣言しておき、受信側は認証失敗時にこのDMARCポリシーを参照して、受信メールをどう扱うか判断します

定義されているDMARCポリシーによって、受け取るか、隔離するか、拒否するかなど、分岐できる。


## Reference

[送信ドメイン認証（SPF / DKIM / DMARC）の仕組みと、なりすましメール対策への活用法を徹底解説 – エンタープライズIT [COLUMNS]](https://ent.iij.ad.jp/articles/172/)


---

## おまけ1

### S/MIMEとDKIMは何が違う？

- S/MIME: Secure / Multipurpose Internet Mail Extensions
- 公開鍵の正当性は CA（認証局）が署名することで保証される。
- MUA(Outlookや、Thunderbird)上で設定する。

| 項目 | S/MIME | DKIM |
| ------ | ---------- | ---------- |
| 主目的 | 内容の保護 | 送信元の証明 |
| 暗号化 | できる | しない |
| 使う場所   | MUAメールクライアント間 | MTAメールサーバー間 |

[S/MIMEとは？メールへの電子署名と暗号化の仕組み｜GMOグローバルサイン【公式】](https://jp.globalsign.com/clientcert/about-smime.html)

## おまけ2

2024年に、大手電子メールプロバイダーのGoogle、Yahooはセキュリティ対策の導入を義務付けている。

### Reference

- [より安全で迷惑メールの少ない受信トレイを実現する新しい Gmail のポリシーについて](https://blog.google/intl/ja-jp/products/connect-communicate/gmail-security-authentication-spam-protection-jp/)
- [【2026年の最新情報あり】2024年2月に改訂されたGmail送信者ガイドラインについて \| エンバーポイント株式会社](https://emberpoint.com/blog/column/240808-003.html)