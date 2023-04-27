//
//  LoginViewController.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as!
        AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func loginButton(_ sender: Any) {
        //fetch ui data
        let username = usernameTF.text
        let password = passwordTF.text
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.predicate = NSPredicate(format: "username==%@ AND password==%@", username!, password!)
        
        //request core data
        do{
            let result = try context.fetch(request) as! [NSManagedObject]
            
            if(result.count == 0){
                print("Failed to log in")
            }else{
                //redirect
                if let nextView =
                    storyboard?
                    .instantiateViewController(withIdentifier:
                                                "HomeViewController"){
                    navigationController?.pushViewController(nextView, animated: true)
                }
            }
        }catch{
            print("Unexpected Error")
        }
        
        //kondisi
        
        
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
