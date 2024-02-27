//
//  FavoriteCoinCollectionViewCell.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import SnapKit

class FavoriteCoinCollectionViewCell: BaseCollectionViewCell {
    
    let backView = UIView()
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
        contentView.addSubviews([backView ,icon, coinName, coinSubname, price, changePercentage])
    }
    
    override func configureView() {
        backView.backgroundColor = .customLightGray
        backView.layer.cornerRadius = 20
        icon.layer.cornerRadius = 16
        coinName.font = .boldSystemFont(ofSize: 17)
        coinName.textColor = .customBlack
        coinSubname.font = .systemFont(ofSize: 12)
        coinSubname.textColor = .customLightBlack
        price.textColor = .customBlack
        price.font = .boldSystemFont(ofSize: 17)
        changePercentage.text = "+0.64%"
        changePercentage.font = .boldSystemFont(ofSize: 15)
        guard let text = changePercentage.text?.first else { return }
        changePercentage.textColor = text == "+" ? .redForHigh : .blueForLow
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(8)
        }
        
        icon.snp.makeConstraints { make in
            make.top.leading.equalTo(backView).offset(16)
            make.size.equalTo(32)
        }
        
        coinName.snp.makeConstraints { make in
            make.top.equalTo(icon)
            make.leading.equalTo(icon.snp.trailing).offset(8)
        }
        
        coinSubname.snp.makeConstraints { make in
            make.top.equalTo(coinName.snp.bottom)
            make.leading.equalTo(coinName)
        }
        
        changePercentage.snp.makeConstraints { make in
            make.leading.equalTo(icon)
            make.bottom.equalTo(backView.snp.bottom).offset(-16)
        }
        
        price.snp.makeConstraints { make in
            make.leading.equalTo(icon)
            make.bottom.equalTo(changePercentage.snp.top).offset(-8)
        }
    }
}
