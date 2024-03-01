//
//  CoinChartViewController.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit

final class CoinChartViewController: BaseViewController {
    
    let mainView = CoinChartView()
    let viewModel = CoinChartViewModel()
    
    var id: String?
    var coinMarket: CoinMarket!
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputId.value = id
        viewModel.outputCoinMarket.bind { value in
            self.coinMarket = value
            guard let value = value else { return }
            self.mainView.inputData(value)
        }
        
    }
    
    override func configureViewController() {
        let favoriteButton = UIBarButtonItem(image: UIImage(named: "btn_star")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(favoriteButtonClicked))
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc
    private func favoriteButtonClicked() {
        
    }

}
