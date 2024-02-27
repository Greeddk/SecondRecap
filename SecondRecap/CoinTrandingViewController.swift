//
//  ViewController.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import SnapKit

class CoinTrandingViewController: UIViewController {
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customWhite
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(view).offset(100)
            make.size.equalTo(100)
        }
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        button.setTitle("test", for: .normal)
        button.setTitleColor(.primary, for: .normal)
    }
    
    @objc
    func buttonClicked() {
        let vc = CoinChartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

