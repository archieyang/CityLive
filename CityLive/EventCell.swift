//
//  EventCell.swift
//  CityLive
//
//  Created by archie on 15/5/13.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    
    @IBOutlet weak var eventName: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locLabel: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
