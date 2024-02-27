//
//  BaseView.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit

class BaseView: UIView, CodeBase {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
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
