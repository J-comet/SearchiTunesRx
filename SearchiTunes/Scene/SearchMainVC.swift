//
//  SearchMainVC.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/06.
//

import UIKit

import RxSwift
import RxCocoa

class SearchMainVC: UIViewController {

    private let mainView = SearchMainView()
    
    let items = PublishRelay<[AppInfo]>()
    
//    let items = BehaviorRelay(value: [AppInfo]())
    
    let disposeBag = DisposeBag()
    
    let searchBar = UISearchBar()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
        bind()
    }

    private func bind() {
        
        let request = APIManager.fetchData(term: "todo")
            .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
        
        request.drive(with: self) { owner, value in
            owner.items.accept(value.results)
        }
        .disposed(by: disposeBag)
        
        items
            .bind(to: mainView.tableView.rx.items(cellIdentifier: SearchiTuneCell.identifier, cellType: SearchiTuneCell.self)) { (row, element, cell) in
                cell.configCell(row: element)
            }
            .disposed(by: disposeBag)
    }
}

