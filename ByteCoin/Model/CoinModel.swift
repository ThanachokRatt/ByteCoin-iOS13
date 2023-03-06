//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Schweppe on 13/2/2566 BE.
//  Copyright © 2566 BE The App Brewery. All rights reserved.
//

import Foundation
struct CoinModel {
    let coinRate :Double
    
    var coinRateString: String{
        return String(format: "%.2f", coinRate)
    }
}
