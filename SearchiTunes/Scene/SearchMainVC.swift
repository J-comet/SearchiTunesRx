//
//  SearchMainVC.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/06.
//

import UIKit

import RxSwift
import RxCocoa

final class SearchMainVC: UIViewController {

    private let mainView = SearchMainView()
    private let viewModel = SearchMainViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = mainView.searchBar
        bind()
    }

    private func bind() {
        
        viewModel.items
            .bind(to: mainView.tableView.rx.items(cellIdentifier: SearchiTuneCell.identifier, cellType: SearchiTuneCell.self)) { (row, element, cell) in
                cell.configCell(row: element)
            }
            .disposed(by: viewModel.disposeBag)
        
        mainView.searchBar
            .rx
            .searchButtonClicked
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(mainView.searchBar.rx.text.orEmpty)
//            .distinctUntilChanged() // 연달아 중복되는 값 무시
            .bind(with: self) { owner, text in
                print("검색 - ", text)
                APIManager.fetchData(term: text)
                    .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
                    .drive(with: self) { owner, value in
                        owner.viewModel.items.accept(value.results)
                    }
                    .disposed(by: owner.viewModel.disposeBag)
            }
            .disposed(by: viewModel.disposeBag)
    }
}

