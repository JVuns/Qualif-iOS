//
//  HomeViewController.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController,
                          UITableViewDelegate, UITableViewDataSource {
    
    var arrOfInitial = [String]()
    var arrOfName = [String]()
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfInitial.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        cell.initialTF.text = arrOfInitial[indexPath.row]
        cell.nameTF.text = arrOfName[indexPath.row]
        
        cell.updateHandler = {
            self.updateData(cell:cell, indexPath:indexPath)
        }
        
        return cell
    }

    
    func loadData(){
        arrOfInitial.removeAll()
        arrOfName.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Assistants")
        
        do{
            let results = try context.fetch(request)
            as! [NSManagedObject]
            
            for data in results{
                arrOfInitial.append(data.value(forKey:"initial")  as! String)
                arrOfName.append(data.value(forKey:"name")  as! String)
            }
            assistantTV.reloadData()
        }catch{
            
        }
        
                
    }
    
    func updateData(cell:UITableViewCell, indexPath: IndexPath){
        //ambil txt
    }
    
    
    @IBAction func insertButton(_ sender: Any) {
        let entity = NSEntityDescription.entity(forEntityName: "Assistants", in: context)
        let newAssistant = NSManagedObject(entity:entity!, insertInto: context)
        
        //bikin new assistant
        newAssistant.setValue(initialTF.text, forKey: "initial")
        newAssistant.setValue(nameTF.text, forKey: "name")
        //save
        do{
            try context.save()
            loadData()
        }catch{
            print("Error")
        }
    }
    

    @IBOutlet weak var assistantTV: UITableView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var initialTF: UITextField!
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
        assistantTV.delegate = self
        assistantTV.dataSource = self
        loadData()
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
