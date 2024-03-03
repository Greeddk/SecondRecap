//
//  CoinCardCollectionViewCell.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import Kingfisher

final class CoinCardCollectionViewCell: BaseCollectionViewCell {
    
    let backView = UIView()
    let icon = UIImageView()
    let coinName = UILabel()
    let coinSymbolname = UILabel()
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
        backView.addSubviews([icon, coinName, coinSymbolname, price, changePercentage])
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
            make.trailing.equalTo(backView.snp.trailing).inset(8)
            make.top.equalTo(icon)
        }
        
        coinSymbolname.snp.makeConstraints { make in
            make.leading.equalTo(coinName)
            make.top.equalTo(coinName.snp.bottom)
        }
        
        changePercentage.snp.makeConstraints { make in
            make.width.equalTo(70)
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
        backView.layer.shadowOpacity = 0.1
        backView.layer.shadowRadius = 4
        backView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.cornerRadius = 12
        backView.backgroundColor = .customWhite
        coinName.font = .boldSystemFont(ofSize: 17)
        coinName.textColor = .customBlack
        coinSymbolname.font = .systemFont(ofSize: 12)
        coinSymbolname.textColor = .customLightBlack
        price.textColor = .customBlack
        price.font = .boldSystemFont(ofSize: 17)
        changePercentage.text = "+0.64%"
        changePercentage.font = .boldSystemFont(ofSize: 12)
        changePercentage.clipsToBounds = true
        changePercentage.layer.cornerRadius = 4
    }
    
    func configureCell(item: CoinMarket) {
        let url = URL(string: item.image)
        icon.kf.setImage(with: url)
        coinName.text = item.id
        coinSymbolname.text = item.symbol
        price.text = "₩\(item.current_price)"
        changePercentage.textAlignment = .center
        changePercentage.textColor = item.change_percentage >= 0 ? .redForHigh : .blueForLow
        changePercentage.backgroundColor = item.change_percentage >= 0  ? .lightRed : .lightBlue
        let sign = item.change_percentage >= 0 ? "+" : " "
        changePercentage.text = sign + String(format: "%.2f",item.change_percentage) + "%"
    }
    
}
