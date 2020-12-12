#Create keystore and generate both public and private keys valid for 10 years
keytool -genkeypair \
        -keyalg RSA \
        -keysize 2048 \
        -alias root-ca \
        -dname "CN=Nikita Gordia CA,OU=Development,O=KPI,C=UA,L=Kremenchug" \
        -ext BC:c=ca:true \
        -ext KU=keyCertSign \
        -validity 3650 \
        -keystore ./root-ca/ca.jks \
        -storepass password \
        -keypass password

keytool -exportcert \
        -keystore ./root-ca/ca.jks \
        -storepass password \
        -alias root-ca \
        -rfc -file ./root-ca/ca.pem