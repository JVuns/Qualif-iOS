//
//  RegisterViewController.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var UsernameTF: UITextField!
    
    @IBOutlet weak var EmailTF: UITextField!
    
    @IBOutlet weak var PasswordTF: UITextField!
    
    @IBOutlet weak var ConfirmPasswordTF: UITextField!
    
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up connection to coredata
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func RegisterButton(_ sender: Any) {
        
        var message = ""
        let username = UsernameTF.text!
        let password = PasswordTF.text!
        let email = EmailTF.text!
        let confirmPassword = ConfirmPasswordTF.text!
        
        //validation
        if(username.isEmpty) {message = "username is empty"}
        if(password.isEmpty) {message = "password is empty"}
        if(email.isEmpty) {message = "email is empty"}
        if (!password.elementsEqual(confirmPassword)){message = "password does not match"}
        
        if(message.isEmpty){
            //handle success
            print("Success")
            let nextView = LoginViewController()
            if let nextView =
                storyboard?
                .instantiateViewController(withIdentifier:
                                            "LoginViewController"){
                navigationController?.pushViewController(nextView, animated: true)
            }
        }else{
            print("\(message)")
            return
        }
        
        //create entity
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        
        //create user entity
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(username, forKey: "username")
        newUser.setValue(password, forKey: "password")
        newUser.setValue(email, forKey: "email")
        
        //insert user
        do{
            try context.save()
            print("Success")
        }catch{
            print("Insert Failed")
        }
        
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
