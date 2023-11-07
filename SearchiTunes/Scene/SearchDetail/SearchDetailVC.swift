//
//  SearchDetailVC.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/07.
//

import UIKit

import RxSwift
import RxCocoa

final class SearchDetailVC: UIViewController {
    
    private let mainView = SearchDetailView()
    
    var detailAppInfo: AppInfo?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(detailAppInfo)
    }
}
