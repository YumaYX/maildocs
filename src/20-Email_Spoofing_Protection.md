
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

送信側(MTA)が署名して、受信者がDNSの鍵から、検証する。

> ![電子署名の情報で認証](https://ent.iij.ad.jp/wp-content/uploads/2019/07/0726-spf-02.png)

### DMARC

> これはSPFやDKIMの認証が失敗した場合の対応策を定めたもの。送信側は受信側の認証失敗時の推奨アクションをDNSに「DMARCポリシー」として宣言しておき、受信側は認証失敗時にこのDMARCポリシーを参照して、受信メールをどう扱うか判断します

定義されているDMARCポリシーによって、受け取るか、隔離するか、拒否するかなど、分岐できる。


## Reference

[送信ドメイン認証（SPF / DKIM / DMARC）の仕組みと、なりすましメール対策への活用法を徹底解説 – エンタープライズIT [COLUMNS]](https://ent.iij.ad.jp/articles/172/)
