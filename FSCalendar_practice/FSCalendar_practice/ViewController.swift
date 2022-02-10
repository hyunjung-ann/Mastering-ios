//
//  ViewController.swift
//  FSCalendar_practice
//
//  Created by 안현정 on 2022/01/27.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate {
    
    @IBOutlet var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        calendar.delegate = self
        calendar.dataSource = self
    
        calendar.appearance.titleDefaultColor = .black
        calendar.appearance.titleWeekendColor = .systemPink
        calendar.appearance.headerTitleColor = .systemPink
        calendar.appearance.weekdayTextColor = .gray
        
    }
    
    // 캘린더 날짜 선택했을 때, 선택한 날짜,요일,오전/오후 출력
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        guard let modalPresentView = self.storyboard?.instantiateViewController(identifier: "TestViewController") as? TestViewController else { return }
        
        // 날짜를 원하는 형식으로 저장하기 위한 방법
       let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-DD-YYYY at h:mm a"
        let string = formatter.string(from: date)
        print("\(string)")
        modalPresentView.date = formatter.string(from: date)
        
        self.present(modalPresentView, animated: true, completion: nil)
    }


}

extension ViewController: FSCalendarDataSource {

}

