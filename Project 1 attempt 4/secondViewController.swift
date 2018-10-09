//
//  ViewController.swift
//  Project 1 attempt 4
//
//  Created by Daniel Dodson on 3/12/18.
//  Copyright © 2018 Daniel Dodson. All rights reserved.
//

import UIKit
import UserNotifications


class secondViewController: UIViewController {
    
    
    var events = [eventObject]()

    
    var datePicker = UIDatePicker()
    
    
    @IBOutlet weak var enteredName: UITextField!
    
    
    @IBOutlet weak var enteredDate: UITextField!
    
    
    let dateFormatter = DateFormatter()
    
    var userDefaults = UserDefaults.standard
    
    var isAdded = false
    
    
    func loadevents() {
        
        var newTask = eventObject(eventName: enteredName.text!, eventDate: datePicker.date)
        //events = userDefaults.object(forKey: "events3") as! [eventObject]
        if(userDefaults.object(forKey: "events4") != nil){
        let decoded = userDefaults.object(forKey: "events4") as? Data
        events = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [eventObject]
        }
        events.append(newTask!)
        
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: events)
        userDefaults.set(encodedData, forKey: "events4")
        userDefaults.synchronize()
        
        
        
        // create a corresponding local notification
        let notification = UILocalNotification()
        notification.alertBody = "\(enteredName.text!)" // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        var dateInfo = DateComponents()
        dateInfo.hour = 18
        dateInfo.minute = 30
        notification.fireDate = datePicker.date // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["title": enteredName.text!] // assign a unique identifier to the notification so that we can retrieve it later
        
        UIApplication.shared.scheduleLocalNotification(notification)
    
        
    
    }
 
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gotoTable" {
            let destination = segue.destination as? ViewController
            destination?.isAdded = true
            
          // destination?.events = events
        }
        
        if segue.identifier == "goBackButton" {
            let destination = segue.destination as? ViewController
            
            
            
            //destination?.events = events
        }
    }
    
   
    @IBAction func addEventButton(_ sender: Any) {
       // eventName.append(enteredName.text!)
        //enteredName.text = ""
        //print(eventName)
        //UserDefaults.standard.set(eventName, forKey: "SaveEventName1")
        
        
        //let formatter = DateFormatter()
        //formatter.timeStyle = .short
        //let dateString = formatter.string(from: datePicker.date)
        //eventDate.sort()
        //eventDate.append(dateString)
        //UserDefaults.standard.set(eventDate, forKey: "SaveEventDate1")
        //enteredDate.text = ""
        //print(eventDate)
        
        //UserDefaults.standard.set(events, forKey: "SaveEventKey")
        
       
        
        loadevents()
       
        
        
        
        
        
    }
    
    
   
    
    func tableDate() {
        //date format
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let dateString = formatter.string(from: datePicker.date)
        
        
        enteredDate.text = "\(dateString)"
        self.view.endEditing(true)
        
    }
    
    
    
    func createDatePicker () {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneSelector))
        toolbar.setItems([done], animated: false)
        
        enteredDate.inputAccessoryView = toolbar
        enteredDate.inputView = datePicker
    }
    
    @objc func doneSelector() {
        
        //date format
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let dateString = formatter.string(from: datePicker.date)
        
        
        enteredDate.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
     
        
        
        //events = UserDefaults.standard.object(forKey: "SaveEventKey") as? [eventObject] ?? [eventObject]()
        createDatePicker()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
         
        
     
        
       
    
        
        //events = UserDefaults.standard.object(forKey: "NewEventKey") as? [eventObject] ?? [eventObject]()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class SegueFromLeft: UIStoryboardSegue {
    override func perform() {
        let secondViewController = self.source
        let ViewController = self.destination
        
        secondViewController.view.superview?.insertSubview(ViewController.view, aboveSubview: secondViewController.view)
        ViewController.view.transform = CGAffineTransform(translationX: -secondViewController.view.frame.size.width, y: 0)
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: .curveEaseIn,
                       animations: {
                        ViewController.view.transform = CGAffineTransform(translationX: 0, y: 0)},
                       completion: {finished in
                        secondViewController.present(ViewController, animated: false, completion: nil)}
        )
}

}

class SegueFromRight: UIStoryboardSegue {
    override func perform() {
        let ViewController = self.source
        let secondViewController = self.destination
        
        ViewController.view.superview?.insertSubview(secondViewController.view, aboveSubview: ViewController.view)
        secondViewController.view.transform = CGAffineTransform(translationX: ViewController.view.frame.size.width, y: 0)
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: .curveEaseIn,
                       animations: {
                        secondViewController.view.transform = CGAffineTransform(translationX: 0, y: 0)},
                       completion: {finished in
                        ViewController.present(secondViewController, animated: false, completion: nil)}
        )
        
    }
}

