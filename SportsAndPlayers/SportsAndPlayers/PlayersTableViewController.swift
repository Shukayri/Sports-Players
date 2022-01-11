//
//  PlayersTableViewController.swift
//  SportsAndPlayers
//
//  Created by administrator on 1/10/22.
//

import UIKit
import CoreData

class PlayerTableViewController: UITableViewController {
    @IBOutlet var table: UITableView!
    var sp:Sport?
    var pllist=[Player]()
    let cr=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getpl()
        table.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func getpl(){
        
        let req=NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        req.predicate = NSPredicate(format: "sport == %@", sp!)
        do{
            let fet = try cr.fetch(req)
            pllist = fet as! [Player]
            print("loaded")
            table.reloadData()
        }catch{
            print(error)
        }
        
    }
    @IBAction func add(_ sender: UIBarButtonItem) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField1) in
            textField1.placeholder = "player name"
        }
        alert.addTextField { (textField2) in
            textField2.placeholder = "age"
        }
        alert.addTextField { (textField3) in
            textField3.placeholder = "hight"
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self, weak alert] (_) in
            let textfield1 = alert!.textFields![0] // Force unwrapping because we know it exists.
            let textfield2 = alert!.textFields![1]
            let textfield3 = alert!.textFields![2]
            addcrp(nam: textfield1.text!, age: textfield3.text!, hig: textfield3.text!)
            print("Text field: \(textfield1.text)")
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { [self, weak alert] (_) in
            print("cancel")
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    func addcrp(nam:String,age:String,hig:String){
        let pl=Player(context: cr)
        pl.name=nam
        pl.age=age
        pl.hight=hig
        pl.sport=sp!
        if cr.hasChanges {
            do {
                try cr.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        getpl()
    }
    func edcrp(nam:String,age:String,hig:String,i:Int){
        pllist[i]=Player(context: cr)
        pllist[i].name=nam
        pllist[i].age=age
        pllist[i].hight=hig
        pllist[i].sport=sp!
        if cr.hasChanges {
            do {
                try cr.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        getpl()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pllist.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plcell", for: indexPath)
        
        cell.textLabel!.text="\(pllist[indexPath.row].name!) - Age:\(pllist[indexPath.row].age!), Hight:\(pllist[indexPath.row].hight!)"
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField1) in
            textField1.placeholder = "player name"
        }
        alert.addTextField { (textField2) in
            textField2.placeholder = "age"
        }
        alert.addTextField { (textField3) in
            textField3.placeholder = "hight"
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self, weak alert] (_) in
            let textfield1 = alert!.textFields![0] // Force unwrapping because we know it exists.
            let textfield2 = alert!.textFields![1]
            let textfield3 = alert!.textFields![2]
            edcrp(nam: textfield1.text!, age: textfield3.text!, hig: textfield3.text!,i:indexPath.row)
            print("Text field: \(textfield1.text)")
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { [self, weak alert] (_) in
            print("cancel")
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    }


