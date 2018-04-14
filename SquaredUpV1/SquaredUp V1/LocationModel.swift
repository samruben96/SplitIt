

import UIKit

class LocationModel: NSObject {

    //properties
    
    var name: String?
    var bill: String?
    var owe: String?
    var amount: String?

    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, etc.
    
    init(name: String, owe: String, bill: String, amount: String) {
        
        self.name = name
        self.bill = bill
        self.owe = owe
        self.amount = amount
        
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "Name: \(String(describing: name)), Owe: \(String(describing: owe))"
        
    }
    
}
