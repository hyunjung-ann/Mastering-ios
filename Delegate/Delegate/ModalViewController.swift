//
//  ModalViewController.swift
//  Delegate
//
//  Created by 안현정 on 2022/02/19.
//

import UIKit

// 📌 1) protocol 생성
protocol sample {
    func dataSend(data: String)
}

class ModalViewController: UIViewController {
    
    // 📌 2) 프로토콜 타입을 가진 delegate 프로퍼티 생성
    var delegate: sample?

    @IBOutlet weak var nicknameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // 📌 3) delegate 프로퍼티 사용
    
    @IBAction func TappedBtn(_ sender: Any) {
        if let text = nicknameTextField.text {
            delegate?.dataSend(data: text)
        }
        self.navigationController?.popViewController(animated: true)
}
    
}
