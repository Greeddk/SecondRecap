//
//  CoinSearchViewController.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit

class CoinSearchViewController: BaseViewController {
    
    let mainView = CoinSearchView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureViewController() {
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        mainView.searchBar.delegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SearchedCoinTableViewCell.self, forCellReuseIdentifier: SearchedCoinTableViewCell.identifier)
    }

}

extension CoinSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchedCoinTableViewCell.identifier, for: indexPath) as! SearchedCoinTableViewCell
        cell.icon.image = UIImage(systemName: "person")
        cell.coinName.text = "Bitcoin"
        cell.coinSubname.text = "BTC"
        cell.favoriteButton.setImage(UIImage(named: "btn_star"), for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CoinChartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CoinSearchViewController: UISearchBarDelegate {
    
}
