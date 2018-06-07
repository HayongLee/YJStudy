# 파일 시스템 


* [파일 시스템](#파일-시스템)
    * [디렉토리, 논리 디스크](#디렉토리,-논리-디스크)
    * [open()](#open())
    * [파일 보호](#파일-보호)
    * [파일 시스템의 마운트](#파일-시스템의-마운트)
    * [접근 방법](#접근-방법)
* [파일 시스템 구현](#파일-시스템-구현)
    * [디스크 파일 할당](#디스크-파일-할당)
    * [유닉스(UNIX) 파일 시스템의 구조](#유닉스unix-파일-시스템의-구조)
    * [FAT 파일 시스템](#fat-파일-시스템)
    * [디렉토리 구현](#디렉토리-구현)
    * [VFS and NFS](#vfs-and-nfs)
    * [Page Cache and Buffer Cache](#page-cache-and-buffer-cache)


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
## 파일 시스템 구현
### 디스크 파일 할당
파일 할당 방식에는 연속 할당(Contiguous Allocation), 링크드 할당(Linked Allocation), 인덱스 할당(Indexe Allocation)이 있다.


#### 연속 할당(Contiguous Allocation)
연속 할당의 장점:
* 빠른 I/O가 가능하다. 한번의 seek/rotation으로 많은 바이트를 이동가능. Realtime file 또는 실행 중이던 프로세스의 swapping에 용이하다.
* 직접 접근(Direct access = Random access) 가능


연속 할당의 단점:
* 외부 조각 발생. 각 파일의 크기가 균일하지 않기 때문에 외부 조각이 발생한다.
* 파일 크기 키우기가 어려움. 따라서 미리 공간(hole)을 배당하는 방법을 사용하지만 이는 내부 조각을 발생시긴다.


![contiguous-allocation](https://github.com/0jun0815/YJStudy/blob/master/운영체제/파일%20시스템/images/contiguous-allocation.png)


#### 링크드 할당(Linked Allocation)
연속적 배치가 아니라 빈 공간(hole) 아무 곳에나 배치한다.


링크드 할당의 장점:
* 외부 조각이 발생하지 않는다.


링크드 할당의 단점:
* 직접 접근이 불가능
* 순차 접근 시간이 많이 듬
* Reliability 문제. 하나의 잘못된 섹터가 있어서 포인터가 유실되면 많은 부분을 잃는다.
* 포인터를 위한 공간이 블록의 일부가 되어 공간 효율성을 떨어뜨림. 512 bytes/sector - 4bytes/pointer = 508bytes 


링크드 할당의 Reliability와 공간효율성 문제를 해결하는 방법으로 링크드 할당을 변형시킨 File-allocation table(FAT) 파일 시스템이 있다.


![linked-allocation](https://github.com/0jun0815/YJStudy/blob/master/운영체제/파일%20시스템/images/linked-allocation.png)


#### 인덱스 할당(Indexed Allocation)
인덱스 블록은 파일의 저장 위치를 갖고 있으므로 디렉토리는 인덱스 블록만을 가르키면 된다.


인덱스 할당의 장점:
* 외부 조각이 발생하지 않는다.
* 직접 접근이 가능하다.


인덱스 할당의 단점:
* 두 개의 블록(인덱스 저장, 데이터 저장 블록)이 필요하다. 이는 파일이 작은 경우 공간이 낭비된다.
* 굉장히 큰 파일의 경우 하나의 블록으로 인덱스를 저장하기에 부족하다. 해결 방안으로 linked sheme(마지막 인덱스는 또 다른 인덱스 블록을 가르킴), multil-level index가 있다.


![indexed-allocation](https://github.com/0jun0815/YJStudy/blob/master/운영체제/파일%20시스템/images/indexed-allocation.png)


### 유닉스(UNIX) 파일 시스템의 구조
유닉스 파일 시스템의 중요 개념:
* Boot block
    * 부팅에 필요한 정보(bootstrap loader)를 갖고 있다. 어떤 파일 시스템이든 가장 앞 쪽에는 부트 블록이 존재한다.
* Super block
    * 파일 시스템에 관한 총체적인 정보(어디가 빈 블록이고 사용 중인 블록인지 등)를 담고 있다.
* Inode
    * 파일 이름을 제외한(파일 이름은 데이터 블록에 저장) 파일의 모든 메타데이터를 저장한다. 유닉스 파일 시스템의 핵심으로 메타데이터 인덱스를 갖고 있다.
* Data block
    * 파일의 실제 내용을 보관한다.
    

유닉스 파일 시스템은 인덱스 할당 방식을 사용하는데 작은 파일은 다이렉트 인덱스로 큰 파일은 싱글, 더블, 트리플 인다이렉트 인덱스를 사용한다. 다이렉트 인덱스는 파일을 가리키지만 인다이렉트 인덱스는 또 다른 인덱스를 가리키고 그 인덱스가 파일을 가르킨다. 싱글 인다이렉트 인덱스: 인덱스 -> 파일, 더블 인다이렉트 인덱스: 인덱스 -> 인덱스 -> 파일, 트리플 인다이렉트 인덱스: 인덱스 -> 인덱스 -> 인덱스 -> 파일


![unix-file-system](https://github.com/0jun0815/YJStudy/blob/master/운영체제/파일%20시스템/images/unix-file-system.png)


### FAT 파일 시스템
FAT는 메타데이터 중 일부(위치 정보)를 갖고 있다. 나머지 메타데이터는 디렉토리가 갖고 있다. 디렉토리는 첫 번째 인덱스를 나머지 인덱스 정보는 FAT에 보관, FAT는 총 블록 갯수 - 1개가 존재한다.


FAT의 장점은 직접 접근이 가능하고 포인터가 유실되도 FAT에 정보가 유지되어 링크드 할당의 단점을 모두 해결한다.


![fat-file-system](https://github.com/0jun0815/YJStudy/blob/master/운영체제/파일%20시스템/images/fat-file-system.png)


### 빈 공간 관리
빈 공간 관리에는 Bit map, Linked list, Grouping, Counting이 있다.


#### Bit map(or Bit vector)
비트 맵은 블록의 사용 여부를 0과 1로 구별한다. 크기는 블록의 갯수이고 연속적인 빈 공간을 찾는데 효과적이다. 하지만 비트 맵은 부가적인 공간을 필요로 한다.


![bit-map](https://github.com/0jun0815/YJStudy/blob/master/운영체제/파일%20시스템/images/bit-map.png)


#### Linked list
모든 빈 블록을 링크로 연결한다. 공간 낭비는 없지만 연속적인 가용 공간(빈 공간)을 찾는 것은 쉽지 않다.


#### Grouping
링크드 리스트 방법의 변형으로 첫 번째 빈 공간이 n개의 포인터를 가진다. n-1 포인터는 빈 데이터 블록을 가르키고 마지막 포인터가 가르키는 블록은 또다시  n개의 포인터를 가진다.
```
[free block] -> [free block]
             -> [free block]
             -> [free block] -> [free block]
                             -> [free block]
                             -> [free block]
```


#### Counting
프로그램들이 종종 여러 개의 연속적인 블록을 할당하고 반납한다는 성질에서 착안된 방법. (첫 번째 빈 블록, 연속적으로 비어있는 블록 갯수) 쌍을 유지하며 연속적인 빈 블록을 찾는데 효과적이다.


### 디렉토리 구현
#### Linear list
<file name, file의 metadata>의 리스트로 각 엔트리는 고정된 크기로 구현된다. 구현이 간단하지만 디렉토리 내에 파일이 있는지 찾기 위한 선형 검색이 필요하므로 연산 시간이 많이든다(비효율적).


![linear-list](https://github.com/0jun0815/YJStudy/blob/master/운영체제/파일%20시스템/images/linear-list.png)


#### Hash Table
파일 이름에 해쉬 함수를 적용하여 만들어진 엔트리에 파일 이름, 메타데이터를 저장한다. 검색 시간을 없앴지만 Collision 발생 가능성이 있다.
* Collision: 다른 이름의 파일이 같은 엔트리에 매핑되는 현상


![hash-table](https://github.com/0jun0815/YJStudy/blob/master/운영체제/파일%20시스템/images/hash-table.png)


#### 파일의 메타데이터의 보관 위치
디렉토리 내에 직접 보관 또는 디렉토리에는 포인터를 두고 다른 곳에 보관(Inode, FAT 등)


#### 긴 파일 이름의 지원
<file name, file의 metadata>의 리스트에서 각 엔트리는 일반적으로 고정된 크기이다. 따라서 파일 이름이 고정 크기의 엔트리 길이보다 길어지는 경우 엔트리의 마지막 부분에 이름의 뒷부분이 위치한 곳의 포인터를 두는 방법을 사용한다. 이름의 나머지 부분은 동일한 디렉토리 파일의 일부에 존재한다.


![long-file-name](https://github.com/0jun0815/YJStudy/blob/master/운영체제/파일%20시스템/images/long-file-name.png)


### VFS and NFS


![vfs-nfs](https://github.com/0jun0815/YJStudy/blob/master/운영체제/파일%20시스템/images/vfs-nfs.png)


#### Virtual File System(VFS)
서로 다른 다양한 파일 시스템에 대해 동일한 시스템 콜 인터페이스(API)를 통해 접근할 수 있게 해주는 OS의 layer


#### Network File System(NFS)
분산 시스템에서는 네트워크를 통해 파일이 공유될 수 있다. NFS는 분산 환경에서의 대표적인 파일 공유 방법


### Page Cache and Buffer Cache
#### Page Cache
가상 메모리의 페이징 시스템에서 사용하는 페이지 프레임을 캐싱의 관점에서 설명하는 용어. Memory-Mapped I/O를 쓰는 경우 파일의 I/O에서도 page cache를 사용한다.


Page cache는 프로세스의 주소 공간을 구성하는 페이지가 스왑 영역에 내려가 있는가 또는 page cache에 올라와 있는가를 가지고 처리한다. 단위는 page(4KB) .


#### Memory-Mapped I/O
파일의 일부를 가상 메모리에 매핑 시킴. 매핑시킨 영역에 대한 메모리 접근 연산은 파일의 입출력을 수행하게 한다.


#### Buffer Cache
파일 시스템을 통한 I/O 연산은 메모리의 특정 영역인 buffer cache를 사용하며 파일 사용의 locality 활용(한번 읽어온 블록에 대한 후속 요청시 buffer cache에서 즉시 전달)한다. 모든 프로세스가 공용으로 사용하며 Replacement 알고리즘(LRU, LFU 등)이 필요하다.


Buffer cache는 파일 데이터가 파일 시스템 스토리지에 저장되었는가 운영체제 buffer cache에 올라와 있는가를 가지고 처리한다. 단위는 논리적 블록(512byte).


#### Unified Buffer Cache
최근의 OS에서는 기존의 buffer cache가 page cache에 통합되면서 페이지 단위 사용(4KB)한다. 통합 buffer cache는 캐시를 구분하지 않고 그때 그때 필요할 때 할당해서 사용한다.


![page-buffer-cache](https://github.com/0jun0815/YJStudy/blob/master/운영체제/파일%20시스템/images/page-buffer-cache.png)


* 기존의 파일 I/O에서 파일 입출력 방법은 read()/write()를 사용하는 방법과 memory-mapped를 사용하는 방법이 있다.
    * read()/write() 입출력은 항상 운영체제에게 요청을 하지만 memory-mapped는 page cache에 올라온 내용은 운영체제에게 요청하지 않는다는 차이점이 있다. memory-mapped는 운영체제에 의해 읽어온 내용을 page cache에 매핑하면 이후 해당 내용에 접근 시 운영체제 간섭없이 파일 입출력 가능하다.
* 통합된 buffer cache를 이용한 파일의 I/O 방법에서 read()/write()는 동일하지만 memory-mapped는 page cache 자체가 논리적 주소에 매핑된다. 즉 기존의 buffer cache -> page cache 매핑이 단순화 되었다.


&nbsp;
&nbsp;      
### [by. 0junChoi](https://github.com/0jun0815) email: <0jun0815@gamil.com>
### 출처: [운영 체제와 정보 기술의 원리](http://book.naver.com/bookdb/book_detail.nhn?bid=4392911), [반효경 운영체제 강의](http://www.kocw.net/home/search/kemView.do?kemId=1046323)

