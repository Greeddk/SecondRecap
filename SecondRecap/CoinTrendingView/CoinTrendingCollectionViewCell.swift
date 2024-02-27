//
//  CoinTrendingCollectionViewCell.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import SnapKit

class CoinTrendingCollectionViewCell: BaseCollectionViewCell {
    
    let rank = UILabel()
    let icon = UIImageView()
    let coinName = UILabel()
    let coinSubname = UILabel()
    let price = UILabel()
    let changePercentage = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews([rank, icon, coinName, coinSubname, price, changePercentage])
    }
    
    override func configureLayout() {
        rank.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(4)
            make.centerY.equalToSuperview()
        }
        
        icon.snp.makeConstraints { make in
            make.leading.equalTo(rank.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(32)
        }
        
        coinName.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(12)
            make.top.equalTo(icon)
        }
        
        coinSubname.snp.makeConstraints { make in
            make.leading.equalTo(coinName)
            make.top.equalTo(coinName.snp.bottom)
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(coinName)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        changePercentage.snp.makeConstraints { make in
            make.top.equalTo(coinSubname)
            make.trailing.equalTo(price.snp.trailing)
        }
    }
    
    override func configureView() {
        rank.font = .boldSystemFont(ofSize: 22)
        coinName.font = .boldSystemFont(ofSize: 17)
        coinName.textColor = .customBlack
        coinSubname.font = .systemFont(ofSize: 12)
        coinSubname.textColor = .customLightBlack
        price.textColor = .customBlack
        price.font = .systemFont(ofSize: 17)
        changePercentage.text = "+0.64%"
        changePercentage.font = .systemFont(ofSize: 12)
        guard let text = changePercentage.text?.first else { return }
        changePercentage.textColor = text == "+" ? .redForHigh : .blueForLow
    }
    
}
