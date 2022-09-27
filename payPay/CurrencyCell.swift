//
//  CurrencyGrid.swift
//  payPay
//
//  Created by Vishnu Prasad M on 22/09/22.
//

import UIKit

class CurrencyCell: UICollectionViewCell {
    
    @IBOutlet weak var CurrencyLabel: UILabel!
    func configure (with currencyName : String){
        CurrencyLabel.text = currencyName
    }
}
