//
//  SportTableViewController.swift
//  SportsAndPlayers
//
//  Created by administrator on 1/10/22.
//

import UIKit

import CoreData

class SportTableViewController: UITableViewController {
    @IBOutlet var table: UITableView!
    
    var splist=[Sport]()
    let cr=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getall()
        table.delegate=self
        table.dataSource=self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func getall(){
        let req=NSFetchRequest<NSFetchRequestResult>(entityName: "Sport")
        do{
            let fet = try cr.fetch(req)
            splist = fet as! [Sport]
            
        }catch{
            print(error)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let seg = segue.destination as! PlayerTableViewController
        seg.sp = splist[(sender as! IndexPath ).row]
        
    }
    func addcr(spn:String){
        var temp = Sport(context: cr)
        temp.name=spn
       
        if cr.hasChanges {
            do {
                try cr.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        getall()
        
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "add sport", message: "", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "sport name"
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self, weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            addcr(spn: textField.text!)
            table.reloadData()
            print("Text field: \(textField.text)")
            
            
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { [self, weak alert] (_) in
            print("cancel")
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return splist.count
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "toplayer", sender: indexPath)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spcell", for: indexPath) as! ViewController
        cell.sport.text=splist[indexPath.row].name
        cell.sp=indexPath.row
        cell.own=self
        if let image = splist[indexPath.row].img {
            cell.img.image = UIImage(data: image)
            cell.addimg.isHidden=true
        }
        // Configure the cell...

        return cell
    }
    

    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
