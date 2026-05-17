## Procmail

### install

Sendmailインストール時に、一緒にインストールされる。

```sh
#確認方法
rpm -qa procmail

grep 'local_procmail' /etc/mail/sendmail.mc
```

### setting

[Sendmail with Maildir](https://ya.maya.st/mail/sendmail-maildir.html)にあるとおり、

> /etc/procmailrc または maildroprcでDEFAULT=$HOME/Maildir/と書いておけばいい(procmail も maildrop も同じ)。イヤミったらしくダラダラと書いてきたが、実際におこなうべき作業はたったのこれだけである。難しいことは何もない。

/etc/procmailrcを作成する。

```sh
cat <<'PROCMAILEOF' | tee /etc/procmailrc
MAILDIR=$HOME/Maildir
DEFAULT=$MAILDIR
LOGFILE=$HOME/procmail.log
VERBOSE=on
PROCMAILEOF
```

詳細は各自。

