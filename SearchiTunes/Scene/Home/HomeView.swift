//
//  HomeView.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/07.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class HomeView: UIView {
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        
        return view
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configure()
        setLayout()
        
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDataSource() {
        
        let test = [
            HomeItem(num: "1", thumbnail: "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/c9/3e/69/c93e69b0-5fe8-fcd7-66c5-4815fcc463e6/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/60x60bb.jpg", name: "sdsds", description: "sdsdsd"),
            HomeItem(num: "2", thumbnail: "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/c9/3e/69/c93e69b0-5fe8-fcd7-66c5-4815fcc463e6/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/60x60bb.jpg", name: "sdsds", description: "sdsdsd"),
            HomeItem(num: "3", thumbnail: "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/c9/3e/69/c93e69b0-5fe8-fcd7-66c5-4815fcc463e6/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/60x60bb.jpg", name: "sdsds", description: "sdsdsd")
        ]
        
        let cellRegistration = UICollectionView.CellRegistration<HomeAppInfoCell, Int> { (cell, indexPath, identifier) in
            cell.fetchData(items: test)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: "headerElementKind") {
            (supplementaryView, string, indexPath) in
            supplementaryView.label.text = "타이틀 입니다"
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        var identifierOffset = 0
        var itemsPerSection = 18
        
        let sections = [1,2,3,4]
        
        sections.forEach {
            snapshot.appendSections([$0])
            let maxIdentifier = identifierOffset + itemsPerSection
            snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
            identifierOffset += itemsPerSection
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func configure() {
        addSubview(collectionView)
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension HomeView {
    
    func createLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        
        // 매개변수 sectionProvider, configuration
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // 양옆으로 다른 item이 보이게 하는 방법
            // item의 fractionalWidth는 1.0, group의 fractionalWidth는 1 보다 낮게 설정
            // item의 contentInsets을 주면 됨
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
            
            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                   heightDimension: .fractionalHeight(0.30)),
                subitems: [item])
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.groupPaging
            
            // header 설정
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(34)),
                elementKind: "headerElementKind",
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        }, configuration: config)
        return layout
    }
    
}
