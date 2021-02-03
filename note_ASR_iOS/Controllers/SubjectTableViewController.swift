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
        loadSavedData()

        tableView.allowsSelectionDuringEditing = true
}
   
    override func viewWillAppear(_ animated: Bool) {

        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editPressed))
         add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        navigationItem.rightBarButtonItems = [add,edit]
    }
  
    //MARK:- edit func
    @objc func editPressed() {
        if !tableView.isEditing{
            let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(editPressed))
            tableView.isEditing = true
            navigationItem.rightBarButtonItems = [add,done]
        }
        else {
            let edit = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editPressed))
            tableView.isEditing = false
            navigationItem.rightBarButtonItems = [add,edit]
        }
    }
    
    // update subject
    func updateSavedData(subject : Category,name:String) {
        subject.name = name
        saveContext()
    }
    
    
    
    //Mark:- adding a new subject
    @objc func addPressed() {
        self.showInputDialog(title: "Enter New Subject", actionTitle: "Add", inputPlaceholder: "Subject", inputKeyboardType: .default, cancelHandler: nil) { (txt) in
            guard let subject = txt else{return}
            self.savedData(name: subject)
        }
    }
    
    // save new subject
    func savedData(name : String) {
        for subject in subjects{
        if subject.name == name{
            let alert  = UIAlertController(title: "Error", message: "Same subject name is not allowed.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
            }
        }
        let subject = Category(context: context)
        subject.name = name
        saveContext()
    }
    func saveContext(){
        do {
            try context.save()
        } catch  {
            print("Error \(error.localizedDescription)")
        }
        loadSavedData()

    }
    
    // load subjects
    func loadSavedData() {
        subjects = []
        subjects = try! context.fetch(Category.fetchRequest())
        tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing{
            self.showInputDialog(title: "Update", subtitle: "Update subject name..", actionTitle: "Save",defaultText: subjects[indexPath.row].name, inputKeyboardType: .default, actionHandler:  { (txt) in
                guard let subject = txt else{return}
                self.updateSavedData(subject: self.subjects[indexPath.row], name: subject)
            })
        }
        
        
    }
   
}
