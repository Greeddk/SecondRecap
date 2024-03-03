//
//  FavoriteTableViewCell.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import SnapKit

final class FavoriteTableViewCell: BaseTableViewCell {
    
    let sectionLabel = UILabel()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubviews([sectionLabel, collectionView])
    }
    
    override func configureView() {
        collectionView.showsHorizontalScrollIndicator = false
        sectionLabel.font = .boldSystemFont(ofSize: 22)
        sectionLabel.textColor = .customBlack
    }
    
    override func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView)
            make.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
    }
    
}

extension FavoriteTableViewCell {
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 220, height: 180)
        layout.scrollDirection = .horizontal
        return layout
    }
}
