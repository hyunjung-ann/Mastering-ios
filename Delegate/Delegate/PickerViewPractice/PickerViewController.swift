//
//  PickerViewController.swift
//  Delegate
//
//  Created by 안현정 on 2022/02/20.
//

import UIKit

// 📌 1) UIPickerView delegate, datasource 채택
class PickerViewController: UIViewController  {

    @IBOutlet var viewTemp: UILabel!
    @IBOutlet weak var pickerview: UIPickerView!
    
    var minutes = ["00","15","30","45"]
    var hours = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    var times = ["오전","오후"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let mid = pickerview.numberOfRows(inComponent: 0)
       // pickerview.selectRow(mid, inComponent: 0, animated: false)
    }
    
}


 // MARK: -  UIPickerViewDelegate, UIPickerViewDataSource

extension PickerViewController:  UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 1 Components
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return minutes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(minutes[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewTemp.text = "\(minutes[row])"
    }
}
