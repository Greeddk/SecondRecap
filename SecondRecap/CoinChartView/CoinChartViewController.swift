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
    
    let favoriteButton = UIBarButtonItem()
    
    var id: String?
    var coinMarket: CoinMarket?
    var isFavorite = false
    lazy var image = isFavorite ? "btn_star_fill" : "btn_star"
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        transform()
    }
    
    override func configureViewController() {
        favoriteButton.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        favoriteButton.target = self
        favoriteButton.action = #selector(favoriteButtonClicked)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    private func transform() {
        if let coinmarket = coinMarket {
            mainView.inputData(coinmarket)
            viewModel.inputCoinMarket.value = coinmarket
        }
        viewModel.inputId.value = id
        viewModel.outputCoinMarket.bind { value in
            guard let value = value else { return }
            self.coinMarket = value
            self.mainView.inputData(value)
        }
        viewModel.inputViewDidLoadTrigger.value = ()
        viewModel.outputFavoriteStatus.bind { value in
            self.isFavorite = value
            if self.isFavorite {
                self.image = "btn_star_fill"
            } else {
                self.image = "btn_star"
            }
            self.favoriteButton.image = UIImage(named: self.image)?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    @objc
    private func favoriteButtonClicked() {
        guard let coinId = coinMarket?.id else { return }
        viewModel.inputFavoriteButtonClicked.value = coinId
    }

}
