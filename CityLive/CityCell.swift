//
//  CityCell.swift
//  CityLive
//
//  Created by archie on 15/4/26.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    @IBOutlet weak var cityName: UILabel!

    @IBOutlet weak var citySelected: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
