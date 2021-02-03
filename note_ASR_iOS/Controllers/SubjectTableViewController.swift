//
//  SubjectTableViewController.swift
//  note_ASR_iOS
//
//  Created by Amandeep Kaur on 02/02/21.
//

import UIKit
import CoreData

class SubjectTableViewController: UITableViewController {
   
    var subjects : [Category] = []
    var addNoteVC : AddNoteViewController?
    let context =
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subjects.count
    }
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = subjects[indexPath.row].name
        return cell
    }
   
}
