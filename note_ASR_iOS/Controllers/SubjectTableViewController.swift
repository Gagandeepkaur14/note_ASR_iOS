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
    var add = UIBarButtonItem()
    let context =
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelectionDuringEditing = true

    }
    override func viewWillAppear(_ animated: Bool) {
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editPressed))
         add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        navigationItem.rightBarButtonItems = [add,edit]
    }
    @objc func editPressed() {
       
        
    }
    @objc func addPressed() {
        self.showInputDialog(title: "Enter New Subject", actionTitle: "Add", inputPlaceholder: "Subject", inputKeyboardType: .default, cancelHandler: nil) { (txt) in
            guard let subject = txt else{return}
     //       self.savedData(name: subject)

        }
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
