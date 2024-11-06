

import Foundation

protocol coinDataDelegate
{
    func didFailWithError(_ error: Error)
    func didGetCoinRate(_ rate: CoinModel)
}

struct CoinManager {
    
   
    var delegate: coinDataDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "YOUR_API_KEY_HERE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    

    func getCoinPrice(for currency: String)
    {
        
        
        let urlString = baseURL + "\(currency)?apikey= 02311F4F-961A-4E26-9767-E43FABA2531C"
        request(with: urlString)
    }
    
    func request(with urlString: String)
    {
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!){(data,response,error) in
    
              if error != nil
              {
                  return
              }
              if let safedata = data
              {
                 let coindata = parseJSON(data: safedata)
                  
                  delegate?.didGetCoinRate(coindata!)
              }
           }
        
        task.resume()
    }
    
    func parseJSON(data: Data) -> CoinModel?
    {
        let decoder = JSONDecoder()
       
       do{
           let decodedData =  try decoder.decode(CoinData.self, from: data)
           
           let rate =  decodedData.rate
           
           let price = CoinModel(decodedrate: rate)
           
          return price
        }
        catch
        {
            delegate?.didFailWithError(error)
             return nil
        }
        
       
    }
}
