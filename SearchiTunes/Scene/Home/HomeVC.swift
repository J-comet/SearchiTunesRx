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

                print(item)
                cell.fetchData(items: item)
//                cell.bind(reels: item)
                
            return cell
        }, configureSupplementaryView: { [weak self] dataSource, collectionView, kind, indexPath in
            
            guard let self = self,
                  let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: TitleSupplementaryView.identifier,
                for: indexPath
            ) as? TitleSupplementaryView else { return UICollectionReusableView() }
            
//            header.label.text = dataSource.sectionModels[indexPath.section].header
            header.label.text = "Test 타이틀"
            return header
        })
    
    let test = [
        HomeItem(num: "1", thumbnail: "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/c9/3e/69/c93e69b0-5fe8-fcd7-66c5-4815fcc463e6/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/60x60bb.jpg", name: "sdsds", description: "sdsdsd"),
        HomeItem(num: "2", thumbnail: "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/c9/3e/69/c93e69b0-5fe8-fcd7-66c5-4815fcc463e6/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/60x60bb.jpg", name: "sdsds", description: "sdsdsd"),
        HomeItem(num: "3", thumbnail: "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/c9/3e/69/c93e69b0-5fe8-fcd7-66c5-4815fcc463e6/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/60x60bb.jpg", name: "sdsds", description: "sdsdsd")
    ]
    
    let homeItems = PublishRelay<[HomeItemSectionModel]>()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        bind()
    }
    
    func bind() {
        homeItems
            .bind(to: mainView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        homeItems.accept([
            HomeItemSectionModel(header: "테스트임1", items: [test,test]),
            HomeItemSectionModel(header: "테스트임2", items: [test,test]),
            HomeItemSectionModel(header: "테스트임3", items: [test,test])
        ])
    }
    
    private func configVC() {
        navigationItem.title = "앱"
//        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
