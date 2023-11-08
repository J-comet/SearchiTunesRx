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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainView.searchBar.resignFirstResponder()
    }

    private func bind() {
        
        viewModel.items
            .bind(to: mainView.tableView.rx.items(cellIdentifier: SearchiTuneCell.identifier, cellType: SearchiTuneCell.self)) { (row, element, cell) in
                cell.configCell(row: element)
                
                cell.containerViewTapGesture
                    .rx
                    .event
                    .bind(with: self, onNext: { owner, gesture in
                        let vc = SearchDetailVC()
                        vc.hidesBottomBarWhenPushed = true
                        vc.detailAppInfo = element
                        owner.navigationController?.pushViewController(vc, animated: true)
                    })
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: viewModel.disposeBag)
        
        mainView.searchBar
            .rx
            .searchButtonClicked
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(mainView.searchBar.rx.text.orEmpty)
//            .distinctUntilChanged() // 연달아 중복되는 값 무시
            .bind(with: self) { owner, text in
//                print("검색 - ", text)
                APIManager.fetchData(term: text, limit: "20")
                    .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
                    .drive(with: self) { owner, value in
                        owner.viewModel.items.accept(value.results)
                    }
                    .disposed(by: owner.viewModel.disposeBag)
            }
            .disposed(by: viewModel.disposeBag)
        
        // didSelectItemAt - 컬렉션뷰영역도 터치동작시키기 위해 tabGesture 로 변경
//        Observable.zip(mainView.tableView.rx.itemSelected, mainView.tableView.rx.modelSelected(AppInfo.self))
//            .subscribe(with: self) { owner, selectedItem in
//                let vc = SearchDetailVC()
//                vc.hidesBottomBarWhenPushed = true
//                vc.detailAppInfo = selectedItem.1
//                owner.navigationController?.pushViewController(vc, animated: true)
//            }
//            .disposed(by: viewModel.disposeBag)
        
        // 스크롤시 소프트키보드 hide
        mainView.tableView.rx
            .contentOffset
            .subscribe(with: self) { owner, _ in
                owner.mainView.searchBar.resignFirstResponder()
            }
            .disposed(by: viewModel.disposeBag)
    }
}

