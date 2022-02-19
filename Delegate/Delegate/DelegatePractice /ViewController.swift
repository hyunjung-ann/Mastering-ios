//
//  ViewController.swift
//  Delegate
//
//  Created by 안현정 on 2022/02/19.
//

import UIKit

// 📌 1) 프로토콜 채택
class ViewController: UIViewController, sample {
    
    
    // 📌 2) protocol 내의 [ dataSend ] 함수를 실제로 구현
    func dataSend(data: String) {
        textLb.text = data
    }
    

        @IBOutlet weak var textLb: UILabel!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
        
    
    // 📌 3) delegate 위임 ( nextVC.delegate = self )
        @IBAction func TappedShow(_ sender: Any) {

            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ModalViewController") as? ModalViewController else {return}
            nextVC.delegate = self
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
    }
