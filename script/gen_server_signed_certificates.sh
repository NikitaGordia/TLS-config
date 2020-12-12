keytool -genkeypair \
        -keyalg RSA \
        -keysize 2048 \
        -alias localhost\
        -dname "CN=localhost,OU=Development,O=KPI,C=DE" \
        -ext BC:c=ca:false \
        -ext EKU:c=serverAuth \
        -ext "SAN:c=DNS:localhost,IP:127.0.0.1" \
        -validity 3650 \
        -keystore ./server/server.jks \
        -storepass password \
        -keypass password

keytool -certreq \
        -keystore ./server/server.jks \
        -storepass password \
        -alias localhost \
        -keypass password \
        -file ./server/server.csr

keytool -gencert \
        -keystore ./root-ca/ca.jks \
        -storepass password \
        -infile ./server/server.csr \
        -alias root-ca \
        -keypass password \
        -ext BC:c=ca:false \
        -ext EKU:c=serverAuth \
        -ext "SAN:c=DNS:localhost,IP:127.0.0.1" \
        -validity 3650 \
        -rfc -outfile ./server/server.pem

keytool -importcert \
        -noprompt \
        -keystore ./server/server.jks \
        -storepass password \
        -alias root-ca \
        -keypass password \
        -file ./root-ca/ca.pem

keytool -importcert \
        -noprompt \
        -keystore ./server/server.jks \
        -storepass password \
        -alias localhost \
        -keypass password \
        -file ./server/server.pem