
# 587ポートの使用

submissionポートは587にする。

```sh
#sudo sed -i '/submit/ s/^dnl //' /etc/mail/sendmail.mc
```

実施してみたが、認証なし、で587ができなかった。SASLが足りないのかもしれない。未確認。MTAの行をコメントアウトして、有効行が無いのが原因かもしれない。

MUAから25番が使われてしまうのを防ぎたい。→MTA側で、MTA(Relay)の接続、MUA(submmision)の接続の判断できないっぽいので、Firewallで制限するらしい(?)。

## Reference

[Submissionポートの適切な設定について : 迷惑メール対策委員会](https://salt.iajapan.org/wpmu/anti_spam/admin/operation/implement/submissionport/)

