//
//  HomeAppInfoCell.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/08.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

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
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setLayout()
        
//        appInfoView01.addGestureRecognizer(appInfoTapGesture)
//        appInfoView02.addGestureRecognizer(appInfoTapGesture)
//        appInfoView03.addGestureRecognizer(appInfoTapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
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
