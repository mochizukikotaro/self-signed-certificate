# 備忘録

Golang でローカルにサーバをつくります。
そして、chrome から `https://localhost:18443` でアクセスできるようにします。

# 流れ

- `openssl.cnf` を用意
- オレオレ CA を用意
- オレオレサーバー証明書（server.crt）を用意
- サーバをつくる
- chrome からアクセスする

# `openssl.cnf` を用意

僕は Mac なのですが `/etc/ssl/openssl.cnf` というのがありました。これを元にいくつか追記しました。

# CA (Certificate Authority) を用意する

```
$ openssl genrsa -out ca.key 2048
$ openssl req -new -sha256 -key ca.key -out ca.csr -config openssl.cnf
$ openssl x509 -in ca.csr -days 365 -req -signkey ca.key -sha256 -out ca.crt -extfile ./openssl.cnf -extensions CA
```

# サーバ証明書を用意する

```
$ openssl genrsa -out server.key 2048
$ openssl req -new -nodes -sha256 -key server.key -out server.csr -config openssl.cnf
$ openssl x509 -req -days 365 -in server.csr -sha256 -out server.crt -CA ca.crt -CAkey ca.key -CAcreateserial -extfile ./openssl.cnf -extensions Server
```

それぞれ確認したい場合は以下。

```
$ openssl rsa -in ca.key -text
$ openssl req -in ca.csr -text
$ openssl x509 -in ca.crt -text
```

# サーバを立てる

```
$ go run server.go
```
