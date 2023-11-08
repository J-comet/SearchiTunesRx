# SearchiTunesRx
<br>

### 프로젝트
 - 인원 : 개인프로젝트 <br>
 - 기간 : 2023.11.06 ~ 2023.11.8 (3일) <br>
 - 최소지원버전 : iOS 17 <br>
 
<br>

### 한줄소개
 - App Store 에 출시된 앱 정보를 확인할 수 있는 앱 입니다.
   
<br>

### 미리보기
![1109005834127760](https://github.com/J-comet/traveltune/assets/67407666/3b0a5956-e803-43d0-b74b-a04cbb32909a)

<br>

### 기술
| Category | Stack |
|:----:|:-----:|
| Architecture | `MVVM` |
|  UI  | `SnapKit` |
| Reactive | `RxSwift` `RxDataSource` |
|  Network  | `URLSession` `Codable` |
|  Image  | `Kingfisher` |
|  Dependency Manager  | `SPM` |
| Etc | `Toast` |

<br>

### 기능
1. 카테고리별 앱 확인
2. iTunes Search API 이용해 검색
3. 앱 상세 정보 확인

<br>

### 개발 고려사항
- RxDataSource 를 활용한 반응형 CollectionView
- Dispose 필요한 시점 고려
- API Error 케이스 처리
- 검색어 중복입력 방지
- 카테고리 앱 페이지 모든 API 요청 끝난 시점에 이벤트 전달

<br>


### 트러블슈팅
   

<br>

### 회고


<br>

