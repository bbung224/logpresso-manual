## 1. 사설 CA 루트 인증서 생성

먼저 키를 생성합니다.

~~~~
openssl genrsa -out rootCA.key 2048
~~~~

방금 만든 키를 이용하여, 루트 CA 인증서를 만듭니다.

~~~~
openssl req -x509 -new -nodes -key rootCA.key -days 365 -out rootCA.crt
~~~~


## 2. 센트리 인증서 생성

센트리 인증서에 사용할 키를 생성합니다.

~~~~
openssl genrsa -out sentry.key 2048
~~~~

방금 만든 키를 이용하여, CSR을 생성합니다.

~~~~
openssl req -new -key sentry.key -out sentry.csr
~~~~

CA 인증서, CSR, 그리고 조금 전 만든 키를 이용해, 센트리 인증서를 생성합니다.

~~~~
openssl x509 -req -in sentry.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out sentry.crt -days 365
~~~~

## 3. CA 루트 인증서를 자바 키스토어 포맷으로 변환

1번에서 만든 CA 루트 인증서를 자바 키스토어 포맷으로 변환합니다. 이 과정에서 입력한 패스워드는 5번 과정에서 필요합니다.

~~~~
keytool -import -trustcacerts -alias ca -file rootCA.crt -keystore CA.jks
Enter keystore password:  
Re-enter new password: 
~~~~


## 4. 센트리 인증서를 PKCS#12 포맷으로 변환

2번에서 만든 센트리 인증서를 PKCS#12 포맷으로 변환합니다. 이 과정에서 입력한 패스워드는 5번 과정에서 필요합니다.

~~~~
openssl pkcs12 -export -in sentry.crt -inkey sentry.key -out logpresso-sentry.pfx
Enter Export Password:
Verifying - Enter Export Password:
~~~~

## 5. 콘솔에서 인증서 등록

3, 4번에서 만든 JKS파일과 pfx 파일을 콘솔에서 등록합니다. 예문에는 패스워드를 12345678이라고 적어두었지만, 실제로는 3, 4번 과정에서 입력한 패스워드를 각각 입력하면 됩니다.

~~~~
araqne> keystore.register rpc-ca JKS CA.jks 12345678
[rpc-ca] key store registered

araqne> keystore.register rpc-agent PKCS12 logpresso-sentry.pfx 12345678
[rpc-agent] key store registered
~~~~