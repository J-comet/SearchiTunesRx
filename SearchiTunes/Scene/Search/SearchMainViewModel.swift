//
//  SearchMainViewModel.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/07.
//

import Foundation

import RxSwift
import RxCocoa

final class SearchMainViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchButtonTap: ControlEvent<Void>     // 검색버튼 클릭 처리
        let searchBarText: ControlProperty<String>  // 검색버튼에 입력된 값
    }
    
    struct Output {
        let items: PublishSubject<[AppInfo]>
    }
    
    func transform(input: Input) -> Output {
        
        let items = PublishSubject<[AppInfo]>()
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchBarText, resultSelector: { _, query in
                return query
            })
            .flatMap {
                APIManager.fetchData(term: String(describing: $0), limit: "20")
            }
            .subscribe(with: self) { owner, appInfo in
                let data = appInfo.results
                items.onNext(data)
            }
            .disposed(by: disposeBag)
        
        return Output(items: items)
    }
}
