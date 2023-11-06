//
//  SearchiTuneCell.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/06.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class SearchiTuneCell: UITableViewCell {
    
    static let identifier = "SearchiTuneCell"
    
    let nameLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.textColor = .black
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configure()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(row: AppInfo) {
        nameLabel.text = row.trackName
    }
    
    private func configure() {
        contentView.addSubview(nameLabel)
    }
    
    private func setLayout() {
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
    }
}
