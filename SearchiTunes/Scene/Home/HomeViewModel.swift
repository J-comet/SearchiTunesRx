//
//  HomeViewModel.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/07.
//

import Foundation

import RxSwift
import RxCocoa

final class HomeViewModel {    
    let homeItems: BehaviorRelay<[HomeItemSectionModel]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
}
