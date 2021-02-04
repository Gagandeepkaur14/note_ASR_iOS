//
//  LandingViewController.swift
//  note_ASR_iOS
//
//  Created by Amandeep Kaur on 01/02/21.
//

import UIKit
import CoreData

class LandingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate  {
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var notes : [Note] = []
    let context =
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        loadSavedData()
        searchBar.text = ""
        tabBarController?.navigationItem.rightBarButtonItem = nil
        tabBarController?.title = "Notes"
    }
    // load subjects
    func loadSavedData() {
        notes = []
        notes = try! context.fetch(Note.fetchRequest())
        tableView.reloadData()
    }
    // delete notes
    func deleteSavedData(note: Note){
        context.delete(note)
        try! context.save()
        loadSavedData()
    }
    //MARK: - Segue Prep
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "onCellClick"{
            let controller = segue.destination as! AddNoteViewController
            guard let index = tableView.indexPathForSelectedRow else {return}
            controller.selectedNote = notes[index.row]
        }
    }
    
    //MARK: - Tableview Delegates and Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.category
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.deleteSavedData(note: notes[indexPath.row])
        }
    }
    //MARK: - SearchBar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            var predicate: NSPredicate = NSPredicate()
            predicate = NSPredicate(format: "title contains[c] '\(searchText)' || subDescription contains[c] '\(searchText)'")
            let fetchRequest :NSFetchRequest<Note> = Note.fetchRequest()
            fetchRequest.predicate = predicate
            do {
                notes = try context.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error)")
            }
        }else{
            loadSavedData()
        }
        
        tableView.reloadData()
    }
}


