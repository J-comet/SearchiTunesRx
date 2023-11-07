//
//  TabBarVC.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/07.
//

import UIKit

final class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 0
        let viewControllers = [tapVC(type: .home), tapVC(type: .search)]
        setViewControllers(viewControllers, animated: true)
        
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        tabBar.tintColor = .white
        tabBar.isTranslucent = false
    }
    
    private func tapVC(type: TabType) -> UINavigationController {
        let nav = UINavigationController()
        nav.addChild(type.vc)
        nav.tabBarItem.image = type.icon.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        nav.tabBarItem.selectedImage = type.icon.withTintColor(.link, renderingMode: .alwaysOriginal)
        return nav
    }
}

extension TabBarVC {
    
    enum TabType {
        case home
        case search
        
        var vc: UIViewController {
            switch self {
            case .home:
                return HomeVC()
            case .search:
                return SearchMainVC()
            }
        }
        
        var icon: UIImage {
            switch self {
            case .home:
                return UIImage(systemName: "house.fill")!
            case .search:
                return UIImage(systemName: "magnifyingglass")!
            }
        }
    }
}
