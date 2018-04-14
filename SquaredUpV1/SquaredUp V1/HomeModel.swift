

import UIKit

protocol HomeModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class HomeModel: NSObject {

    //properties
    
    weak var delegate: HomeModelProtocol!
    
    let urlPath = "http://cgi.soic.indiana.edu/~team52/bills.php" 
 
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }

    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let location = LocationModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let name = jsonElement["fname"] as? String,
                let bill = jsonElement["BIll"] as? String,
                let owe = jsonElement["owe"] as? String,
                let amount = jsonElement["Amount"] as? String
 
            {
                
                location.name = name
                location.bill = bill
                location.owe = owe
                location.amount = amount
                

                
            }
            
            locations.add(location)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: locations)
            
        })
    }

}
