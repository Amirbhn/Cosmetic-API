//
//  ViewController.swift
//  Amir
// http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline
//  Created by Map04 on 2021-04-15.
//

import UIKit

class ViewController: UIViewController {
    
    var cosmeticArray = [Cosmetic]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CosmeticApi.shared.fetchRootObject()
    }


}

