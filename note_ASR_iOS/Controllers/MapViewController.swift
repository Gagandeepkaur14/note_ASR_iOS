//
//  MapViewController.swift
//  note_ASR_iOS
//
//  Created by parneet sandhu on 2021-02-03.
//

import UIKit
import MapKit


class MapViewController: UIViewController {
    
    
    var note : Note?
    
    
    @IBOutlet weak var mapView: MKMapView!


    override func viewDidLoad() {
        super.viewDidLoad()
        loadSavedData()
        // Do any additional setup after loading the view.
    }
    
    func loadSavedData(){
        if let selectedNote = note{
            
            let cor = CLLocationCoordinate2D(latitude: selectedNote.lat, longitude: selectedNote.long)
            
            // define span
            let span = MKCoordinateSpan(latitudeDelta: 0.10, longitudeDelta: 0.10)
            
            // define the region
             let region = MKCoordinateRegion(center: cor, span: span)
            
            // set the region for the map
             mapView.region = region
            
            //  define annotation
            let ann = MKPointAnnotation()
            ann.coordinate = cor
            ann.title = selectedNote.title
            ann.subtitle = (selectedNote.date)!.description
            mapView.addAnnotation(ann)
        }
       
    }
    

   

}
