//
//  ConversionManager.swift
//  LG-Test
//
//  Copyright © 2019 Sanjeeva-Test. All rights reserved.
//

import Foundation

class ConversionManager {
    static let shared = ConversionManager()
    private init() { }

    var conversionArray: [Conversion] = ProductsManager.shared.conversions

    func convertRateFrom(from: String, rate: String, to: String) -> String {
        var rateString = "0.0"


        if (from == to) {
            return rate

        } else {

            // Check if direct conversion present in the array of conversions from API.
            // If yes, we directly multiply
            let presentConversion = conversionArray.filter({$0.from == from && $0.to == to})

            if (presentConversion.count > 0) {
                let conversionRate = Double(presentConversion[0].rate)
                let prodRate = Double(rate)
                let displayRate = floor(conversionRate! * prodRate!)
                return String(format: "%.2f", displayRate)
            } else {
                let oppositeConversion = conversionArray.filter({$0.from == to && $0.to == from})

                if (oppositeConversion.count > 0) {
                    var conversionRate = Double(oppositeConversion[0].rate)
                    conversionRate = 1.0 / conversionRate!
                    let prodRate = Double(rate)
                    let displayRate = floor(conversionRate! * prodRate!)
                    return String(format: "%.2f", displayRate)
                }

            }

        }

        return rateString
    }

}
