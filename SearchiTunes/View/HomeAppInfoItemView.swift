//
//  HomeAppInfoView.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/08.
//

import UIKit

import SnapKit
import Kingfisher

final class HomeAppInfoItemView: UIView {
    
    let appInfoTapGesture = UITapGestureRecognizer()
    
    let thumbImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let shadowView = {
        let view = UIImageView()
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1 // 그림자 불투명도
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero // 그림자 방향. .zero
        view.layer.shadowRadius = 4 // 그림자 퍼짐의 정도
        view.layer.masksToBounds = false
        return view
    }()
    
    let numLabel = {
        let view = UILabel()
        view.font = .monospacedSystemFont(ofSize: 14, weight: .bold)
        view.textColor = .black
        view.textAlignment = .center
        return view
    }()
    
    let nameLabel = {
        let view = UILabel()
        view.font = .monospacedSystemFont(ofSize: 14, weight: .semibold)
        view.textColor = .black
        return view
    }()
    
    let descriptionLabel = {
        let view = UILabel()
        view.font = .monospacedSystemFont(ofSize: 12, weight: .regular)
        view.textColor = .gray
        return view
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        addGestureRecognizer(appInfoTapGesture)
        config()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchData(item: HomeItem) {
        numLabel.text = item.num
        nameLabel.text = item.appInfo.trackName
        descriptionLabel.text = item.appInfo.description
        if let url = URL(string: item.appInfo.artworkUrl512) {
            thumbImageView.kf.setImage(with: url)
        }
    }
    
}

extension HomeAppInfoItemView {
    
    func config() {
        addSubview(shadowView)
        addSubview(thumbImageView)
        addSubview(numLabel)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(lineView)
    }
    
    func setLayout() {
        thumbImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.size.equalTo(self.snp.height).multipliedBy(0.8)
            make.leading.equalToSuperview()
        }
        
        shadowView.snp.makeConstraints { make in
            make.edges.equalTo(thumbImageView).inset(0.5)
        }
        
        numLabel.snp.makeConstraints { make in
            make.top.equalTo(shadowView).offset(4)
            make.leading.equalTo(shadowView.snp.trailing).offset(6)
            make.width.equalTo(18)
        }
        
        numLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(numLabel)
            make.leading.equalTo(numLabel.snp.trailing).offset(6)
            make.trailing.equalToSuperview().inset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.equalTo(numLabel)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(thumbImageView).offset(2)
            make.height.equalTo(0.7)
        }
    }
}
