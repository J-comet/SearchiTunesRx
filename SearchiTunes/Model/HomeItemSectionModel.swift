//
//  HomeItem.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/08.
//

import Foundation

import RxDataSources

struct HomeItemSectionModel {
    var type: HomeController.Section
    var items: [Item]
}

extension HomeItemSectionModel: SectionModelType {
    typealias Item = [HomeItem]
    
    init(original: HomeItemSectionModel, items: [[HomeItem]]) {
        self = original
        self.items = items
    }
}


struct HomeItem {
    let num: String
    let thumbnail: String
    let name: String
    let description: String
}
