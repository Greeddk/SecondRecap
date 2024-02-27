//
//  CoinTrendingTableViewCell.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import SnapKit

class CoinTrendingTableViewCell: BaseTableViewCell {
    
    let sectionLabel = UILabel()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews([sectionLabel, collectionView])
    }
    
    override func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView).inset(30)
            make.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
    }
    
    override func configureView() {
        sectionLabel.font = .boldSystemFont(ofSize: 22)
        sectionLabel.textColor = .customBlack
    }

    func collectionViewLayout() -> UICollectionViewLayout {
        let cellWidth = UIScreen.main.bounds.width - 70
        let spacing:CGFloat = 15
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: cellWidth, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
}
