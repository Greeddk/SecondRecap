//
//  FavoriteCoinViewController.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit

class FavoriteCoinViewController: BaseViewController {
    
    let mainView = FavoriteCoinView()
    let viewModel = FavoriteCoinViewModel()
    
    var favoriteList: [CoinMarket] = []
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Favorite Coin"
        navigationController?.navigationBar.prefersLargeTitles = true
        reloadFavorite()
    }
    
    private func reloadFavorite() {
        viewModel.inputViewWillAppearTrigger.value = ()
        viewModel.outputFavoriteList.bind { value in
            guard let value = value else { return }
            self.favoriteList = value
            print(self.favoriteList.map { $0.id })
            self.mainView.collectionView.reloadData()
        }
    }
    
    override func configureViewController() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(CoinCardCollectionViewCell.self, forCellWithReuseIdentifier: CoinCardCollectionViewCell.identifier)
    }

}

extension FavoriteCoinViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinCardCollectionViewCell.identifier, for: indexPath) as! CoinCardCollectionViewCell
        cell.configureCell(item: favoriteList[indexPath.item])
        return cell
    }
    
}
