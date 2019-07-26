//
//  ButtonModification.swift
//  LG-Test
//
//  Copyright © 2019 Sanjeeva-Test. All rights reserved.
//

import Foundation
import UIKit


extension UIButton {
    
    func markAsOptionSelected() {
        let selectedBlue = UIColor.init(red: 114.0/255.0, green: 174.0/255.0, blue: 218.0/255.0, alpha: 1.0)
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = selectedBlue
    }

    func markAsOptionUnselected() {
        let unselectedGray = UIColor.init(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        self.backgroundColor = unselectedGray
        self.setTitleColor(UIColor.black, for: .normal)
    }
}
