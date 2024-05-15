//
//  TabBarViewController.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    enum TabBarMenu: CaseIterable {
        case coinTrending
        case coinSearch
        case favoriteCoin
        case setting
        
        var viewContollerType: UIViewController {
            switch self {
            case .coinTrending:
                UINavigationController(rootViewController: CoinTrendingViewController())
            case .coinSearch:
                UINavigationController(rootViewController: CoinSearchViewController())
            case .favoriteCoin:
                UINavigationController(rootViewController: FavoriteCoinViewController())
            case .setting:
                UINavigationController(rootViewController: SettingViewController())
            }
        }
        
        var activeMenuImage: String {
            switch self {
            case .coinTrending:
                return "tab_trend"
            case .coinSearch:
                return "tab_search"
            case .favoriteCoin:
                return "tab_portfolio"
            case .setting:
                return "tab_user"
            }
        }
        
        var inactiveMenuImage: String {
            switch self {
            case .coinTrending:
                return "tab_trend_inactive"
            case .coinSearch:
                return "tab_search_inactive"
            case .favoriteCoin:
                return "tab_portfolio_inactive"
            case .setting:
                return "tab_user_inactive"
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuList = TabBarMenu.allCases
        
        let trendVC = menuList[0].viewContollerType
        let searchVC = menuList[1].viewContollerType
        let favoriteVC = menuList[2].viewContollerType
        let settingVC = menuList[3].viewContollerType
        
        trendVC.tabBarItem.image = UIImage(named: menuList[0].inactiveMenuImage)?.withRenderingMode(.alwaysOriginal)
        trendVC.tabBarItem.selectedImage = UIImage(named: menuList[0].activeMenuImage)
        trendVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0)
        searchVC.tabBarItem.image = UIImage(named: menuList[1].inactiveMenuImage)?.withRenderingMode(.alwaysOriginal)
        searchVC.tabBarItem.selectedImage = UIImage(named: menuList[1].activeMenuImage)
        searchVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0)
        favoriteVC.tabBarItem.image = UIImage(named: menuList[2].inactiveMenuImage)?.withRenderingMode(.alwaysOriginal)
        favoriteVC.tabBarItem.selectedImage = UIImage(named: menuList[2].activeMenuImage)
        favoriteVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0)
        settingVC.tabBarItem.image = UIImage(named: menuList[3].inactiveMenuImage)?.withRenderingMode(.alwaysOriginal)
        settingVC.tabBarItem.selectedImage = UIImage(named: menuList[3].activeMenuImage)
        settingVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.layer.borderColor = UIColor.customLightGray.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.tintColor = .primary
        setViewControllers([trendVC, searchVC, favoriteVC, settingVC], animated: true)
        
    }
    
}
