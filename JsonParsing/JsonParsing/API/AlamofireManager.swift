//
//  AlamofireManager.swift
//  JsonParsing
//
//  Created by 안현정 on 2022/01/27.
//

import Foundation
import Alamofire


final class MyAlamofireManager {
    
    // 싱글턴 적용
    //자기자신의 인스턴스를 가져옴
    static let shared = MyAlamofireManager()
    
    // 인터셉터
    let interceptors = Interceptor(interceptors:
    [
        BaseInterceptor() //여러가지 계속 추가 가능
    ])

    // 로거 설정
//    let monitors =
    
    // 세션 설정
    var session : Session
    
    private init() {
        session = Session(interceptor: interceptors)
    }
    
}
