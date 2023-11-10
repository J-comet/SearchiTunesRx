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
![1109201426469416](https://github.com/J-comet/traveltune/assets/67407666/12125e81-ee16-4b16-af62-e12f872f8c07)

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
 ####  1. SearchiTuneCell 의 prepareForReuse() 메서드가 호출 된 후 스크린샷 이미지들이 사라지는 오류
 -> prepareForReuse() 메서드에서 disposeBag 을 교체하며 메모리에서 해제 해주고 있었습니다. <br>
 -> 메모리에서 해제하는 부분을 주석처리하고 실행 시켜보니 스크린샷은 잘나왔지만 화면전환할 때 이벤트가 계속 등록이 되면서 페이지가 여러번 이동되는 오류가 되어서 원복 한 후
 메모리에서 해제되는 시점에 다시 구독을 하는 방식으로 해결했습니다.

```swift
override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()

        // 다시 구독
        screenshotImages
            .bind(to: screenshotCollectionView.rx.items(cellIdentifier: ScreenshotCell.identifier, cellType: ScreenshotCell.self)) { (row, element, cell) in
                cell.configCell(url: element)
            }
            .disposed(by: disposeBag)
    }
```

<br>

####  2. could not dequeue a view of kind: UICollectionElementKindSectionHeader with identifier... - 에러 발생
-> 해당 부분은 헤더셀을 register 해줄 때 forSupplementaryViewOfKind 의 값을 잘못 주고 있었습니다. <br>
-> TitleSupplementaryView.identifier 로 되어 있던 부분을 UICollectionView.elementKindSectionHeader 변경 후 해결했습니다.

```swift
collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.identifier)
```

<br>

### 회고
- RxSwift 를 계속 학습하며 가장 중요한 것은 RxSwift의 큰 흐름을 놓치지 않는 것이 라고 생각했습니다. <br>
하지만 기존에 알고 있었던 부분을 잊었거나 헷갈리는 부분이 있다면 복습이 더 중요하다고 느꼈습니다. <br>
- 온종일 노트북 보며 개발하다보니 의식의 흐름대로 개발을 해서 실수라고도 생각할 수 있습니다. 실수가 쌓이면 실력이 된다고 생각해서 이런 작은 실수를 하지 않는 것이 추후 실력 향상에도 도움되고
  RxSwift 를 학습하며 지금 오류는 RxSwift 오류인지, UIKit 오류인지 빨리 파악해서 문제 해결 시간을 단축할 수 있다고 생각합니다.

<br>

