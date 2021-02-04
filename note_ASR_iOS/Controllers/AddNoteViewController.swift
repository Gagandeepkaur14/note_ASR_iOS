//
//  AddNoteViewController.swift
//  note_ASR_iOS
//
//  Created by parneet sandhu on 2021-02-02.
//

import UIKit
import AVFoundation
import CoreLocation

class AddNoteViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, CLLocationManagerDelegate{

    var selectedImage : String?
    var selectedSubject : String?
    var selectedNote : Note?
    var selectedAudio : String?
    var manager = CLLocationManager()
    var location : CLLocation?

    let context =
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonSubject: UIButton!
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteDesc: UITextView!
    @IBOutlet weak var buttonRecord: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

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
    //MARK: - IB Actions

    @IBAction func photoPressed(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    func camera()
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true)
        
    }
    func photoLibrary()
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    //MARK: - Camera and Photo Delegats
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.editedImage] as? UIImage {
        imageView.image = image
        selectedImage = (info[.imageURL] as? URL)?.absoluteString
    }
    else if let image = info[.originalImage] as? UIImage {
        imageView.image = image
        selectedImage = (info[.imageURL] as? URL)?.absoluteString
    } else {
        print("Other Source")
    }
    picker.dismiss(animated: true, completion: nil)
}
func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
}
   
    //MARK:- Perp Segaue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "subject"{
            let vc = segue.destination as! SubjectTableViewController
            vc.addNoteVC = self
        }

        else if segue.identifier == "map"{
             let vc = segue.destination as! MapViewController
             vc.note = selectedNote
         }
         else{
             let vc = segue.destination as! AudioViewController
             if let _ = selectedAudio{
                 vc.audioFilename = URL(string: selectedAudio!)
             }
             vc.addNoteVC = self
         }
}

}
