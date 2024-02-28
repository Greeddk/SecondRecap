//
//  ViewController.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import SnapKit
import Kingfisher

class CoinTrendingViewController: BaseViewController {
    
    var list: CoinTrending = CoinTrending(coins: [], nfts: [])
    
    enum HeaderTitle: String, CaseIterable {
        case favorite = "My Favorite"
        case top15 = "Top15 Coin"
        case top7 = "Top7 NFT"
    }
    
    let viewModel = CoinTrendingViewModel()
    let mainView = CoinTrendingView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewDidLoadTrigger.value = ()
        viewModel.outputList.bind { value in
            self.list = value
            self.mainView.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureViewController() {
        navigationItem.title = "Crypto Coin"
        navigationController?.navigationBar.prefersLargeTitles = true
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        mainView.tableView.register(CoinTrendingTableViewCell.self, forCellReuseIdentifier: CoinTrendingTableViewCell.identifier)
    }

}

extension CoinTrendingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as! FavoriteTableViewCell
            cell.sectionLabel.text = HeaderTitle.favorite.rawValue
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.tag = indexPath.section
            cell.collectionView.register(FavoriteCoinCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCoinCollectionViewCell.identifier)
            cell.collectionView.showsHorizontalScrollIndicator = false
            cell.collectionView.reloadData()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CoinTrendingTableViewCell.identifier, for: indexPath) as! CoinTrendingTableViewCell
            cell.sectionLabel.text = HeaderTitle.allCases[indexPath.section].rawValue
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.tag = indexPath.section
            cell.collectionView.register(CoinTrendingCollectionViewCell.self, forCellWithReuseIdentifier: CoinTrendingCollectionViewCell.identifier)
            cell.collectionView.showsHorizontalScrollIndicator = false
            cell.collectionView.reloadData()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 230
        } else {
            return 270
        }
    }
    
}

extension CoinTrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return 5
        } else if collectionView.tag == 1 {

                return list.coins.count
        } else {
            return list.nfts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCoinCollectionViewCell.identifier, for: indexPath) as! FavoriteCoinCollectionViewCell
            cell.coinName.text = "Bitcoin"
            cell.icon.image = UIImage(systemName: "person")
            cell.coinSymbolname.text = "BTC"
            cell.price.text = "₩74,213,566"
            return cell
        } else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinTrendingCollectionViewCell.identifier, for: indexPath) as! CoinTrendingCollectionViewCell
            let item = list.coins[indexPath.item].item
            cell.rank.text = "\(indexPath.item + 1)"
            let url = URL(string: item.icon)
            cell.icon.kf.setImage(with: url)
            cell.coinName.text = item.name
            cell.coinSymbolname.text = item.symbol
            cell.price.text = item.data.price
            cell.changePercentage.text = String(describing: item.data.change_percentage.krw)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinTrendingCollectionViewCell.identifier, for: indexPath) as! CoinTrendingCollectionViewCell
            let item = list.nfts[indexPath.item]
            cell.rank.text = "\(indexPath.item + 1)"
            cell.coinName.text = item.name
            cell.coinSymbolname.text = item.id
            let url = URL(string: item.thumb)
            cell.icon.kf.setImage(with: url)
            cell.price.text = item.data.floor_price
            cell.changePercentage.text = item.data.change_percentage
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CoinChartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
