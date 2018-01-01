openssl genrsa -out ca.key 2048
openssl req -new -sha256 -key ca.key -out ca.csr -config openssl.cnf
openssl x509 -in ca.csr -days 365 -req -signkey ca.key -sha256 -out ca.crt -extfile ./openssl.cnf -extensions CA
