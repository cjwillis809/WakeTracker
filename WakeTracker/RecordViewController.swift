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
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions

    @IBAction func recordCurrentTime(sender: UIButton) {
        // Get current time
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Month, .Year, .Hour, .Minute], fromDate: date)
        
        let newRecord = Record(month: components.month, day: components.day, year: components.year, hour: components.hour, minute: components.minute)
        
        displayRecord(newRecord)
    }
    
    // MARK: Methods
    
    func displayRecord(record: Record) {
        let timeOfDay: String = record.setTimeOfDay()
        record.validateHour()
        
        timeLabel.text = "\(record.displayHour):\(record.minute)\(timeOfDay)"
    }

}

