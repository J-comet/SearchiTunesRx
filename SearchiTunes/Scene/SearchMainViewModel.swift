//
//  SearchMainViewModel.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/07.
//

import Foundation

import RxSwift
import RxCocoa

final class SearchMainViewModel {
    
    let items = PublishRelay<[AppInfo]>()
    
    let disposeBag = DisposeBag()
    
}
