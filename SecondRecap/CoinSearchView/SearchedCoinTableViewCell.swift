//
//  SearchedCoinTableViewCell.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import SnapKit

class SearchedCoinTableViewCell: BaseTableViewCell {
    
    let icon = UIImageView()
    let coinName = UILabel()
    let coinSymbolname = UILabel()
    let favoriteButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews([icon, coinName, coinSymbolname, favoriteButton])
    }
    
    override func configureLayout() {
        icon.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(32)
        }
        
        coinName.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(4)
            make.top.equalTo(icon)
        }
        
        coinSymbolname.snp.makeConstraints { make in
            make.leading.equalTo(coinName)
            make.top.equalTo(coinName.snp.bottom)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(20)
            make.centerY.equalTo(contentView)
            make.size.equalTo(24)
        }
    }
    
    override func configureView() {
        coinName.font = .boldSystemFont(ofSize: 17)
        coinName.textColor = .customBlack
        coinSymbolname.font = .systemFont(ofSize: 12)
        coinSymbolname.textColor = .customLightBlack
    }
    
}
