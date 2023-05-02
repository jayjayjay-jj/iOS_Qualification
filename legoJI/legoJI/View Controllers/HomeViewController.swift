//
//  HomeViewController.swift
//  legoJI
//
//  Created by prk on 28/04/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrOfName = [String]()
    var arrOfPrice = [String]()
    var arrOfDesc = [String]()
    
    var context:NSManagedObjectContext!
    
    @IBOutlet var nameTxt: UITextField!
    
    @IBOutlet var priceTxt: UITextField!
    
    @IBOutlet var descTxt: UITextField!
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LegoTableViewCell
        
        cell.nameTxt.text = arrOfName[indexPath.row]
        cell.priceTxt.text = arrOfPrice[indexPath.row]
        cell.descTxt.text = arrOfDesc[indexPath.row]
        
        cell.updateHandler = {
            self.updateData(cell : cell, indexPath : indexPath)
        }
        
        cell.deleteHandler = {
            self.deleteData(cell : cell, indexPath : indexPath)
        }
        
        return cell
    }
    
    func updateData(cell : LegoTableViewCell, indexPath : IndexPath) {
        let oldName = arrOfName[indexPath.row]
        let oldPrice = arrOfPrice[indexPath.row]
        let oldDesc = arrOfDesc[indexPath.row]
        
        let newPrice = cell.priceTxt.text
        let newDesc = cell.descTxt.text
        
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Legos")
        req.predicate = NSPredicate(format: "name == %@", oldName)
        
        do {
            let results = try context.fetch(req) as! [NSManagedObject]
            
            for data in results {
                data.setValue(newPrice, forKey: "price")
                data.setValue(newDesc?.capitalized, forKey: "desc")
            }
            
            try context.save()
            loadData()
        } catch {
            print("Update Lego Failed")
        }
    }
    
    func deleteData(cell : LegoTableViewCell, indexPath : IndexPath) {
        let name = arrOfName[indexPath.row]
        
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Legos")
        
        req.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let result = try context.fetch(req) as! [NSManagedObject]
            
            for data in result {
                context.delete(data)
            }
            
            try context.save()
            loadData()
        } catch {
            print("Delete Failed")
        }
    }
 
    @IBAction func insertBtn(_ sender: Any) {
        let name = nameTxt.text!
        let price = priceTxt.text!
        let desc = descTxt.text!
        
        let entity = NSEntityDescription.entity(forEntityName: "Legos", in: context)
        
        let newLego = NSManagedObject(entity: entity!, insertInto: context)
        
        newLego.setValue(name.uppercased(), forKey: "name")
        newLego.setValue(price, forKey: "price")
        newLego.setValue(desc.capitalized, forKey: "desc")
        
        do {
            try context.save()
            loadData()
        } catch {
            print("Insert Lego Failed")
        }
    }
    
    func loadData() {
        arrOfName.removeAll()
        arrOfPrice.removeAll()
        arrOfDesc.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Legos")
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            
            for data in results {
                arrOfName.append(data.value(forKey: "name") as! String)
                arrOfPrice.append(data.value(forKey: "price") as! String)
                arrOfDesc.append(data.value(forKey: "desc") as! String)
            }
            
            tableView.reloadData()
        } catch {
            print("Load Data Failed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        tableView.delegate = self
        tableView.dataSource = self
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
