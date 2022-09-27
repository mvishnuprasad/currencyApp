//
//  ViewController.swift
//  payPay
//
//  Created by Vishnu Prasad M on 20/09/22.
//

import UIKit
protocol getCurrencyData {
    func getCurrencyNames(symbol : [String], name :[String:String])
    func getLatestRates (exchangeRates : ExchangeRates)
}
class ViewController: UIViewController{
private var currencyName : [String:String] = ["empty":"empty"]
private var currencySymbol : [String] = ["empty"]
    private var networkManager = NetworkManager()
    private var exchangeRates : ExchangeRates?
    private var ButtonTapped  : Bool = false
    private var titleLabel : String = ""
    override func viewDidLoad() {
        ViewCustomisation()
        networkManager.currencyDelegate = self
        networkManager.getCurrencyList()
        super.viewDidLoad()
        self.currencyListDropDown.delegate=self
        self.currencyListDropDown.dataSource = self
        self.currencyListDropDown.register(CurrencyDropDownCell.self, forCellReuseIdentifier: CurrencyDropDownCell.identifier)
    }
    
    @IBOutlet weak var ratesCollection: UICollectionView!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var currencyListDropDown: UITableView!
    @IBOutlet weak var selctBase: UIButton!
    @IBAction func tap(_ sender: UIAction) {
        ButtonTapped = true
        currencyListDropDown.isHidden.toggle()
    }
}

extension ViewController:getCurrencyData{
    func getLatestRates(exchangeRates: ExchangeRates) {
        self.exchangeRates = exchangeRates
    }
    
    func getCurrencyNames(symbol : [String], name : [String:String]) {
        DispatchQueue.main.async {
            self.currencySymbol = symbol
            self.currencyName = name
            self.currencyListDropDown.reloadData()
            self.ratesCollection.reloadData()
        }
    }
}



extension ViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
       
        if self.searchBar.text != "" {
            self.searchBar.text! += " \(self.currencySymbol.sorted(by: {$1>$0})[indexPath!.row]) "
            
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.15, execute: {
            self.selctBase.titleLabel?.text = "Convert \(self.searchBar.text ?? "")\(self.currencySymbol.sorted(by: {$1>$0})[indexPath!.row]) to"
            
            self.currencyListDropDown.isHidden = true
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencySymbol.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.showsVerticalScrollIndicator = false
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as? CurrencyDropDownCell {
            cell.textLabel?.text = "\(currencySymbol.sorted(by: {$1>$0})[indexPath.row]) - \(currencyName[currencySymbol.sorted(by: {$1>$0})[indexPath.row]] ?? "")"
            cell.textLabel?.textColor = .red
            return cell
        }
        fatalError()
    }
}

extension ViewController {
    func ViewCustomisation () {
        self.currencyListDropDown.isHidden = true
        view.layer.backgroundColor = Constants.mainBackgroundColor
        self.selctBase.layer.cornerRadius = 12
        self.searchBar.borderStyle = .roundedRect
        self.currencyListDropDown.layer.cornerRadius = 12
        self.currencyListDropDown.layer.borderWidth = 3
        self.currencyListDropDown.layer.borderColor = Constants.blueColor
        ratesCollection.backgroundColor = .clear
        searchBar.keyboardType = .decimalPad
        
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        networkManager.performConversion(for: 222, from: "AED", to: "USD")
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencySymbol.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyGrid", for: indexPath) as? CurrencyCell {
            cell.CurrencyLabel.text = "\(currencySymbol.sorted(by: {$1>$0})[indexPath.item])"
            cell.layer.cornerRadius = 12
            cell.tintColor = .red
            
            return cell
        }
        fatalError()

    }
    
    
}
