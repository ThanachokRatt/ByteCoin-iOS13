import Foundation
struct CoinModel {
    let coinRate :Double
    
    var coinRateString: String{
        return String(format: "%.2f", coinRate)
    }
}
