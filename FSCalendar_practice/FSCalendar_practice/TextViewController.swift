//
//  TextViewController.swift
//  FSCalendar_practice
//
//  Created by 안현정 on 2022/01/28.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    var date: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myLabel.text = date
    }}
