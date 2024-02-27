//
//  TabBarViewController.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit

class TabBarViewController: UITabBarController {
    
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
        
        tabBar.tintColor = .black
        
        let menuList = TabBarMenu.allCases
        
        let trendVC = menuList[0].viewContollerType
        let searchVC = menuList[1].viewContollerType
        let favoriteVC = menuList[2].viewContollerType
        let settingVC = menuList[3].viewContollerType
        
        trendVC.tabBarItem.image = UIImage(named: menuList[0].inactiveMenuImage)?.withRenderingMode(.alwaysOriginal)
        trendVC.tabBarItem.selectedImage = UIImage(named: menuList[0].activeMenuImage)?.withRenderingMode(.alwaysOriginal)
        searchVC.tabBarItem.image = UIImage(named: menuList[1].inactiveMenuImage)?.withRenderingMode(.alwaysOriginal)
        searchVC.tabBarItem.selectedImage = UIImage(named: menuList[1].activeMenuImage)?.withRenderingMode(.alwaysOriginal)
        favoriteVC.tabBarItem.image = UIImage(named: menuList[2].inactiveMenuImage)?.withRenderingMode(.alwaysOriginal)
        favoriteVC.tabBarItem.selectedImage = UIImage(named: menuList[2].activeMenuImage)?.withRenderingMode(.alwaysOriginal)
        settingVC.tabBarItem.image = UIImage(named: menuList[3].inactiveMenuImage)?.withRenderingMode(.alwaysOriginal)
        settingVC.tabBarItem.selectedImage = UIImage(named: menuList[3].activeMenuImage)?.withRenderingMode(.alwaysOriginal)
        
        setViewControllers([trendVC, searchVC, favoriteVC, settingVC], animated: true)
    }
    
}
