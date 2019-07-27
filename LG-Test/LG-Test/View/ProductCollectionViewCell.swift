//
//  CollectionViewCell.swift
//  LG-Test
//
//  Copyright © 2019 Sanjeeva-Test. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!

    func configureCellWithProduct(productViewModel: ProductViewModel) {
        self.productPrice.text =  productViewModel.displayPrice
        self.productName.text = productViewModel.name
        ProductsManager.shared.getProductImageFor(product: productViewModel) { (image, error) in
            if (error != nil) {
            } else {
                DispatchQueue.main.async {
                    self.productImageView.image = image
                }
            }
        }
    }
}
