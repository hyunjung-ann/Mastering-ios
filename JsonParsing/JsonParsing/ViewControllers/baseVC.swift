//
//  baseVC.swift
//  JsonParsing
//
//  Created by 안현정 on 2022/01/24.
//

import UIKit

class BaseVC : UIViewController {
    
    var vcTitle: String = ""  {
        didSet { //나중에 vctitle에 값이 설정된다면, didset 발동
            print("userlistVC - Vctitle didset() called / vcTitle: \(vcTitle)")
            self.title = vcTitle  //UserListVC에 있는 title이 설정된 값으로 바로 연동됨
        }
    }
    
}
