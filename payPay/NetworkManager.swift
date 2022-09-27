//
//  NetworkManager.swift
//  payPay
//
//  Created by Vishnu Prasad M on 20/09/22.
//

import Foundation

class NetworkManager {
    var currencyDelegate : getCurrencyData?
    
    func getCurrencyList (){
        let url = "https://openexchangerates.org/api/currencies.json?&app_id=13cee8eba2cd48558ee538b0543f3967"
        performURLRequest(withURL: url, forDataType: Constants.dataTypes[0])
    }
    func performConversion(for amount: Double, from base: String, to value :String){
        let url = "https://openexchangerates.org/api/convert/\(amount)/\(base)/\(value)?&app_id=13cee8eba2cd48558ee538b0543f3967"
        
        performURLRequest(withURL: url, forDataType: Constants.dataTypes[1])
    }
    
    func performURLRequest(withURL link : String , forDataType resultValue : String){
        var symbolArray = [String]()
    
        if let url = URL(string: link){
            let task = URLSession(configuration: .default).dataTask(with: url, completionHandler: {(data,response,error ) -> Void in
                if (error != nil){
                    print(error?.localizedDescription ?? "")
                }else{
                    if let currencyDataReceived = data{
                        if resultValue == "CurrencyList"{
                            let currencyData = self.getCurrencyList(with: currencyDataReceived)
                            symbolArray.append(contentsOf: currencyData.keys)
                            self.currencyDelegate?.getCurrencyNames(symbol: symbolArray, name: currencyData)
                        }else if resultValue == "Conversion" {
                            if let currencyDataLatest = self.getExchangeRates(with: currencyDataReceived){
                                self.currencyDelegate?.getLatestRates(exchangeRates: currencyDataLatest)
                            }
                        }
                    }
                }
            })
            task.resume()
        }
    }
    
    func getExchangeRates(with data : Data)->ExchangeRates? {
        do {
            let result = try JSONDecoder().decode(currenciesModel.self, from: data)
            let finalData = ExchangeRates(disclaimer: result.disclaimer)
            return finalData
        }
        catch let error {
            debugPrint(error)
            return nil
        }
    }
    func getCurrencyList(with data : Data)->[String:String] {
        do {
            let rates = [String:String].self
            let result = try JSONDecoder().decode(rates.self, from: data)
            return result
        }
        catch let error {
            debugPrint(error)
            return ["error":"error"]
        }
    }
}
