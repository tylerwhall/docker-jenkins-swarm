ROOT_KEY=ca.key
CA_CERT=ca.crt

all: $(CA_CERT)

$(ROOT_KEY):
	openssl genrsa -out $@ 2048

$(CA_CERT): $(ROOT_KEY)
	openssl req -config openssl.cnf -x509 -new -nodes -days 3650 -key $< -out $@ -extensions v3_ca


ca.srl:
	echo 02 > $@

.PRECIOUS: %.key
%.key:
	openssl genrsa -out $@ 2048

%.csr: %.key
	openssl req -config openssl.cnf -new -days 3650 -key $< -out $@

%.crt: %.csr $(CA_CERT) $(ROOT_KEY) ca.srl
	openssl x509 -req -days 3650 -in $< -CA $(CA_CERT) -CAkey $(ROOT_KEY) -out $@ -extfile openssl.cnf -extensions v3_req

clean::
	rm -f *.crt *.srl *.key
