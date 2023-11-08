//
//  SearchiTuneCell.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/06.
//

import UIKit

import Kingfisher
import SnapKit
import RxSwift
import RxCocoa

final class SearchiTuneCell: UITableViewCell {
    
    static let identifier = "SearchiTuneCell"
    
    let topContainerViewTapGesture = UITapGestureRecognizer()
    lazy var topContainerView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(topContainerViewTapGesture)
        return view
    }()
    
    let nameLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.textColor = .black
        return view
    }()
    
    let appIconImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
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
    
    private let averageUserRatingLabel = {
        let view = UILabel()
        view.font = .monospacedSystemFont(ofSize: 14, weight: .semibold)
        view.textColor = .lightGray
        return view
    }()
    
    private let genreLabel = {
        let view = UILabel()
        view.font = .monospacedSystemFont(ofSize: 14, weight: .medium)
        view.textColor = .gray
        return view
    }()
    
    var screenshotImages = PublishRelay<[String]>()
    
    var disposeBag = DisposeBag()
    
    lazy var screenshotCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout())
        view.showsHorizontalScrollIndicator = false
        view.register(ScreenshotCell.self, forCellWithReuseIdentifier: ScreenshotCell.identifier)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configure()
        setLayout()
        bindScreenShotsCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
//        appIconImageView.image = nil
        bindScreenShotsCollectionView()
    }
    
    private func bindScreenShotsCollectionView() {
        screenshotImages
            .bind(to: screenshotCollectionView.rx.items(cellIdentifier: ScreenshotCell.identifier, cellType: ScreenshotCell.self)) { (row, element, cell) in
                cell.configCell(url: element)
            }
            .disposed(by: disposeBag)
    }
    
    func configCell(row: AppInfo) {
        nameLabel.text = row.trackName
        averageUserRatingLabel.text = row.ratingValue
        genreLabel.text = row.genres.first
        
//        print("데이터 전달 \(row.screenshotUrls.count)")
        screenshotImages.accept(row.screenshotUrls)
        
        if let url = URL(string: row.artworkUrl512) {
            appIconImageView.kf.setImage(with: url)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
    }
    
    private func configure() {
        contentView.addSubview(topContainerView)
        contentView.addSubview(screenshotCollectionView)
        topContainerView.addSubview(shadowView)
        topContainerView.addSubview(appIconImageView)
        topContainerView.addSubview(nameLabel)
        topContainerView.addSubview(averageUserRatingLabel)
        topContainerView.addSubview(genreLabel)
    }
    
    private func setLayout() {
        
        topContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        
        appIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.size.equalTo(60)
            make.leading.equalToSuperview().inset(16)
        }
        
        shadowView.snp.makeConstraints { make in
            make.edges.equalTo(appIconImageView).inset(1)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(shadowView)
            make.leading.equalTo(shadowView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        averageUserRatingLabel.snp.makeConstraints { make in
            make.top.equalTo(shadowView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(averageUserRatingLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        screenshotCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topContainerView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension SearchiTuneCell {
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let count: CGFloat = 2.4
        let width: CGFloat = UIScreen.main.bounds.width - (spacing * (count + 1)) // 디바이스 너비 계산
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width / count, height: (width / count) * 1.9)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        return layout
    }
    
}
