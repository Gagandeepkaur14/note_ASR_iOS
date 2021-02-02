//
//  AddNoteViewController.swift
//  note_ASR_iOS
//
//  Created by parneet sandhu on 2021-02-02.
//

import UIKit

class AddNoteViewController: UIViewController {

    
    var selectedSubject : String?
    var selectedNote : Note?
    let context =
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var buttonSubject: UIButton!
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteDesc: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK: - Functions
    
    func loadSavedData(note:Note?){
        if let note = note{
            noteTitle.text = note.title
            noteDesc.text = note.subDescription
            selectedNote = note
        }

}
}
