//
//  ViewController.swift
//  FirstCoreData
//
//  Created by 안현정 on 2022/01/14.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    //콘텍스트 속성 선언
    var context : NSManagedObjectContext {
        guard let app = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        return app.persistentContainer.viewContext
        
    }
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    
    
    
    @IBAction func createEntity(_ sender: Any) {
    }
    
    @IBAction func readEntity(_ sender: Any) {
    }
    
    @IBAction func updateEntity(_ sender: Any) {
    }
    
    @IBAction func deleteEntity(_ sender: Any) {
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

