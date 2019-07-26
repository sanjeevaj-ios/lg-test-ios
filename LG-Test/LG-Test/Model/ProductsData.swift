//
//  ProductsData.swift
//  LG-Test
//
//  Copyright © 2019 Sanjeeva-Test. All rights reserved.
//

import Foundation

struct ProductData: Decodable {
    var products: [Product]
    var conversion: [Conversion]
    var title: String
}
