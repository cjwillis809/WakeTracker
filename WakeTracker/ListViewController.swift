//
//  SecondViewController.swift
//  WakeTracker
//
//  Created by CJ Willis on 6/14/16.
//  Copyright © 2016 CJ Willis. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    // MARK: Properties
    var recordArray = [Record]()

    // MARK: Overrided methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let savedRecords = loadRecords() {
            recordArray = savedRecords
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Tells the table view how many sections (visual groupings of cells within table views) to display. We just need a single section here.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Tells the table view how many rows to display in a given section. Each record should have its own row in our section.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "RecordTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RecordTableViewCell
        
        // Fetches the appropriate record for the data source layout
        let record = recordArray[indexPath.row]
        
        cell.dateLabel.text = "\(record.month)/\(record.day)/\(record.year)"
        cell.timeLabel.text = "\(record.displayHour):\(String(format: "%02d", record.minute))\(record.setTimeOfDay())"
        
        return cell
    }
    
    // MARK: NSCoding
    
    func loadRecords() -> [Record]? {
        // Attempt to unarchive object stroed at the path. Will return nil if nothing is at that path
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Record.ArchiveURL.path!) as? [Record]
    }


}

