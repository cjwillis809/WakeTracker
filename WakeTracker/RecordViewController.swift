//
//  FirstViewController.swift
//  WakeTracker
//
//  Created by CJ Willis on 6/14/16.
//  Copyright © 2016 CJ Willis. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {

    // MARK: Variables
    @IBOutlet weak var timeLabel: UILabel!
    var recordArray: [Record] = []
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let savedRecords = loadRecords() {
            recordArray = savedRecords
        }
    }
    
    // MARK: Actions

    @IBAction func recordCurrentTime(sender: UIButton) {
        // Get current time
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Month, .Year, .Hour, .Minute], fromDate: date)
        
        let newRecord = Record(month: components.month, day: components.day, year: components.year, hour: components.hour, minute: components.minute)
        
        if validRecord(newRecord) {
            recordArray.append(newRecord)
            
            // Save and display the record on a seperate thread
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                self.saveRecords(self.recordArray)
                dispatch_async(dispatch_get_main_queue()) {
                    self.displayTime(newRecord)
                }
            }
        } else {
            displayTime(newRecord)
            displayDuplicateDateAlert()
        }
    }
    
    @IBAction func clearData(sender: UIButton) {
        recordArray.removeAll()
        let emptyArray: [Record] = []
        saveRecords(emptyArray)
        let alert = UIAlertController(title: "Alert", message: "Your data has been cleared.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: Methods
    
    func displayTime(record: Record) {
        let timeOfDay: String = record.setTimeOfDay()
        record.validateHour()
        
        timeLabel.text = "\(record.displayHour):\(String(format: "%02d", record.minute))\(timeOfDay)"
    }
    
    func displayDuplicateDateAlert() {
        let alert = UIAlertController(title: "Alert", message: "You have already recorded a time today!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func validRecord(record: Record) -> Bool {
        if let savedRecords = loadRecords() {
            for r in savedRecords {
                if !isDateNew(r, newRecord: record) {
                    return false
                }
            }
        }
        return true
    }
    
    func isDateNew(establishedRecord: Record, newRecord: Record) -> Bool {
        if establishedRecord.day == newRecord.day && establishedRecord.month == newRecord.month && establishedRecord.year == newRecord.year {
            return false
        }
        return true
    }
    
    // MARK: NSCoding
    
    func saveRecords(records: [Record]) {
        // Attempts to archive the record array to a specfic location, and returns true if successful
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(records, toFile: Record.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save records...")
        }
    }
    
    func loadRecords() -> [Record]? {
        // Attempt to unarchive object stored at the path. Will return nil if nothing is at that path
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Record.ArchiveURL.path!) as? [Record]
    }

}

