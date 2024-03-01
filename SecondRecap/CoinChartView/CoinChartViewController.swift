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
    lazy var isFavorite = viewModel.outputFavoriteStatus.value ? "btn_star_fill" : "btn_star"
    
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
        viewModel.inputViewDidLoadTrigger.value = ()
    }
    
    override func configureViewController() {
        let favoriteButton = UIBarButtonItem(image: UIImage(named: isFavorite)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(favoriteButtonClicked))
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc
    private func favoriteButtonClicked() {
        viewModel.inputFavoriteButtonClicked.value = coinMarket.id
        if viewModel.outputFavoriteStatus.value {
            isFavorite = "btn_star"
        } else {
            isFavorite = "btn_star_fill"
        }
    }

}
