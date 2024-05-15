//
//  FavoriteCoinViewController.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit

protocol reloadFavorite {
    func fetchFavoriteList()
}

final class FavoriteCoinViewController: BaseViewController {
    
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
        navigationItem.title = "즐겨찾기한 코인"
        navigationController?.navigationBar.prefersLargeTitles = true
        reloadFavorite()
    }
    
    private func reloadFavorite() {
        viewModel.inputFetchFavoriteListTrigger.value = ()
        viewModel.outputFavoriteList.bind { value in
            guard let value = value else { return }
            self.favoriteList = value
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CoinChartViewController()
        vc.coinMarket = favoriteList[indexPath.item]
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension FavoriteCoinViewController: reloadFavorite {
    func fetchFavoriteList() {
        reloadFavorite()
    }
}
