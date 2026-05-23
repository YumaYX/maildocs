
# 587ポートの使用

- submissionポートは587にする。
- 上とは別で、リレー用のポートを587にすることもできる。
    - リレーを587にする人いるのか？

```sh
#sudo sed -i 's@, M=Ea@@g' /etc/mail/sendmail.mc
#sudo sed -i 's@M=Ea@M=E@g' /etc/mail/sendmail.mc
#sudo sed -i 's@^dnl DAEMON_OPTIONS(`Port=submission@DAEMON_OPTIONS(`Port=submission@g' /etc/mail/sendmail.mc
```

実施してみたが、EHLOで試したり、M=を消したり、調整したが、メールがリレーされなかった。タイムアウトで、sendmail.serviceが上がってこない。

MUAから25番が使われてしまうのを防ぎたい。→MTA側で、MTA(Relay)の接続、MUA(submmision)の接続の判断できないっぽいので、Firewallで制限するらしい。


## Reference

[Submissionポートの適切な設定について : 迷惑メール対策委員会](https://salt.iajapan.org/wpmu/anti_spam/admin/operation/implement/submissionport/)
