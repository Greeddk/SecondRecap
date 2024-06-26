//
//  CoinCardCollectionViewCell.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CoinCardCollectionViewCell: BaseCollectionViewCell {
    
    let backView = UIView()
    let icon = UIImageView()
    let coinName = UILabel()
    let coinSymbolname = UILabel()
    let price = UILabel()
    let changePercentage = UILabel()
    let chart = CustomChartView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews([backView])
        backView.addSubviews([icon, coinName, coinSymbolname, price, changePercentage, chart])
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
        
        price.snp.makeConstraints { make in
            make.top.equalTo(coinSymbolname.snp.bottom).offset(2)
            make.trailing.equalTo(changePercentage.snp.leading).offset(-10)
        }
        
        changePercentage.snp.makeConstraints { make in
            make.centerY.equalTo(price)
            make.trailing.equalTo(backView.snp.trailing).offset(-10)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
        
        chart.snp.makeConstraints { make in
            make.top.equalTo(price.snp.bottom)
            make.horizontalEdges.equalTo(contentView)
            make.bottom.equalTo(backView.snp.bottom)
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
        price.font = .boldSystemFont(ofSize: 14)
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
        chart.configureChart(item)
    }
    
}
