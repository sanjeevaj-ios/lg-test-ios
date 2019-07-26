//
//  ProductsManager.swift
//  LG-Test
//
//  Copyright © 2019 Sanjeeva-Test. All rights reserved.
//

import Foundation
import  UIKit

let productsAPI = "http://a2b7cf8676394fda75de-6e0550a16cd96615f7274fd70fa77109.r93.cf3.rackcdn.com/common/json/assignment.json"
let defaultCurrency = "AED"

class ProductsManager {
    static let shared = ProductsManager()
    private init() { }

    var products:[Product] = []
    var conversions: [Conversion] = []
    var productTitle = ""
//    var productImageCache = Cache<String, UIImage>
}

extension ProductsManager {
    func getProductsFromServer(completion: @escaping ([ProductViewModel]?, Error?) -> Void) {

        DataManager().getData(url: productsAPI) { (data, error) in
            if (error != nil) {
                completion(nil, error)
            } else {
                if (data != nil) {
                    do {
                        let productsData = try JSONDecoder().decode(ProductData.self, from: data!)
                        self.parseProductsData(productData: productsData)
                        let productModels = self.getDefaultProductsViewModel()
                        completion(productModels, nil)
                    } catch let jsonError {
                        print(jsonError)
                    }
                }
            }
        }
    }

    func parseProductsData(productData: ProductData) {
        self.products = productData.products
        self.conversions = productData.conversion
        self.productTitle = productData.title
    }

    func getDefaultProductsViewModel() -> [ProductViewModel] {
        var productViewModels = [ProductViewModel]()

        for product in products {
            let productViewModel = self.getProductViewModelFor(product: product, conversion: defaultCurrency)
            productViewModels.append(productViewModel)
        }

        return productViewModels
    }

    func getProductViewModelFor(product: Product, conversion: String) -> ProductViewModel {

        let name = product.name
        let displayPrice = ConversionManager.shared.convertRateFrom(from: product.currency, rate: product.price, to: conversion)

        let productViewModel = ProductViewModel.init(productTitle: self.productTitle, name: name, displayPrice: displayPrice, imageURL: product.url)

        return productViewModel
    }

    func getProductImageFor(product: ProductViewModel, imgCompletion:@escaping (UIImage?, Error?) -> Void) {

        DataManager().getData(url: product.imageURL) { (data, error) in
            if (error != nil) {
                imgCompletion(nil, error)
            } else {
                if (data != nil) {
                    let img = UIImage(data: data!)
                    imgCompletion(img, nil)
                }
            }
        }
    }
}
