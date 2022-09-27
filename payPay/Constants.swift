//
//  Cnstants.swift
//  payPay
//
//  Created by Vishnu Prasad M on 20/09/22.
//

import Foundation
import UIKit
class Constants {
    
    static let currencyURL = "https://openexchangerates.org/api/currencies.json?&app_id=13cee8eba2cd48558ee538b0543f3967"
    static let url = "https://openexchangerates.org/api/latest.json?app_id=13cee8eba2cd48558ee538b0543f3967"
    static let convert = "https://openexchangerates.org/api/convert/19999.95/GBP/EUR?app_id=13cee8eba2cd48558ee538b0543f3967YOUR_APP_ID"
    static let mainBackgroundColor = UIColor(red: 255/255, green: 240/255, blue: 230/255, alpha: 1).cgColor
    static let blueColor = CGColor(red: 0, green: 122/255, blue: 255, alpha: 1)
    static let dataTypes = ["CurrencyList","Conversion"]
    enum dataType : String {
        case CurrencyList
    }
}
