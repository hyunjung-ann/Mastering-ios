
//
//  ViewController.swift
//  JsonParsing
//
//  Created by 안현정 on 2022/01/18.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var searchFilterSegment: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBtn: UIButton!
    
    
    //MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ui 설정
        self.searchBtn.layer.cornerRadius = 10  //버튼 모서리 둥글게
        self.searchBar.searchBarStyle = .minimal //써치바 줄 없애기
        
    }

    
    //MARK: - Actions
    
    @IBAction func unSearchBtnClicked(_ sender: Any) {
        print("HomeVC - unSearchBtnClicked() called \(searchFilterSegment.selectedSegmentIndex)")
        
        var segueId: String = ""
        
        //Segue로 화면 이동하기 ***********
        switch searchFilterSegment.selectedSegmentIndex {
        case 0:
            print("사진 화면으로 이동")
            segueId = "goPhotoCollectionVC"
        case 1:
            print("사용자 화면으로 이동")
            segueId = "goUserListVC"
        default:
            print("default")
            segueId = "goPhotoCollectionVC"
        }
        
        // 화면 이동
        self.performSegue(withIdentifier: segueId, sender: self) //self: HomeVC (에서 이동한다는 말)
        
    }
    
    @IBAction func filterValueChanged(_ sender: UISegmentedControl) {
        print("HomeVC - filterValueChanged() called | index \(sender.selectedSegmentIndex)")
        
        var searchBarTitle = ""
        
        //segment index 클릭할 때 마다 검색바 placeholder 변경해주기
        switch sender.selectedSegmentIndex {
        case 0:
            searchBarTitle = "사진 키워드"
        case 1:
             searchBarTitle = "사용자 이름"
        default:
            searchBarTitle = "사진 키워드"
        }
        
        self.searchBar.placeholder = searchBarTitle + "입력"
        
        self.searchBar.becomeFirstResponder() // 검색바에 포커싱 주기
      //  self.searchBar.resignFirstResponder() //포커싱 해제
        
    }
    
}

