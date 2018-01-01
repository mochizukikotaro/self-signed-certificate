openssl genrsa -out server.key 2048
openssl req -new -nodes -sha256 -key server.key -out server.csr -config openssl.cnf
openssl x509 -req -days 365 -in server.csr -sha256 -out server.crt -CA ca.crt -CAkey ca.key -CAcreateserial -extfile ./openssl.cnf -extensions Server
