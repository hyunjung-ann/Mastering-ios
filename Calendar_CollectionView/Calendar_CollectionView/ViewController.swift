//
//  ViewController.swift
//  Calendar_CollectionView
//
//  Created by 안현정 on 2022/02/07.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    //MARK: - Outlets
    
    @IBOutlet weak var monthLb: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    // Date() 자료형으로 인스턴스를 생성하면 현재 날짜와 시간을 알 수 있음
    // 이때 얻은 Date는 "2020-08-13 09:14:48 +0000" 이러한 형태로 넘어온다.
    var selectedDate = Date()
    
    //날짜를 담을 string 배열 선언
    var totalSquare = [String]()
    var calendar = Calendar.current
    
    let dateFormatter = DateFormatter()
    var dateOfToday:String?
    var dateComponents = DateComponents()
    
    var weeks: [String] = ["월","화", "수", "목", "금", "토", "일"]
    var days:[String] = []
    
    var daysCountInMonth = 0  // 해당 월이 며칠까지 있는지
    var weekdayAdding = 0 // 시작일
    
   // let appdelegate = UIApplication.shared.delegate as! AppDelegate
  //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCellsView()
    }

    //MARK: - Helpers
    
    
    // 셀 크기 설정
    func setCellsView() {
        // 컬렉션뷰 width - 2(여백) / 8
        let width = (myCollectionView.frame.size.width - 2) / 8
        let height = (myCollectionView.frame.size.height - 2) / 8
        
        //셀 기본크기 설정
        let flowLayout = myCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView() {
        totalSquare.removeAll() //모든 요소 제거
        
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate) //선택한 날짜에서 월별 날짜 가져옴
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate) //선택한 날짜가 오늘날짜로 초기화
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth) //해당 요일에 대한 인덱스
        
        var count: Int = 1
        
        while(count <= 42)
        {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth)
            {
                totalSquare.append("")
            }
            else
            {
                totalSquare.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        monthLb.text = CalendarHelper().monthString(date: selectedDate)
            + " " + CalendarHelper().yearString(date: selectedDate)
        myCollectionView.reloadData()
    }
    
    
    
   //MARK: - collectionview
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquare.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
 
        cell.dayOfMonth.text = totalSquare[indexPath.item]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarCell
        dateFormatter.dateFormat = "yyyyMM"
        var dateOfCell = dateFormatter.string(from: calendar.date(from: dateComponents)!)
        
        
        guard let addVC = self.storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {return}
             
        present(addVC, animated: true, completion: nil)
        
        addVC.date =  dateOfCell
        addVC.setDiaryInfo()
    
    }
    
    //MARK: - Actions
    
    @IBAction func PreviousMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
                setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool
    {
        return false
    }
    
}

 
// MARK: - UICollectionViewDelegateFlowLayout
