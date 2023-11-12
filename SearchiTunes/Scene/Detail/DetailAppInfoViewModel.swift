//
//  DetailAppInfoViewModel.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/07.
//

import Foundation

import RxSwift
import RxCocoa

final class DetailAppInfoViewModel {
    var detailAppInfo = PublishRelay<AppInfo>()
    var screenshotImages = PublishRelay<[String]>()
    let disposeBag = DisposeBag()
}
