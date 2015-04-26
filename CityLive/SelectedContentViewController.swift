//
//  SelectedContentViewController.swift
//  CityLive
//
//  Created by archie on 15/4/26.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class SelectedContentViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var titleText: String!
    var pageIndex: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleText
    }



}
