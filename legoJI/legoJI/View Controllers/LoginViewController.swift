//
//  LoginViewController.swift
//  legoJI
//
//  Created by prk on 27/04/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    var context:NSManagedObjectContext!
    
    @IBAction func loginBtn(_ sender: Any) {
        let username = usernameTxt.text!
        let password = passwordTxt.text!
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        
        if username.isEmpty == false && password.isEmpty == false {
            do {
                let result = try context.fetch(request) as! [NSManagedObject]
                
                if result.count == 0 {
                    print("Login Failed")
                } else {
                    print("Login Successfull")
                    
                    if let nextView = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
                        navigationController?.pushViewController(nextView, animated: true)
                    }
                }
            } catch {
                print("Fetch data failed")
            }
        } else {
            print("Field(s) can't be empty")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
