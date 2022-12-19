//
//  ViewController.swift
//  LiveBov
//
//  Created by Gustavo Dias on 16/12/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var percentageButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var nomeAcao: UILabel!
    @IBOutlet weak var siglaAcao: UILabel!
    @IBOutlet weak var aberturaPrice: UILabel!
    @IBOutlet weak var atualPreco: UILabel!
    @IBOutlet weak var fiftyTwoSemLow: UILabel!
    @IBOutlet weak var fiftyTwoSemHigh: UILabel!
    @IBOutlet weak var precoLucro: UILabel!
    @IBOutlet weak var lucroAcao: UILabel!
    
    var showPercentage = false
    var stockManager = StockManager()
    
    
    @IBAction func percentageClicked(_ sender: UIButton) {
        showPercentage = !showPercentage
        if (showPercentage) {
            aberturaPrice.text = stockManager.currentState.getOpenPercentStr
            fiftyTwoSemLow.text = stockManager.currentState.getFiftyTwoWeekLowPercentStr
            fiftyTwoSemHigh.text = stockManager.currentState.getFiftyTwoWeekHighPercentStr
        } else {
            aberturaPrice.text = stockManager.currentState.getOpenPriceStr
            fiftyTwoSemLow.text = stockManager.currentState.getFiftyTwoWeekLowStr
            fiftyTwoSemHigh.text = stockManager.currentState.getFiftyTwoWeekHighStr
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        stockManager.delegate = self
        
        percentageButton.layer.cornerRadius = 5
        searchButton.layer.cornerRadius = 5
        
        percentageButton.layer.masksToBounds = true
        searchButton.layer.masksToBounds = true
    }
}

//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.text == "") {
            textField.placeholder = "Digite algo"
            return false
        } else if (textField.text!.count < 5) || (textField.text!.count > 6){
            textField.placeholder = "Formato inválido"
            textField.text = ""
            return false
        } else {
            textField.placeholder = "Ex.. PETR4"
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let stock = searchTextField.text {
            stockManager.fetchStock(with: stock)
        }
        searchTextField.text = ""
    }
}

//MARK: - StockManagerDelegate

extension ViewController: StockManagerDelegate {
    func didUpdateStock(_ stockManager: StockManager, stock: StockModel) {
        DispatchQueue.main.async {
            self.nomeAcao.text = stock.stockName
            self.siglaAcao.text = stock.stockCode
            self.aberturaPrice.text = stock.getOpenPriceStr
            self.atualPreco.text = stock.getCurrentPriceStr
            self.fiftyTwoSemLow.text = stock.getFiftyTwoWeekLowStr
            self.fiftyTwoSemHigh.text = stock.getFiftyTwoWeekHighStr
            self.precoLucro.text = stock.getPriceEarningsStr
            self.lucroAcao.text = stock.getEarningsPerShareStr
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
