//
//  SearchedCoinTableViewCell.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import SnapKit
import Kingfisher

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
            make.leading.equalTo(icon.snp.trailing).offset(12)
            make.trailing.equalTo(favoriteButton.snp.leading).offset(-10)
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

extension SearchedCoinTableViewCell {
    func configureCell(_ item: Coin, attributeString: String) {
        guard let thumb = item.thumb else { return }
        let url = URL(string: thumb)
        icon.kf.setImage(with: url)
        coinName.attributedText = changeAllOccurrence(entireString: item.name, searchString: attributeString)
        coinSymbolname.text = item.symbol
        favoriteButton.setImage(UIImage(named: "btn_star"), for: .normal)
    }
    
    private func changeAllOccurrence(entireString: String,searchString: String) -> NSMutableAttributedString{
        let attrStr = NSMutableAttributedString(string: entireString)
        let entireLength = entireString.count
        var range = NSRange(location: 0, length: entireLength)
        var rangeArr = [NSRange]()
        
        while (range.location != NSNotFound) {
            
            range = (attrStr.string as NSString).range(of: searchString, options: .caseInsensitive, range: range)
            rangeArr.append(range)
            if (range.location != NSNotFound) {
                range = NSRange(location: range.location + range.length, length: entireString.count - (range.location + range.length))
            }
        }
        rangeArr.forEach { (range) in
            attrStr.addAttribute(.foregroundColor, value: UIColor.primary, range: range)
        }
        return attrStr
    }
    
}
