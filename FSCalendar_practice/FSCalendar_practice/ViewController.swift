//
//  ViewController.swift
//  FSCalendar_practice
//
//  Created by 안현정 on 2022/01/27.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {

    //데이터 포멧터 생성
    let dateFormatter = DateFormatter()
    
    // Date() 자료형으로 인스턴스를 생성하면 현재 날짜와 시간을 반환
    // 이때 얻은 Date는 "2020-08-13 09:14:48 +0000" 이러한 형태로 넘어온다.
    private var currentPage: Date?
    private lazy var today: Date = { return Date() }()

    private lazy var headerDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR") // ko_KR 한국 기준의 시간
        df.dateFormat = "YY.LL."
        return df
    }()
    
    // fscalendar 변수 등록
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet weak var headerLb: UILabel!
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        config() //캘린더 디자인 속성 정의 메소드
        setConfig() // 캘린더 기능 속성 정의 메소드
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        setCalendar()
        
    }


    
    // MARK: - Actions
    
    // 이전 달로 스와이프 버튼 액션 메서드
    @IBAction func prevBtnTapped(_ sender: UIButton) {
        scrollCurrentPage(isPrev: true) }
    
    // 다음 달로 스와이프 버튼 액션 메서드
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        scrollCurrentPage(isPrev: false)
    }

    
    
    // MARK: - Helpers
    
    // 버튼을 이용해 페이지 이동 함수
    private func scrollCurrentPage(isPrev: Bool) {
        
        // Calendar.current를 사용해, 현재 사용하고 있는 달력을 확인
        let cal = Calendar.current
        
        //DateComponents 인스턴스를 만들어서 새로운 날짜를 만들고 날짜 계산을 할 수 있다.
        var dateComponents = DateComponents()
        
        //currentPage를 dateComponent.month에 -1 또는 1을 더해주면서 현재 페이지를 설정
        dateComponents.month = isPrev ? -1 : 1
        
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
        
    }

    
    func config() {
        
        //캘린더 배경색 변경
        calendar.backgroundColor = .clear
        
        //캘린더 선택한 날짜색 변경
        calendar.appearance.selectionColor = UIColor(red: 38/255, green: 153/255, blue: 251/255, alpha: 1)
        
        //캘린더 오늘 날짜색 변경
        calendar.appearance.todayColor = UIColor(red: 188/255, green: 224/255, blue: 253/255, alpha: 1)
        
        
        // [폰트설정]
        //캘린더 평일 date 폰트 컬러
        calendar.appearance.titleDefaultColor = .black
        
        //캘린더 주말 date 폰트 컬러
        calendar.appearance.titleWeekendColor = .systemPink
        
        // 달력의 년월 글자 바꾸기
        // 월 앞에 0 붙이는 형식 -> LL
        calendar.appearance.headerDateFormat = "YY.LL."
        
        //캘린더 header 타이틀 폰트 컬러
        calendar.appearance.headerTitleColor = .black
        
        // 헤더 폰트 설정
       //calendar.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 10)

        
        //캘린더 요일 폰트 컬러
        calendar.appearance.weekdayTextColor = .gray
 
    }
    
    
    func setConfig() {
        
        //캘린더 여러개 선택가능
        calendar.allowsMultipleSelection = true
        
        //캘린더 날짜 누른상태로 스와이프 동작 가능하게
        calendar.swipeToChooseGesture.isEnabled = true
        
        // 년월에 흐릿하게 보이는 애들 없애기
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        
        //캘린더 스크롤 작동여부 -> false
        //calendar.scrollEnabled = false
    }


}



// MARK: - FSCalendarDelegate

extension ViewController: FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    
    func setCalendar() {
        calendar.delegate = self
        calendar.headerHeight = 0 //헤더 높이 0으로 만들기
        calendar.scope = .month
        // 헤더 라벨의 텍스트를 캘린더 뷰의 현재 페이지의 date로 설정해서 초기화
        headerLb.text = self.headerDateFormatter.string(from: calendar.currentPage)
    }

    // 현재 페이지가 변환되면 헤더 라벨의 텍스트를 갱신
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.headerLb.text = self.headerDateFormatter.string(from: calendar.currentPage)
        
    }

    
    // 캘린더 날짜 선택했을 때, 콜백 메소드
    // 선택한 날짜,요일,오전/오후 출력
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
        
        guard let modalPresentView = self.storyboard?.instantiateViewController(identifier: "TestViewController") as? TestViewController else { return }
        
        // 날짜를 원하는 형식으로 저장하기 위한 방법
        dateFormatter.dateFormat = "EEEE MM-DD-YYYY at h:mm a"
        let string = dateFormatter.string(from: date)
        print("\(string)")
        modalPresentView.date = dateFormatter.string(from: date)
        
        self.present(modalPresentView, animated: true, completion: nil)
    }
    
    
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
    }
    
    
    // 날짜 밑에 문자열 표시
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
            
            switch dateFormatter.string(from: date) {
            case dateFormatter.string(from: Date()):
                return "오늘"
            case "2022-02-22":
                return "출근"
            case "2022-02-12":
                return "팀 회의"
            case "2022-02-19":
                return "정기회의"
            default:
                return nil
            }
        }
    
    // 날짜 글씨 자체 바꾸기
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
            switch dateFormatter.string(from: date) {
            case "2022-02-09":
                return "D-day"
            default:
                return nil
            }
        }
    
    
    //날짜 별 선택 컬러 변경
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
            
            switch dateFormatter.string(from: date) {
            case "2022-02-01":
                return .green
            case "2022-02-15":
                return .yellow
            case "2022-02-24":
                return .red
            default:
                return appearance.selectionColor
            }
        }

}



  // MARK: - FSCalendarDataSource

extension ViewController: FSCalendarDataSource {

}

