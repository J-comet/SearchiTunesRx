//
//  SearchMainView.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/06.
//

import UIKit

import SnapKit

final class SearchMainView: UIView {
    
    let searchBar = UISearchBar()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.register(SearchiTuneCell.self, forCellReuseIdentifier: SearchiTuneCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 100
        view.separatorStyle = .none
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
    
    private func configure() {
        backgroundColor = .white
        addSubview(tableView)
    }
    
    private func setLayout() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
}
