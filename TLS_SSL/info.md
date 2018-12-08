

## p12
Conversion from `.jks` (will ask for in/out passwords):

`keytool -importkeystore -srckeystore store.jks -destkeystore store.p12
-deststoretype PKCS12`



Content: `openssl pkcs12 -info -in store.p12`


Export _certificate_:
`openssl pkcs12 -in keystore.p12  -nokeys -out cert.pem`

Export  _private key_:
`openssl pkcs12 -in keystore.p12  -nodes -nocerts -out key.pem`


Generate self-signed key&&certificate pair:

`keytool -genkeypair -alias aaa -storetype PKCS12 -keyalg RSA -keysize 1024 -keystore store.p12 -validity 36000`

in openssl (--> CAkey.pem, myCA.crt):

`openssl req -x509 -sha256 -newkey rsa:2048 -keyout CAkey.pem -out myCA.crt -days 30000`
(openssl verify -CAfile CA/myCA.crt CA/myCA.crt  --> gives OK)





## certificates
`CN` is the domain name; it can be `*.pets.com`; if more domains are needed,
one goes into `CN` and then is repeated with other in the `SAN` field (Subject
Alternative Name).

* Details: `openssl x509 -noout -text -in cert.pem`

* Verification: `openssl verify -CAfile ca.crt cert.pem`

* Details of CSR: `openssl req -noout -text -in server.csr`


-----------
¡ Modern browsers require `v3` certificate extensions, with `CN`
also in `SAN` (Subject Alternative Name).

1. Generate server key:

`openssl genrsa -passout pass:password -des3 -out server.key 2048`

2. Generate CSR (needs server.conf):

`openssl req -passin pass:password -new -key server.key -out server.csr -config <( cat server.conf )`

3. Sign CSR by own CA (needs server_v3.ext):

`openssl x509 -req -in server.csr -CA CA/myCA.crt -CAkey CA/CAkey.pem -CAcreateserial -out server.crt -days 1500 -sha256 -extfile server_v3.ext`

4. Combine .key and .crt into single .p12 keystore:

`openssl pkcs12 -export -out store.p12 -inkey server.key -in server.crt`

---

`server.conf`:

```
[req]
default_bits = 2048
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[ dn ]
C=PL
ST=PL
L=KR
O=IT
OU=Onboarding
emailAddress=mareckip@ubs.com
CN = localhost

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = localhost
```

`server_v3.ext`

```
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
```


---
### Utils
Public key from certificate: `openssl x509 -inform pem -in cert.pem -pubkey -noout > server_pub.pem`

Encode message: `openssl rsautl -encrypt -inkey test1.pub.pem -pubin -in wiad.txt -out wiad.enc`

Decode message: `openssl rsautl -decrypt -inkey ../private/test1.key.pem -in wiad.enc -out www.txt`

## jks

Content: `keytool -list -keystore dev1.jks`

result:

```
xldn4646vdap.ldn.swissbank.com, Feb 27, 2015, PrivateKeyEntry,
Certificate fingerprint (SHA1): 71:0B:B8:CB:0D:D6:F0:54:96:7C:16:A5:72:79:CC:82:85:9E:CC:51
ubstest1, Feb 27, 2015, trustedCertEntry,
Certificate fingerprint (SHA1): F5:E9:CB:E7:B7:F5:81:86:A5:47:EE:80:5D:FC:5B:33:48:84:80:BB

```

## Keys

Formats:

`.pem` : is plain text, with `--BEGIN CETRIFICATE--` (or similar); can be key, certificate, whatever

`.jks` : keystore (with keys & certificates) in java format

`.p12, .pkcs12` : keystore (with keys & certicifates) in PKCS12 format (standarized)

`.key` : usually encoded private key

`.crt, .cert` : usually public key, with domain, signed by some CA

`ca.crt` : usually some certificate authority (or a chain of trust)
