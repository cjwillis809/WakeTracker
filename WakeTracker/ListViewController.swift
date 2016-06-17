//
//  SecondViewController.swift
//  WakeTracker
//
//  Created by CJ Willis on 6/14/16.
//  Copyright © 2016 CJ Willis. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: NSCoding
    
    func loadRecords() -> [Record]? {
        // Attempt to unarchive object stroed at the path. Will return nil if nothing is at that path
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Record.ArchiveURL.path!) as? [Record]
    }


}

