//
//  RegisterViewController.swift
//  legoJI
//
//  Created by prk on 27/04/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var paswordTxt: UITextField!
    
    @IBOutlet weak var confirmPassTxt: UITextField!
    
    var context:NSManagedObjectContext!
    
    @IBAction func registerBtn(_ sender: Any) {
        let username = usernameTxt.text as! String
        let email = emailTxt.text as! String
        let password = paswordTxt.text as! String
        let confirmPass = confirmPassTxt.text as! String
        
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(username, forKey: "username")
        newUser.setValue(email, forKey: "email")
        newUser.setValue(password, forKey: "password")
        
        
        do {
            try context.save()
            
            if let nextView = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
                navigationController?.pushViewController(nextView, animated: true)
            }
        }
        catch {
            print("Register failed")
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
