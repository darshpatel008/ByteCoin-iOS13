
import UIKit

class ViewController: UIViewController
{
    
    var coinManager = CoinManager()
    

    @IBOutlet weak var bitcoinLabel: UILabel!
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        coinManager.delegate = self
    }
    
    

}

//MARK: - UIPicker

extension ViewController: UIPickerViewDataSource
{
    //column
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    //row
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return coinManager.currencyArray.count
    }
    
    
}
//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return coinManager.currencyArray[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let selectedCurrency = coinManager.currencyArray[row]
        
        currencyLabel.text = selectedCurrency

        print(selectedCurrency)
        
        coinManager.getCoinPrice(for:selectedCurrency)
    }
}
//MARK: - coinDataDelegate

extension ViewController: coinDataDelegate
{
    func didFailWithError(_ error: any Error) {
        print(error)
    }
    
    func didGetCoinRate(_ rate: CoinModel) 
    {
        print(rate.decodedrate)
        
        DispatchQueue.main.async{
            self.bitcoinLabel.text =   rate.rateInZeroDecimalPlace
        }
    }

}
