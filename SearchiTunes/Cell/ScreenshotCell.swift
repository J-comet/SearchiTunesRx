//
//  ScreenshotCell.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/07.
//

import UIKit

import SnapKit
import Kingfisher

final class ScreenshotCell: UICollectionViewCell {
    
    static let identifier = "ScreenshotCell"
    
    let thumbImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let shadowView = {
        let view = UIImageView()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1 // 그림자 불투명도
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero // 그림자 방향. .zero
        view.layer.shadowRadius = 8 // 그림자 퍼짐의 정도
        view.layer.masksToBounds = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImageView.image = nil
    }
    
    func configCell(url: String) {
        if let url = URL(string: url) {
            thumbImageView.kf.setImage(
                with: url,
                placeholder: nil,
                options: [
                    .processor(DownsamplingImageProcessor(size: CGSize(width: 200, height: 500))),
                    .scaleFactor(UIScreen.main.scale),
                    .cacheOriginalImage
                ]
            )
        }
    }
    
    private func configure() {
        contentView.addSubview(shadowView)
        contentView.addSubview(thumbImageView)
    }
    
    private func setLayout() {
        thumbImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(2)
        }
        
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(3)
        }
    }
}
