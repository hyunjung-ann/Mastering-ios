
//
//  ViewController.swift
//  JsonParsing
//
//  Created by 안현정 on 2022/01/18.
//

import UIKit
import Toast_Swift

//UISearchBarDelegate - 검색어를 입력했을 때 감지할 수 있게함

class HomeVC: UIViewController, UISearchBarDelegate, UIGestureRecognizerDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var searchFilterSegment: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBtn: UIButton!
    
    var keyboardDismissTabGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
    
    //MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ui 설정
        self.config()
 
    }

    
    //MARK: - FilePrivate methods
    
    fileprivate func config(){
        
        //ui 설정
        self.searchBtn.layer.cornerRadius = 10  //버튼 모서리 둥글게
        
        self.searchBar.searchBarStyle = .minimal //써치바 줄 없애기
        
        self.searchBar.delegate = self
        
        self.keyboardDismissTabGesture.delegate = self
        
        // 제스처 추가하기
        self.view.addGestureRecognizer(keyboardDismissTabGesture)
        
        self.searchBar.becomeFirstResponder() //포커싱 주기
    }
    
    
    fileprivate func pushVC() {
        var segueId: String = ""
        
        //Segue로 화면 이동하기 ***********
        switch searchFilterSegment.selectedSegmentIndex {
        case 0: //선택된 인덱스가 0이라면,
            print("사진 화면으로 이동")
            segueId = "goPhotoCollectionVC"
        case 1:
            print("사용자 화면으로 이동")
            segueId = "goUserListVC"
        default:
            print("default")
            segueId = "goPhotoCollectionVC"
        }
        
        // segue 화면 이동
        self.performSegue(withIdentifier: segueId, sender: self) //self: HomeVC (에서 이동한다는 말)
        
    }
    
    
    //MARK: - Actions
    
    @IBAction func onSearchBtnClicked(_ sender: Any) {
        print("HomeVC - unSearchBtnClicked() called \(searchFilterSegment.selectedSegmentIndex)")
        
        // 화면으로 이동
        pushVC()
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
        // self.searchBar.resignFirstResponder() //포커싱 해제
        
    }
    
    
    //MARK: - UISearchBarDelegate Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("HomeVC - searchBarSearchButtonClicked() ")
        
        guard let userInputString = searchBar.text else {return}
        
        if userInputString.isEmpty {
            self.view.makeToast("📣 검색 키워드를 입력해주세요", duration: 1.0, position: .center)
        } else {
            pushVC()
            searchBar.resignFirstResponder()
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("HomeVC - searchBar textDidChange() searchText : \(searchText)")
        
        //사용자가 입력한 값이 없을 때
        if (searchText.isEmpty) {
            //버튼 숨기기 처리
            self.searchBtn.isHidden = true
            
            //searchbar에 x표시 눌러서 키보드 내려가게 하기
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                searchBar.resignFirstResponder() //포커싱해제
            })
    
        } else {
            self.searchBtn.isHidden = false
        }
        
  
    }
    
    
    
    // 글자가 입력될 때
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //텍스트필드에 들어온 입력 값
        let inputTextCount = searchBar.text?.appending(text).count ?? 0
        
        print("shouldChangeTextIn: \(searchBar.text?.appending(text).count)")
        
        //12자 입력 넘어갈시 경고창
        if (inputTextCount >= 12) {
            // toast with a specific duration and position
            self.view.makeToast("📢 12자 까지만 입력가능합니다", duration: 1.0, position: .center)
        }
        
//        if inputTextCount <= 12 { //inputtext가 12자가 넘어가지 않으면
//            return true //텍스트 입력 가능
//        } else { //아니라면
//            return false //텍스트 입력 불가능
//        }
        
        return inputTextCount <= 12
        
    }
    
    //MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        // print("HomeVC- gestureRecognizer shouldReceive() called")
        
        // 터치로 들어온 뷰가 요놈이면
        if(touch.view?.isDescendant(of: searchFilterSegment) == true){
            print("세그먼트가 터치되었다.")
            return false
        } else if (touch.view?.isDescendant(of: searchBar) == true) {
            print("서치바가 터치되었다")
            return false
        } else {
            view.endEditing(true) //키보드 내려가게 됨
            print("화면이 터치되었다")
            return true
        
        }
    }
    
}

