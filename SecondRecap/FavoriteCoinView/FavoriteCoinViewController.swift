//
//  FavoriteCoinViewController.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit

class FavoriteCoinViewController: BaseViewController {
    
    let mainView = FavoriteCoinView()
    
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
    }
    
    override func configureViewController() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(CoinCardCollectionViewCell.self, forCellWithReuseIdentifier: CoinCardCollectionViewCell.identifier)
    }

}

extension FavoriteCoinViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinCardCollectionViewCell.identifier, for: indexPath) as! CoinCardCollectionViewCell
        cell.icon.image = UIImage(systemName: "person")
        cell.coinName.text = "Bitcoin"
        cell.coinSymbolname.text = "BTC"
        cell.price.text = "₩69,234,245"
        return cell
    }
    
}
