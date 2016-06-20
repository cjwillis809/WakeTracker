//
//  RecordTableViewCell.swift
//  WakeTracker
//
//  Created by CJ Willis on 6/18/16.
//  Copyright © 2016 CJ Willis. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
