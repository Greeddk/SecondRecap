//
//  CoinSearchViewController.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import Toast

final class CoinSearchViewController: BaseViewController {
    
    let mainView = CoinSearchView()
    let viewModel = CoinSearchViewModel()
    var resultList: [Coin] = []
    var favoriteList: [FavoriteCoin] = []
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.outputSearchResult.bind { value in
            self.resultList = value.coins
            self.mainView.tableView.reloadData()
        }
        viewModel.outputToastMessage.bind { message in
            self.view.makeToast(message, duration: 2, position: .bottom)
        }
        viewModel.outputFavoriteList.bind { value in
            self.favoriteList = value
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "코인 검색"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func configureViewController() {
        mainView.searchBar.delegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SearchedCoinTableViewCell.self, forCellReuseIdentifier: SearchedCoinTableViewCell.identifier)
    }

}

extension CoinSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultList.count < 26 {
            return resultList.count
        } else {
            return 25
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchedCoinTableViewCell.identifier, for: indexPath) as! SearchedCoinTableViewCell
        let item = resultList[indexPath.row]
        let isFavorite = favoriteList.contains { $0.id == item.id }
        cell.configureCell(item, attributeString: viewModel.outputSearchText.value ?? "", isFavorite: isFavorite)
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addAction(UIAction(handler: { _ in
            self.viewModel.inputFavoriteButtonClicked.value = item.id
            self.viewModel.inputIndex.value = indexPath.row
            self.viewModel.inputFavoriteListRequest.value = ()
            let value = self.favoriteList.contains { $0.id == item.id }
            cell.changeImage(value: value)
        }), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = CoinChartViewController()
        vc.id = resultList[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CoinSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchText.value = searchBar.text
        view.endEditing(true)
        let indexPath = NSIndexPath(row: NSNotFound, section: 0)
        mainView.tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
    }
    
}
