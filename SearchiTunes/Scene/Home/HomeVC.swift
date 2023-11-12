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
            configureCell: { (dataSource, collectionView, indexPath, items) in
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeAppInfoCell.identifier,
                for: indexPath
            ) as? HomeAppInfoCell else { return UICollectionViewCell() }
                
                cell.fetchData(items: items)
                cell.appInfoView01.appInfoTapGesture
                    .rx
                    .event
                    .bind(with: self, onNext: { owner, gesture in
                        let vc = DetailAppInfoVC()
                        vc.hidesBottomBarWhenPushed = true
                        vc.detailAppInfo = items[0].appInfo
                        owner.navigationController?.pushViewController(vc, animated: true)
                    })
                    .disposed(by: cell.disposeBag)
                
                cell.appInfoView02.appInfoTapGesture
                    .rx
                    .event
                    .bind(with: self, onNext: { owner, gesture in
                        let vc = DetailAppInfoVC()
                        vc.hidesBottomBarWhenPushed = true
                        vc.detailAppInfo = items[1].appInfo
                        owner.navigationController?.pushViewController(vc, animated: true)
                    })
                    .disposed(by: cell.disposeBag)
                
                cell.appInfoView03.appInfoTapGesture
                    .rx
                    .event
                    .bind(with: self, onNext: { owner, gesture in
                        let vc = DetailAppInfoVC()
                        vc.hidesBottomBarWhenPushed = true
                        vc.detailAppInfo = items[2].appInfo
                        owner.navigationController?.pushViewController(vc, animated: true)
                    })
                    .disposed(by: cell.disposeBag)
                
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
        
        let input = HomeViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.items
            .bind(to: mainView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: viewModel.disposeBag)
    }
    
    private func configVC() {
        navigationItem.title = "앱"
//        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
