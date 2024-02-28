//
//  CoinChartViewController.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit

final class CoinChartViewController: BaseViewController {
    
    let mainView = CoinChartView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureViewController() {
        let favoriteButton = UIBarButtonItem(image: UIImage(named: "btn_star")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(favoriteButtonClicked))
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = favoriteButton
        navigationController?.navigationBar
    }
    
    @objc
    private func favoriteButtonClicked() {
        
    }

}
