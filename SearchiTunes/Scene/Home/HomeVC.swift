//
//  HomeVC.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/07.
//

import UIKit

final class HomeVC: UIViewController {
    
    private let mainView = HomeView()
    private let viewModel = HomeViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
    }
    
    private func configVC() {
        navigationItem.title = "앱"
//        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
