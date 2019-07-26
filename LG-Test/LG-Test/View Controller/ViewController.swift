//
//  ViewController.swift
//  LG-Test
//
//  Copyright © 2019 Sanjeeva-Test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        ProductsManager.shared.getProductsFromServer { (productModels: [ProductViewModel]?, error) in
            print(productModels?.count)
        }
    }


}

