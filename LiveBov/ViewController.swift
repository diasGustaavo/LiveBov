//
//  ViewController.swift
//  LiveBov
//
//  Created by Gustavo Dias on 16/12/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var percentageButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        percentageButton.layer.cornerRadius = 15
        searchButton.layer.cornerRadius = 15
        
        percentageButton.layer.masksToBounds = true
        searchButton.layer.masksToBounds = true
    }


}

