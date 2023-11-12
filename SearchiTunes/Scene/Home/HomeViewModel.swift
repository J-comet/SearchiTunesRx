//
//  HomeViewModel.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/07.
//

import Foundation

import RxSwift
import RxCocoa

final class HomeViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let controllerDatas = HomeController.Section.allCases
    }
    
    struct Output {
        let items: PublishRelay<[HomeItemSectionModel]>
    }
    
    func transform(input: Input) -> Output {
        
        var homeData: [HomeItemSectionModel] = []
        let items = PublishRelay<[HomeItemSectionModel]>()
        
        for section in input.controllerDatas {
            var homeItemDatas: [HomeItem] = []
            let request = APIManager.fetchData(term: section.term, limit: "9")
            request.bind(with: self) { owner, value in
                value.results.enumerated().forEach { idx, appInfo in
                    homeItemDatas.append(
                        HomeItem(
                            num: "\(idx + 1)",
                            appInfo: appInfo
                        )
                    )
                }
                
                let first = Array(homeItemDatas[0...2])
                let second = Array(homeItemDatas[3...5])
                let third = Array(homeItemDatas[6...8])
                homeData.append(HomeItemSectionModel(type: section, items: [first,second,third]))
                items.accept(homeData)
            }
            .disposed(by: disposeBag)
        }
        
        return Output(items: items)
    }
    
}
