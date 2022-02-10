//
//  AddViewController.swift
//  Calendar_CollectionView
//
//  Created by 안현정 on 2022/02/09.
//

import UIKit

class AddViewController: UIViewController {

    var date:String!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setDiaryInfo(){
        let endYear = date.index(date.startIndex, offsetBy: 4)
        let endMonth = date.index(date.startIndex, offsetBy: 6)
        dateLabel.text = date[...endYear]+"년 "+date[endYear..<endMonth]+"월 "+date[endMonth...]+"일"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
