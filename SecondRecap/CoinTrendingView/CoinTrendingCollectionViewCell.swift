//
//  CoinTrendingCollectionViewCell.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import SnapKit
import Kingfisher

class CoinTrendingCollectionViewCell: BaseCollectionViewCell {
    
    let rank = UILabel()
    let icon = UIImageView()
    let coinName = UILabel()
    let coinSymbolname = UILabel()
    let price = UILabel()
    let changePercentage = UILabel()
    let lineView = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews([rank, icon, coinName, coinSymbolname, price, changePercentage, lineView])
    }
    
    override func configureLayout() {
        rank.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(34)
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
        
        coinSymbolname.snp.makeConstraints { make in
            make.leading.equalTo(coinName)
            make.top.equalTo(coinName.snp.bottom)
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(coinName)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        changePercentage.snp.makeConstraints { make in
            make.top.equalTo(coinSymbolname)
            make.trailing.equalTo(price.snp.trailing)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.leading.equalTo(rank.snp.leading)
            make.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
    }
    
    override func configureView() {
        rank.font = .boldSystemFont(ofSize: 22)
        coinName.font = .boldSystemFont(ofSize: 17)
        coinName.textColor = .customBlack
        coinSymbolname.font = .systemFont(ofSize: 12)
        coinSymbolname.textColor = .customLightBlack
        price.textColor = .customBlack
        changePercentage.text = "+0.64%"
    }
    
}

extension CoinTrendingCollectionViewCell {
    
    func configureCoinCell(_ item: Coin, indexPath: IndexPath) {
        rank.text = "\(indexPath.item + 1)"
        guard let iconURL = item.icon else { return }
        let url = URL(string: iconURL)
        icon.kf.setImage(with: url)
        coinName.text = item.name
        coinSymbolname.text = item.symbol
        guard let data = item.data else { return }
        let attributedString = data.price.asAttributedString()
        price.attributedText = attributedString
        price.font = .systemFont(ofSize: 15)
        let percentage = data.change_percentage.krw
        changePercentage.textColor = percentage < 0 ? .blueForLow : .redForHigh
        let sign = percentage >= 0 ? "+" : ""
        changePercentage.text = sign + String(format: "%.2f", data.change_percentage.krw) + "%"
        changePercentage.font = .systemFont(ofSize: 12)
        if indexPath.item % 3 == 2 {
            lineView.backgroundColor = .clear
        } else {
            lineView.backgroundColor = .customLightGray
        }
    }
    
    func configureNFTCell(_ item: NFT, indexPath: IndexPath) {
        rank.text = "\(indexPath.item + 1)"
        coinName.text = item.name
        coinSymbolname.text = item.id
        let url = URL(string: item.thumb)
        icon.kf.setImage(with: url)
        price.text = item.data.floor_price
        price.font = .systemFont(ofSize: 15)
        guard let text = changePercentage.text?.first else { return }
        changePercentage.textColor = text == "-" ? .blueForLow : .redForHigh
        let sign = text != "-" ? "+" : ""
        changePercentage.text = sign + String(format: "%.2f", Double(item.data.change_percentage) ?? 0) + "%"
        changePercentage.font = .systemFont(ofSize: 12)
        if indexPath.item % 3 == 2 {
            lineView.backgroundColor = .clear
        } else {
            lineView.backgroundColor = .customLightGray
        }
    }
}
