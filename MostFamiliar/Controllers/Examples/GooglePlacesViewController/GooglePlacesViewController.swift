//
//  GooglePlacesViewController.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/8/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class GooglePlacesViewController: UIViewController {
    private let explanationLabel = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgroundGray()
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(popVC))
        navigationItem.leftBarButtonItem?.tintColor = .darkPurple()
        
        
    }
    
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
    }

}
