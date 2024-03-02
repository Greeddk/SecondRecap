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
    var delegate: reloadFavorite?
    
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
        if let coinMarket = coinMarket {
            mainView.inputData(coinMarket)
            viewModel.inputCoinMarket.value = coinMarket
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
            print(self.isFavorite)
            if self.isFavorite {
                self.image = "btn_star_fill"
            } else {
                self.image = "btn_star"
            }
            self.favoriteButton.image = UIImage(named: self.image)?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    override func configureViewController() {
        favoriteButton.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        favoriteButton.target = self
        favoriteButton.action = #selector(favoriteButtonClicked)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = favoriteButton
        navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.tintColor = .primary
        let customBackButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(customBackButtonClicked))
        navigationItem.leftBarButtonItem = customBackButton
    }
    
    @objc
    private func favoriteButtonClicked() {
        guard let coinId = coinMarket?.id else { return }
        viewModel.inputFavoriteButtonClicked.value = coinId
    }
    
    @objc
    private func customBackButtonClicked() {
        delegate?.fetchFavoriteList()
        navigationController?.popViewController(animated: true)
    }

}
