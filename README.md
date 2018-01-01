# Quick start

```
$ sh create_ca.sh
$ sh create_server.sh
$ go run server.sh
$ curl --cacert ca.crt https://localhost:18443
<html><body>hello sam</body></html>%
```

chrome に `ca.crt` を登録をすると、chrome 上で `https://localhost:18443` にアクセス可能となる。


# Memo: workflow

- `openssl.cnf` を用意
- オレオレ CA を用意
- オレオレサーバー証明書（server.crt）を用意
- サーバをつくる
- chrome からアクセスする

# Memo: CA

```
$ openssl genrsa -out ca.key 2048
$ openssl req -new -sha256 -key ca.key -out ca.csr -config openssl.cnf
$ openssl x509 -in ca.csr -days 365 -req -signkey ca.key -sha256 -out ca.crt -extfile ./openssl.cnf -extensions CA
```

# Memo: server.crt

```
$ openssl genrsa -out server.key 2048
$ openssl req -new -nodes -sha256 -key server.key -out server.csr -config openssl.cnf
$ openssl x509 -req -days 365 -in server.csr -sha256 -out server.crt -CA ca.crt -CAkey ca.key -CAcreateserial -extfile ./openssl.cnf -extensions Server
```

# Memo: check files

```
$ openssl rsa -in ca.key -text
$ openssl req -in ca.csr -text
$ openssl x509 -in ca.crt -text
```
