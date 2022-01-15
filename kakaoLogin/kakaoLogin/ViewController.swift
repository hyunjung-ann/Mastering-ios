//
//  ViewController.swift
//  kakaoLogin
//
//  Created by 안현정 on 2022/01/16.
//

import UIKit
import KakaoSDKUser


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
   @IBAction func onKakaoLoginByAppTouched(_ sender: Any) {
       print("loginKakaoAccount() called.")

             // ✅ 기본 웹 브라우저를 사용하여 로그인 진행.
             UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                 if let error = error {
                     print(error)
                 }
                 else {
                     print("loginWithKakaoAccount() success.")

                     // ✅ 회원가입 성공 시 oauthToken 저장
                     // _ = oauthToken

                     // ✅ 사용자정보를 성공적으로 가져오면 화면전환 한다.
                     //self.getUserInfo()
                 }
             }
      }
    
}

    
    
    
    /*
     //카카오톡 앱으로 로그인 연동
     
    @IBAction func onKakaoLoginByAppTouched(_ sender: Any) {
        
        // ✅ 카카오톡 설치 여부 확인
              if (UserApi.isKakaoTalkLoginAvailable()) {
                  UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                      if let error = error {
                          print(error)
                      }
                      else {
                          print("loginWithKakaoTalk() success.")

                          // ✅ 회원가입 성공 시 oauthToken 저장가능하다
                          // _ = oauthToken

                          // ✅ 사용자정보를 성공적으로 가져오면 화면전환 한다.
                         // self.getUserInfo()
                      }
                  }
              }
              // ✅ 카카오톡 미설치
              else {
                  print("카카오톡 미설치")
              }
          }
}
*/
