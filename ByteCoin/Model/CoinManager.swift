//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol CoinManagerDelegate{
    func didUpdateCoinManager(_ coinManager: CoinManager ,coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "?apikey=4A361989-15C3-40E3-8F42-2FBC9490F93F"
    var delegate: CoinManagerDelegate?
    
    
    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)\(currency)\(apiKey)"
        performRequest(with: urlString)
        
    }
    
    let currencyArray = ["AUD","THB", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    

    func performRequest(with urlString: String){
        //create a URL
        if let url = URL(string: urlString){
            //create URL session
            let session = URLSession(configuration: .default)
            //Give session task
            let task = session.dataTask(with:url) {data,response,error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return 
                }
                if let safeData = data{
                    if let coin = self.parseJSON(safeData){
                        self.delegate?.didUpdateCoinManager(self, coin: coin)
                    }
                }
            }
            task.resume()
        }
        
        
    }
    func parseJSON(_ coinData: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodeData.rate
            print(decodeData.rate)
            let coin = CoinModel(coinRate: rate)
            return coin
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
