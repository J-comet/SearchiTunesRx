//
//  SearchDetailView.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/07.
//

import UIKit

import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

final class SearchDetailView: UIView {
    
    let count = 1.2
    let collectionViewSpacing: CGFloat = 8
    lazy var width: CGFloat = UIScreen.main.bounds.width - (collectionViewSpacing * (count + 1))
    lazy var collectionViewHeight = (width / count) * 1.6
    
    private lazy var scrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private let containerView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let topContentView = UIView()
    
    private let bottomContentView = UIView()
    
    private let iconImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let nameLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 16)
        view.textColor = .black
        view.numberOfLines = 2
        return view
    }()
    
    private let genreLabel = {
        let view = UILabel()
        view.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
        view.textColor = .gray
        return view
    }()
    
    private let ageLabel = {
        let view = UILabel()
        view.font = .monospacedSystemFont(ofSize: 12, weight: .regular)
        view.textColor = .gray
        return view
    }()
    
    private let averageUserRatingLabel = {
        let view = UILabel()
        view.font = .monospacedSystemFont(ofSize: 12, weight: .regular)
        view.textColor = .gray
        return view
    }()
    
    private let priceLabel = {
        let view = UILabel()
        view.font = .monospacedSystemFont(ofSize: 12, weight: .regular)
        view.textColor = .black
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
    
    private let guideReleaseNoteLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        view.textColor = .black
        view.text = "새로운 소식"
        return view
    }()
    
    private let versionLabel = {
        let view = UILabel()
        view.font = .monospacedSystemFont(ofSize: 14, weight: .medium)
        view.textColor = .gray
        return view
    }()
    
    private let releaseLabel = {
        let view = UILabel()
        view.font = .monospacedSystemFont(ofSize: 13, weight: .regular)
        view.textColor = .gray
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        return view
    }()
    
    lazy var screenshotCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout())
        view.showsHorizontalScrollIndicator = false
        view.register(ScreenshotCell.self, forCellWithReuseIdentifier: ScreenshotCell.identifier)
        return view
    }()
    
    private let descriptionLabel = {
        let view = UILabel()
        view.font = .monospacedSystemFont(ofSize: 14, weight: .medium)
        view.textColor = .gray
        view.numberOfLines = 0
        view.lineBreakMode = .byCharWrapping
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configure()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func fetchData(item: AppInfo) {
        nameLabel.text = item.trackName
        genreLabel.text = item.genres.first
        ageLabel.text = item.trackContentRating
        averageUserRatingLabel.text = item.ratingValue
        priceLabel.text = item.priceValue
        versionLabel.text = item.versionValue
        releaseLabel.text = item.releaseNotes
        descriptionLabel.text = item.description
        
        if let url = URL(string: item.artworkUrl512) {
            iconImageView.kf.setImage(with: url)
        }
    }
    
    private func configure() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(topContentView)
        containerView.addSubview(bottomContentView)
        
        topContentView.addSubview(shadowView)
        topContentView.addSubview(iconImageView)
        topContentView.addSubview(nameLabel)
        topContentView.addSubview(genreLabel)
        topContentView.addSubview(ageLabel)
        topContentView.addSubview(averageUserRatingLabel)
        topContentView.addSubview(priceLabel)
        
        bottomContentView.addSubview(guideReleaseNoteLabel)
        bottomContentView.addSubview(versionLabel)
        bottomContentView.addSubview(releaseLabel)
        bottomContentView.addSubview(screenshotCollectionView)
        bottomContentView.addSubview(descriptionLabel)
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerX.top.bottom.equalToSuperview()
//            make.top.equalToSuperview()
//            make.width.equalToSuperview()
//            make.bottom.equalToSuperview()
        }
 
        topContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        bottomContentView.snp.makeConstraints { make in
            make.top.equalTo(topContentView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(100)
        }
        
        shadowView.snp.makeConstraints { make in
            make.edges.equalTo(iconImageView).inset(1)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.leading.equalTo(shadowView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(genreLabel)
            make.leading.equalTo(genreLabel.snp.trailing).offset(8)
        }
        
        averageUserRatingLabel.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(8)
            make.leading.equalTo(genreLabel)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(averageUserRatingLabel.snp.bottom).offset(8)
            make.leading.equalTo(averageUserRatingLabel)
        }
        
        guideReleaseNoteLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(guideReleaseNoteLabel.snp.bottom).offset(6)
            make.leading.equalTo(guideReleaseNoteLabel)
        }
        
        releaseLabel.snp.makeConstraints { make in
            make.top.equalTo(versionLabel.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview()
        }
        
        screenshotCollectionView.snp.makeConstraints { make in
            make.top.equalTo(releaseLabel.snp.bottom).offset(16)
            make.height.equalTo(collectionViewHeight)
            make.horizontalEdges.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(screenshotCollectionView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension SearchDetailView {
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width / count, height: collectionViewHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        return layout
    }
    
}
