//
//  DetailAppInfoVC.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/07.
//

import UIKit

import RxSwift
import RxCocoa

final class DetailAppInfoVC: UIViewController {
    
    private let mainView = DetailAppInfoView()
    private let viewModel = DetailAppInfoViewModel()
    
    var detailAppInfo: AppInfo?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        guard let detailAppInfo else { return }
        viewModel.screenshotImages.accept(detailAppInfo.screenshotUrls)
        viewModel.detailAppInfo.accept(detailAppInfo)
    }
    
    private func bind() {
        viewModel.detailAppInfo
            .bind(with: self) { owner, appInfo in
                owner.mainView.fetchData(item: appInfo)
            }
            .disposed(by: viewModel.disposeBag)
        
        viewModel.screenshotImages
            .bind(to: mainView.screenshotCollectionView.rx.items(cellIdentifier: ScreenshotCell.identifier, cellType: ScreenshotCell.self)) { (row, element, cell) in
                cell.configCell(url: element)
            }
            .disposed(by: viewModel.disposeBag)
    }
}
