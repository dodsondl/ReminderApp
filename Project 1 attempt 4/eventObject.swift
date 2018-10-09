//
//  scaleSegue.swift
//  Project 1 attempt 4
//
//  Created by Daniel Dodson on 3/12/18.
//  Copyright © 2018 Daniel Dodson. All rights reserved.
//

import UIKit

class eventObject: NSObject, NSCoding {
    var eventName: String
    var eventDate: Date
    
    init?(eventName: String, eventDate: Date) {
        if eventName.isEmpty {
            return nil
        }
        
        self.eventName = eventName
        self.eventDate = eventDate
    }
    var isOverdue: Bool {
        return (Date().compare(self.eventDate) == ComparisonResult.orderedDescending) // deadline is earlier than current date
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let eventName = aDecoder.decodeObject(forKey: "eventName") as! String
        let eventDate = aDecoder.decodeObject(forKey: "eventDate")as! Date
        
        self.init(eventName: eventName, eventDate: eventDate)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(eventName, forKey: "eventName")
        aCoder.encode(eventDate, forKey: "eventDate")
    }
}
