//
//  HomeVC.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/07.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

final class HomeVC: UIViewController {
    
    private let mainView = HomeView()
    private let viewModel = HomeViewModel()
    
    lazy var dataSource = RxCollectionViewSectionedReloadDataSource<HomeItemSectionModel>(
            configureCell: { (dataSource, collectionView, indexPath, item) in
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeAppInfoCell.identifier,
                for: indexPath
            ) as? HomeAppInfoCell else { return UICollectionViewCell() }
                cell.fetchData(items: item)
            return cell
                
        }, configureSupplementaryView: { [weak self] dataSource, collectionView, kind, indexPath in
            
            guard let self = self,
                  let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: TitleSupplementaryView.identifier,
                for: indexPath
            ) as? TitleSupplementaryView else { return UICollectionReusableView() }
            
            header.label.text = dataSource.sectionModels[indexPath.section].type.title
            return header
        })
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        bind()
    }
    
    func bind() {
        viewModel.homeItems
            .bind(to: mainView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: viewModel.disposeBag)
        
        var homeData: [HomeItemSectionModel] = []
        
        for section in HomeController.Section.allCases {
            var homeItemDatas: [HomeItem] = []
            let request = APIManager.fetchData(term: section.term, limit: "9")
            request.bind(with: self) { owner, value in
                value.results.enumerated().forEach { idx, appInfo in
                    homeItemDatas.append(
                        HomeItem(
                            num: "\(idx + 1)",
                            thumbnail: appInfo.artworkUrl512,
                            name: appInfo.trackName,
                            description: appInfo.description
                        )
                    )
                }
                
                let first = Array(homeItemDatas[0...2])
                let second = Array(homeItemDatas[3...5])
                let third = Array(homeItemDatas[6...8])
                homeData.append(HomeItemSectionModel(type: section, items: [first,second,third]))
                owner.viewModel.homeItems.accept(homeData)
            }
            .disposed(by: viewModel.disposeBag)
        }
    }
    
    private func configVC() {
        navigationItem.title = "앱"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
