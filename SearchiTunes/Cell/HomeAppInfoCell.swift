//
//  HomeAppInfoCell.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/08.
//

import UIKit

import SnapKit

final class HomeAppInfoCell: UICollectionViewCell {
    
    static let identifier = "HomeAppInfoCell"
    
    let stackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    let appInfoView01 = HomeAppInfoItemView()
    let appInfoView02 = HomeAppInfoItemView()
    let appInfoView03 = HomeAppInfoItemView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchData(items: [HomeItem]) {
//        print(items)
        appInfoView01.fetchData(item: items[0])
        appInfoView02.fetchData(item: items[1])
        appInfoView03.fetchData(item: items[2])
    }
    
}

extension HomeAppInfoCell {
    
    func configure() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(appInfoView01)
        stackView.addArrangedSubview(appInfoView02)
        stackView.addArrangedSubview(appInfoView03)
    }
    
    func setLayout() {
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
    }
}
