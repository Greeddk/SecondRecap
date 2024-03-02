//
//  FavoriteCoinView.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import SnapKit

class FavoriteCoinView: BaseView {

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        collectionView.showsVerticalScrollIndicator = false
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let cellWidth = UIScreen.main.bounds.width - 30 
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 2)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }
    

}
