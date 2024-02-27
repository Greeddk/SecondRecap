//
//  BaseCollectionViewCell.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, CodeBase {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        
    }
    
    func configureView() {
        
    }
    
    func configureLayout() {
        
    }
    
}
