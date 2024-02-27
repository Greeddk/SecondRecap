//
//  CoinCardCollectionViewCell.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit

class CoinCardCollectionViewCell: BaseCollectionViewCell {
    
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
        contentView.addSubviews([backView])
        backView.addSubviews([icon, coinName, coinSubname, price, changePercentage])
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(4)
        }
        
        icon.snp.makeConstraints { make in
            make.leading.top.equalTo(backView).offset(12)
            make.size.equalTo(32)
        }
        
        coinName.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(8)
            make.top.equalTo(icon)
        }
        
        coinSubname.snp.makeConstraints { make in
            make.leading.equalTo(coinName)
            make.top.equalTo(coinName.snp.bottom)
        }
        
        changePercentage.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(25)
            make.trailing.bottom.equalTo(backView).inset(12)
        }
        
        price.snp.makeConstraints { make in
            make.trailing.equalTo(changePercentage.snp.trailing)
            make.bottom.equalTo(changePercentage.snp.top).offset(-4)
        }
        
    }
    
    override func configureView() {
        backView.clipsToBounds = false
        backView.layer.shadowOpacity = 0.05
        backView.layer.shadowRadius = 3
        backView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.cornerRadius = 12
        backView.backgroundColor = .customWhite
        
        coinName.font = .boldSystemFont(ofSize: 17)
        coinName.textColor = .customBlack
        coinSubname.font = .systemFont(ofSize: 12)
        coinSubname.textColor = .customLightBlack
        price.textColor = .customBlack
        price.font = .boldSystemFont(ofSize: 17)
        changePercentage.text = "+0.64%"
        changePercentage.font = .boldSystemFont(ofSize: 12)
        guard let text = changePercentage.text?.first else { return }
        changePercentage.textAlignment = .center
        changePercentage.textColor = text == "+" ? .redForHigh : .blueForLow
        changePercentage.backgroundColor = text == "+" ? .lightRed : .lightBlue
        changePercentage.clipsToBounds = true
        changePercentage.layer.cornerRadius = 4
    }
    
}
