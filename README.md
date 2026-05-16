

```sh
mdbook serve --hostname 0.0.0.0
```

```sh
./../.cargo/bin/mdbook serve --hostname 0.0.0.0 -p 8000
```

https://rust-lang.github.io/mdBook/cli/serve.html

```sh
firewall-cmd --permanent --zone=public --add-port=8000/tcp
firewall-cmd --reload
firewall-cmd --list-all
```
