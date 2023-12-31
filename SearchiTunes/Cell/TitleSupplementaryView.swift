//
//  TitleSupplementaryView.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/08.
//

import UIKit

import SnapKit

class TitleSupplementaryView: UICollectionReusableView {
    
    static let identifier = "title-supplementary-reuse-identifier"
    
    let label = {
        let view = UILabel()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TitleSupplementaryView {
    func configure() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(10)
        }
        label.adjustsFontForContentSizeCategory = true
        label.font = .boldSystemFont(ofSize: 20)
    }
}
