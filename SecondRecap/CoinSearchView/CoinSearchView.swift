//
//  CoinSearchView.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import SnapKit

class CoinSearchView: BaseView {

    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        addSubviews([searchBar, tableView])
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(12)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        searchBar.searchBarStyle = .minimal
    }
    
}
