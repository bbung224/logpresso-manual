# 1장. 암호화 프로파일
## 1.1. 키 생성

## 1.2. 암호화 프로파일 셋업
RPC 서버와 센트리 양쪽 모두 암호화 프로파일을 설정해야 합니다.

# 2장. RPC 서버
## 2.1. RPC 서버 설정 
### 2.1.1. RPC 서버 목록 조회
~~~
	araqne> rpc.bindings
~~~

현재 설정된 RPC 서버 목록을 표시합니다. 각 서버별로 바인딩된 IP, 포트, 키, 인증서를 확인할수 있습니다.


### 2.1.2 SSL-RPC 서버 시작

`rpc.openSsl` 명령어를 이용하여 SSL RPC 서버를 시작합니다.

~~~
	araqne> rpc.openSsl 포트 키 인증서 IP
~~~

 * [필수] 포트 : SSL RPC 서버 포트를 지정합니다. 일반적으로 7140번 포트를 이용합니다.
 * [필수] 키 : 키스토어 저장한 키 이름을 지정합니다.
 * [필수] 인증서 : 키스토어에 저장한 인증서 이름을 지정합니다.
 * [선택] IP : SSL RPC 서버를 바인딩할 IP를 지정합니다. 기본값은 0.0.0.0 입니다.
 
# 3장. 센트리
## 3.1. guid

센트리가 서버에 접속하기 위해서는, guid라는 각 센트리별 이름을 지정해야 합니다. 기본적으로는 이 값이 설정되어있지 않습니다.

### 3.1.1. guid 확인
~~~
	araqne> sentry.guid
~~~

센트리에 설정한 guid 값이 출력됩니다. 기본값은 없기 때문에, 일반적으로는 다음의 결과가 출력됩니다.

~~~
	'guid not found. sentry.setGuid first' 
~~~
### 3.1.1. guid 설정
~~~
	araqne> sentry.setGuid guid
~~~

 * [필수] guid : 센트리 이름을 지정합니다.
 
## 3.2. RPC 서버 접속
### 3.2.1. RPC 서버 IP 지정 

~~~
	araqne> senry.addBase 이름 IP 포트 키 인증서 스왑용량 스탠바이모드
~~~

 * [필수] 이름 : RPC 서버 이름을 지정합니다.
 * [필수] IP : RPC 서버 IP를 지정합니다.
 * [필수] 포트 : RPC 서버 포트를 지정합니다. 
 * [필수] 키 : 키스토어에 저장한 키 이름을 지정합니다.
 * [필수] 인증서 : 키스토어에 저장한 인증서 이름을 지정합니다.
 * [필수] 스왑용량 : 네트워크가 단절되어 로그를 전송하지 못할 경우, 임시로 센트리에 저장하는 용량입니다.
 * [선택] 스탠바이 모드 : 이미 연결되어있는 액티브 센트리와 동일한 guid 값을 가진 스탠바이 센트리가 접속 시도하는 경우, 액티브 센트리의 연결을 끊고 스탠바이 센트리의 접속을 허용할지 여부를 설정합니다. 기본값은 false 입니다.

# 4장. 예제 시나리오

장비

종류  | IP
:----:|----------
서버  |192.168.0.1
센트리 |192.168.0.2

키

|| |
|---|---|
| 키 파일 | araqne-base.pfx |
| 키 암호 | 1234 |


인증서


|| |
|---|---|
|인증서 파일|CA.jks|
|인증서 암호|123456|

## 4.1. 암호화 프로파일

암호화 프로파일은, RPC 서버와 센트리 양쪽 모두 동일하게 설정해야 합니다.

### 4.1.1. 파일 복사

araqne-base.pfx 파일과 CA.jks 파일을 로그프레소 설치 디렉토리에 복사합니다.

### 4.1.2. 키 등록

~~~
	araqne> keystore.register rpc-agent PKCS12 araqne-base.pfx 1234
~~~

### 4.1.3. 인증서 등록

~~~
	araqne> keystore.register rpc-ca JKS CA.jks 123456
~~~

## 4.2. RPC 서버


~~~
	araqne> rpc.openSsl 7140 rpc-agent rpc-ca
~~~

7140번 포트로 RPC 서버를 시작합니다.

## 4.3. 센트리
### 4.3.1 guid
#### 4.3.1.1 guid 설정

~~~
	araqne> sentry.setGuid windows_sentry
~~~

windows_sentry 라는 이름으로 guid를 지정합니다.

#### 4.3.1.2 guid 확인

설정된 guid 값을 확인합니다.

~~~
	araqne> sentry.guid
	windows_sentry
~~~

### 4.3.2 RPC 서버 접속

#### 4.3.2.1 RPC 서버 접속 설정

~~~
	araqne> sentry.addBase base 192.168.0.1 7140 rpc-agent rpc-ca 100000000
~~~

192.168.0.1 서버의 7140번 포트로 접속합니다. 스왑 용량은 100메가로, 서버 이름은 base 로 설정합니다.


#### 4.3.2.2 RPC 서버 접속 설정 확인



~~~
	araqne> sentry.bases
	name=base, address=/192.168.0.1:7140, key=rpc-agent, ca=rpc-ca, swap=100000000, standby=false
~~~

#### 4.3.2.3 RPC 서버 접속 상태 확인

~~~
	araqne> sentry.connections
	[base] id=-231707769, peer=(b91e9b19-ddfb-4f4c-9243-2c795af95000, /192.168.0.1:7140), trusted level=Low, ssl=true, props={phase=post_hello, ping_failure=0, type=command}
~~~

# 5장. 트러블 슈팅
