//
//  AudioViewController.swift
//  note_ASR_iOS
//
//  Created by parneet sandhu on 2021-02-02.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var addNoteVC : AddNoteViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recorderSettingUp()


        // Do any additional setup after loading the view.
    }
    
    
    func recorderSettingUp(){
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
    }
    func loadRecordingUI(){
        recordButton.setTitle("Tap to Record", for: .normal)
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        view.addSubview(recordButton)
    }
     
    @objc func recordTapped() {
       
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
