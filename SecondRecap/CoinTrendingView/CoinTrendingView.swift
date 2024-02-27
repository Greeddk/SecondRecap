//
//  CoinTrendingView.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import SnapKit

class CoinTrendingView: BaseView {
    
    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        addSubviews([tableView])
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }

}
