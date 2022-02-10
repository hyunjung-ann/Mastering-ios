//
//  CalendarHelper.swift
//  Calendar_CollectionView
//
//  Created by 안현정 on 2022/02/08.
//

import Foundation
import UIKit

class CalendarHelper {
    
    // Calendar.current를 사용해, 현재 사용하고 있는 달력을 확인
    let calendar = Calendar.current
    
    // 시간더하기
    // date(byAdding : 더하는 단위 , value : 더할 값, to : 더할 곳)
    func plusMonth(date: Date) -> Date
    {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date: Date) -> Date
    {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    // 현재의 Date를 원하는 월별 Format으로 변환하고자 할 때
    func monthString(date: Date) -> String // Date타입을 String으로 반환
    {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL" // 텍스트로 몇월 출력
        return dateFormatter.string(from: date) // 날짜 형식 문자열
    }
    
    //  현재의 Date를 원하는 년도 Format으로 변환하고자 할 때
    func yearString(date: Date) -> String
    {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    // 월의 일수 반환
    func daysInMonth(date: Date) -> Int {
        
        //날짜에 대해 월의 일 범위 지정
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    // 특정 월에서 day 구성요소
    func daysOfMonth(date: Date) -> Int {
        
        //매개변수의 Calander.current.Component에는 .month, .year, .day 셋 중 하나가 들어갈 수 있다
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! -  1
    }
    

}
