//
//  BaseIntercaptor.swift
//  JsonParsing
//
//  Created by 안현정 on 2022/01/27.
//

import Foundation
import Alamofire

class BaseInterceptor: RequestInterceptor {
    
    //
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        print("BaseInterceptor - adapt() called")
        
        // header 추가, 매개변수로 들어오는 urlRequest 넣어줌
        var request = urlRequest
        
        // addValue를 통해서 header 추가
        // 'application/json' 형태로 해놓으면 json 형태로만 받음
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        
        // 성공할 경우 들어오는 request
        completion(.success(request))
    }
    
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("BaseInterceptor - retry() called ")
        
        // donotretry -> 예를들어 토큰 값이 없을 때 api호출을 다시할 것이냐 말 것이냐 결정
        completion(.doNotRetry)
    }
}


