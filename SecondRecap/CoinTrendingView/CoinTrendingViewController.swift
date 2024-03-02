//
//  ViewController.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import SnapKit

final class CoinTrendingViewController: BaseViewController {
    
    var favoriteList: [CoinMarket] = []
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
        navigationItem.title = "Crypto Coin"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputViewDidLoadTrigger.value = ()
        viewModel.outputList.bind { value in
            self.list = value
            self.mainView.tableView.reloadData()
        }
        reloadFavorite()
    }
    
    private func reloadFavorite() {
        viewModel.inputFavoriteListTrigger.value = ()
        viewModel.outputFavoriteList.bind { value in
            guard let value = value else { return }
            self.favoriteList = value
            print(self.favoriteList.map { $0.id })
            self.mainView.tableView.reloadSections([0], with: .fade)
        }
    }
    
    override func configureViewController() {
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
            if favoriteList.count <= 1 {
                return UITableViewCell()
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as! FavoriteTableViewCell
                cell.sectionLabel.text = HeaderTitle.allCases[indexPath.section].rawValue
                cell.collectionView.delegate = self
                cell.collectionView.dataSource = self
                cell.collectionView.tag = indexPath.section
                cell.collectionView.register(FavoriteCoinCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCoinCollectionViewCell.identifier)
                cell.collectionView.reloadData()
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CoinTrendingTableViewCell.identifier, for: indexPath) as! CoinTrendingTableViewCell
            cell.sectionLabel.text = HeaderTitle.allCases[indexPath.section].rawValue
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.tag = indexPath.section
            cell.collectionView.register(CoinTrendingCollectionViewCell.self, forCellWithReuseIdentifier: CoinTrendingCollectionViewCell.identifier)
            cell.collectionView.reloadData()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if favoriteList.count < 2 {
                return 0
            } else {
                return 230
            }
        } else {
            return 270
        }
    }
    
}

extension CoinTrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            if favoriteList.count >= 4 {
                return 4
            } else if favoriteList.count >= 2 {
                return favoriteList.count
            } else {
                return 0
            }
        } else if collectionView.tag == 1 {
            return list.coins.count
        } else {
            return list.nfts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCoinCollectionViewCell.identifier, for: indexPath) as! FavoriteCoinCollectionViewCell
            if indexPath.item == 3 {
                cell.icon.image = nil
                cell.coinName.text = "더보기"
                cell.coinSymbolname.text = ""
                cell.price.text = ""
                cell.changePercentage.text = ""
                return cell
            } else {
                cell.configureCell(item: favoriteList[indexPath.item])
                return cell
            }
        } else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinTrendingCollectionViewCell.identifier, for: indexPath) as! CoinTrendingCollectionViewCell
            let item = list.coins[indexPath.item].item
            cell.configureCoinCell(item, indexPath: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinTrendingCollectionViewCell.identifier, for: indexPath) as! CoinTrendingCollectionViewCell
            let item = list.nfts[indexPath.item]
            cell.configureNFTCell(item, indexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView.tag == 0 {
            if indexPath.item == 3 {
                self.tabBarController?.selectedIndex = 2
            } else {
                let vc = CoinChartViewController()
                vc.coinMarket = favoriteList[indexPath.item]
                navigationController?.pushViewController(vc, animated: true)
            }
        } else if collectionView.tag == 1 {
            let vc = CoinChartViewController()
            vc.id = list.coins[indexPath.item].item.id
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
