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
        
        let input = SearchMainViewModel.Input(
            searchButtonTap: mainView.searchBar.rx.searchButtonClicked,
            searchBarText: mainView.searchBar.rx.text.orEmpty
        )

        let output = viewModel.transform(input: input)
        
        output.items
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

