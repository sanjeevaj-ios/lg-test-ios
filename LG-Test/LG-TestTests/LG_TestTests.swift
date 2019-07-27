//
//  LG_TestTests.swift
//  LG-TestTests
//
//  Copyright © 2019 Sanjeeva-Test. All rights reserved.
//

import XCTest
@testable import LG_Test

class LG_TestTests: XCTestCase {

    func  testConversionRate() {
        let fromCurrency = "AED"
        let toCurrency = "INR"
        let price = "2.0"
        let expectedAnswer = "34.00"
        let conversionObj = Conversion.init(from: "AED", to: "INR", rate: "17.1")
        ConversionManager.shared.conversionArray = [conversionObj]

        let testAnswer = ConversionManager.shared.convertRateFrom(from: fromCurrency, rate: price, to: toCurrency)
        XCTAssertEqual(testAnswer, expectedAnswer)
    }

    func testDefaultProductViewModel() {
        let testProduct = Product.init(url: "http://abc.com", name: "Test product", price: "34.00", currency: "INR")
        ProductsManager.shared.products = []
        ProductsManager.shared.products.append(testProduct)
        let expectedPrice = "AED 2.00"
        let conversionObj = Conversion.init(from: "AED", to: "INR", rate: "17.0")
        ConversionManager.shared.conversionArray = [conversionObj]

        let defaultViewModel = ProductsManager.shared.getDefaultProductsViewModel()
        XCTAssertEqual(defaultViewModel[0].displayPrice, expectedPrice)
    }

    func testParsingProductData() {
        let testProdTitle = "Test title of product"
        let testProdData = ProductData.init(products: [], conversion: [], title: testProdTitle)
        ProductsManager.shared.parseProductsData(productData: testProdData)
        let prodManagerTitle = ProductsManager.shared.productTitle
        XCTAssertEqual(prodManagerTitle, testProdTitle)
    }

    func testTheRemainingTime() {
        var dateComponents1 = DateComponents()
        dateComponents1.year = 2019
        dateComponents1.month = 7
        dateComponents1.day = 27
        dateComponents1.hour = 8
        dateComponents1.minute = 10

        let testDate1 = Calendar.current.date(from: dateComponents1)

        var dateComponents2 = DateComponents()
        dateComponents2.year = 2019
        dateComponents2.month = 7
        dateComponents2.day = 28
        dateComponents2.hour = 9
        dateComponents2.minute = 30

        let testDate2 = Calendar.current.date(from: dateComponents2)

        // 25 hours and 20 minutes
        let expectedRemainingStr = "25:20:0"
        let timeRemainStr = DateUtilityManager().getTheRemainingTime(fromDate: testDate1!, toDate: testDate2!)
        XCTAssertEqual(timeRemainStr, expectedRemainingStr)
    }

}
