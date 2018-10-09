//
//  ViewController.swift
//  Project 1 attempt 4
//
//  Created by Daniel Dodson on 3/12/18.
//  Copyright © 2018 Daniel Dodson. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

   
    @IBOutlet weak var tableView: UITableView!
    

    var events = [eventObject]()
    
    var userDefaults = UserDefaults.standard
    
    var dateFormatter = DateFormatter()
 
    var isAdded = false
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        
        
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        
        
      
        
    }
    
    //Table cell amount
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
  
    //Table labels
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comingUpCell")
        
       
       
        
        
        cell?.textLabel?.text = (events[indexPath.row] as! eventObject).eventName
        
        if (events[indexPath.row].isOverdue) { // the current time is later than the to-do item's deadline
            cell?.detailTextLabel?.textColor = UIColor.red
        } else {
            cell?.detailTextLabel?.textColor = UIColor.black // we need to reset this because a cell with red subtitle may be returned by dequeueReusableCellWithIdentifier:indexPath:
        }
      
        cell?.detailTextLabel?.text = dateFormatter.string(from: (events[indexPath.row] as! eventObject).eventDate)
      
       
        
        
        
        return cell!
    }
    
  
    //Delete cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            events.remove(at: indexPath.row)
           
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: events)
            userDefaults.set(encodedData, forKey: "events4")
            userDefaults.synchronize()
            
            
            
            tableView.reloadData()
        }
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        //events.sorted(by: <#T##(eventObject, eventObject) -> Bool#>)
        
        //let content = UNMutableNotificationContent()
        //content.title = NSString.localizedUserNotificationString(forKey: "\(eventName)", arguments: nil)
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: eventNotification, repeats: false)
       
    
        
        print(userDefaults.object(forKey: "events4") != nil)
//
        if(userDefaults.object(forKey: "events4") != nil){
            let decoded = userDefaults.object(forKey: "events4") as? Data
            events = (NSKeyedUnarchiver.unarchiveObject(with: decoded!) as? [eventObject])!
            tableView.reloadData()
            events = events.sorted(by: { $0.eventDate.compare($1.eventDate) == ComparisonResult.orderedAscending})
            
           
        }else{
    
        }
        
       UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoNewEvent" {
            let destination = segue.destination as? secondViewController
            
            //destination?.events = events
            
        }
    }
}

class TableViewControllerTemp: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
}

