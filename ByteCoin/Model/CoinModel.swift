
import Foundation

struct CoinModel
{
    let decodedrate:Double
    
    var rateInZeroDecimalPlace: String
    {
       let rateInString =  String(format:"%.0f",self.decodedrate)
        return rateInString
    }
}
