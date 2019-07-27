//
//  ViewController.swift
//  LG-Test
//
//  Copyright © 2019 Sanjeeva-Test. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

   private enum CurrencyType : Int {
        case INR
        case AED
        case SAR
    }

    var productsList: [ProductViewModel] = []
    private var timer: Timer?
    private var currentCurrency: CurrencyType?

    let selectedBlue = UIColor.init(red: 114.0/255.0, green: 174.0/255.0, blue: 218.0/255.0, alpha: 1.0)
    let unselectedGray = UIColor.init(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)

    let remainingDate = Date(timeIntervalSince1970: 1595275200000.0/1000.0)

    @IBOutlet weak var AEDButton: UIButton!
    @IBOutlet weak var INRButton: UIButton!
    @IBOutlet weak var productsCollection: UICollectionView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var SARButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.title = "Products List"
        self.initialHide()
        self.fetchProductList()
    }


    func initialHide() {
        self.productsCollection.isHidden = true
        self.productTitle.isHidden = true
        self.timerLabel.isHidden = true
    }

    func fetchProductList() {

        ProductsManager.shared.getProductsFromServer { (productModels: [ProductViewModel]?, error) in
            if (productModels != nil) {
                self.productsList = productModels!
                self.setupViews()
            }
        }
    }

    func setupViews() {
        DispatchQueue.main.async {
            self.productsCollection.isHidden = false
            self.productTitle.isHidden = false
            self.timerLabel.isHidden = false

            self.productsCollection.reloadData()
            self.productTitle.text = (self.productsList.count > 0) ? self.productsList[0].productTitle : ""
            self.startTimer()
        }
    }

    func startTimer() {
        if (timer == nil) {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] (_) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.updateRemainingTime()
            })
        }
    }

    @objc func updateRemainingTime() {
        self.timerLabel.text = DateUtilityManager().getTheRemainingTime(fromDate: Date(), toDate: remainingDate) + " Left"
    }

    @IBAction func INRTapped(_ sender: Any) {
        self.currentCurrency = CurrencyType.INR
        self.modifyButtonForSelection(currency: CurrencyType.INR)

    }
    @IBAction func AEDTapped(_ sender: Any) {
        self.currentCurrency = CurrencyType.AED
        self.modifyButtonForSelection(currency: CurrencyType.AED)

    }
    @IBAction func SARTapped(_ sender: Any) {
        self.currentCurrency = CurrencyType.SAR
        self.modifyButtonForSelection(currency: CurrencyType.SAR)
    }

    private func modifyButtonForSelection(currency: CurrencyType) {

        switch currency {
        case .AED:
            self.AEDButton.markAsOptionSelected()
            self.INRButton.markAsOptionUnselected()
            self.SARButton.markAsOptionUnselected()
            self.modifyProductListingForCurrency(currency: "AED")
        case .INR:
            self.AEDButton.markAsOptionUnselected()
            self.INRButton.markAsOptionSelected()
            self.SARButton.markAsOptionUnselected()
            self.modifyProductListingForCurrency(currency: "INR")
        case .SAR:
            self.AEDButton.markAsOptionUnselected()
            self.INRButton.markAsOptionUnselected()
            self.SARButton.markAsOptionSelected()
            self.modifyProductListingForCurrency(currency: "SAR")
        }
    }

    func modifyProductListingForCurrency(currency: String) {
        self.productsList = ProductsManager.shared.getProductViewModelArrayFor(conversionString: currency)
        self.productsCollection.reloadData()
    }

    deinit {
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - Collection view data source and delegate
extension ViewController {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell

        collectionCell.configureCellWithProduct(productViewModel: self.productsList[indexPath.row])

        return collectionCell
    }
}

