# 파일 시스템 


* [파일 시스템](#파일-시스템)
    * [디렉토리, 논리 디스크](#디렉토리,-논리-디스크)
    * [open()](#open())
    * [파일 보호](#파일-보호)
    * [파일 시스템의 마운트](#파일-시스템의-마운트)
    * [접근 방법](#접근-방법)


&nbsp;      
## 파일 시스템
파일이란 관련된 정보의 명명된 컬렉션이다. 일반적으로 비휘발성의 보조기억장치에 저장되고 운영체제는 다양한 저장 장치를 파일이라는 동일한 논리적 단위로 볼 수 있게 해준다.
* 파일 연산: create, read, write, reposition(lseek), delete, open, close 등 
    * open은 파일 내용이 아닌 메타데이터를 메모리에 올려놓는 작업
    
 
 파일 속성(혹은 메타데이터)은 파일 자체의 내용이 아니라 파일을 관리하기 위한 각종 정보들이다.
 * 파일 이름, 유형, 저장된 위치, 파일 사이즈
 * 접근 권한(읽기/쓰기/실행), 시간(생성/변경/사용), 소유자 등


파일 시스템은 운영체제에서 파일을 관리하는 부분으로 파일 및 파일의 메타데이터, 디렉토리 정보 등을 관리하고 파일의 저장 방법 결정, 파일 보호 등의 역할을 한다.


### 디렉토리, 논리 디스크
디렉토리란 파일의 메타데이터 중 일부(그 디렉토리에 속한 파일 이름 및 파일 속성들)를 보관하고 있는 일종의 특별한 파일이다.
* 디렉토리 연산: search for a file, create a file, delete a file, list a directory, rename a file, traverse the file system


논리 디스크는 파티션이라고 부르며, 하나의 (물리적)디스크 안에 여러 파티션을 두는게 일반적이고 여러 개의 물리적인 디스크를 하나의 파티션으로 구성하기도 한다. (물리적)디스크를 파티션으로 구성한 뒤 각각의 파티션에 file system을 깔거나 swapping등 다른 용도로 사용할 수 있다.


### open()
디스크로부터 파일의 메타데이터를 메모리에 올려 놓는 연산이다.


디스크로부터 파일 c의 메타데이터를 메모리로 가지고 오는 open("a/b/c/") 연산을 수행할 경우 디렉토리 경로 검색은 다음 순서로 진행된다:
1. 루트 디렉토리 "/"를 open하고 그 안에서 파일 "a"의 위치 획득
2. 파일 "a"를 open한 후 read하여 그 안에서 파일 "b"의 위치 획득
3. 파일 "b"를 open한 후 read하여 그 안에서 파일 "c"의 위치 획득
4. 파일 "c"를 open한다.


디렉토리 경로 검색에 너무 많은 시간 소요되기 때문에 open을 read/write와 별도로 둔다. 한번 open한 파일은 read/write 시 디렉토리 검색이 불필요하다.


오픈 파일 테이블(open file table)은 현재 open된 파일들의 메타데이터 보관소(in memory)이다. 디스크의 메타데이터보다 몇 가지 정보가 추가된다.
* open한 프로세스의 수
* file offset: 파일 어느 위치 접근 중인지 표시(별도 테이블 필요)


파일 디스크립터(file handle, file control block)는 각 프로세스별 오픈 파일 테이블에 대한 위치 정보를 갖고 있다.


![open()](https://github.com/0jun0815/YJStudy/blob/master/%EC%9A%B4%EC%98%81%EC%B2%B4%EC%A0%9C/%ED%8C%8C%EC%9D%BC%20%EC%8B%9C%EC%8A%A4%ED%85%9C/images/open().png)


### 파일 보호
파일 보호란 각 파일에 대해 누구에게 어떤 유형의 접근(read/write/execution)을 허락할 지를 결정하는 것이다. 접근 제어 방법에는 Access control Matrix, Grouping, Password가 있다.


#### Access control Matrix
![acl](https://github.com/0jun0815/YJStudy/blob/master/%EC%9A%B4%EC%98%81%EC%B2%B4%EC%A0%9C/%ED%8C%8C%EC%9D%BC%20%EC%8B%9C%EC%8A%A4%ED%85%9C/images/acl.png)


* Access control list: 파일별로 누구에게 어떤 접근 권한이 있는지 표시한다.
* Capability: 사용자별로 자신이 접근 권한을 가진 파일 및 해당 권한 표시


#### Grouping
Access control Matrix는 부가적인 오버헤드가 크다. 일반적인 운영체제에서는 Grouping을 사용한다. Grouping은 전체 사용자를 owner, group, public의 세 그룹으로 나누어 그룹별로 관리한다. 각 파일에 대해 세 그룹의 접근 권한(rwx)을 3비트씩 표시, 즉 9비트만 필요하므로 효율적이다. 예) UNIX


![grouping](https://github.com/0jun0815/YJStudy/blob/master/%EC%9A%B4%EC%98%81%EC%B2%B4%EC%A0%9C/%ED%8C%8C%EC%9D%BC%20%EC%8B%9C%EC%8A%A4%ED%85%9C/images/grouping.png)


#### Password
파일마다 password를 두는 방법(디렉토리 파일에 두는 방법도 가능)으로 모든 접근 권한에 대해 하나의 password: all-or-nothing이 필요하다. 접근 권한별 password가 필요하므로 암기, 관리에 문제가 있다.


### 파일 시스템의 마운트
마운트란 파일 시스템 구조 내에 있는 일련의 파일들을 사용자나 사용자 그룹들이 이용할 수 있도록 만드는 것이다. UNIX에서는 한 파일 시스템의 루트 디렉토리를 다른 디렉토리에 붙임으로써 디렉토리를 사용할 수 있게 만들어주며, 모든 파일 시스템들을 마치 그들이 속해있는 파일 시스템의 서브 디렉토리인 것처럼 사용 가능하게 만든다.


![mount](https://github.com/0jun0815/YJStudy/blob/master/%EC%9A%B4%EC%98%81%EC%B2%B4%EC%A0%9C/%ED%8C%8C%EC%9D%BC%20%EC%8B%9C%EC%8A%A4%ED%85%9C/images/mount.png)


### 접근 방법
시스템이 제공하는 파일 정보의 접근 방식:
* 순차 접근(sequential access): 카세트 테이프를 사용하는 방식처럼 접근, 읽거나 쓰면 offset은 자동적으로 증가
* 직접 접근(direct access, random access): LP 레코드 판과 같이 접근하도록 함, 파일을 구성하는 레코드를 임의의 순서로 접근할 수 있음




&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### 출처: [운영 체제와 정보 기술의 원리](http://book.naver.com/bookdb/book_detail.nhn?bid=4392911), [반효경 운영체제 강의](http://www.kocw.net/home/search/kemView.do?kemId=1046323)

