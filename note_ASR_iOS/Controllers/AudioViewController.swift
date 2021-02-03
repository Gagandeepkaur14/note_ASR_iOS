//
//  AudioViewController.swift
//  note_ASR_iOS
//
//  Created by parneet sandhu on 2021-02-02.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController,AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var addNoteVC : AddNoteViewController?
    var audioFilename : URL?
    
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
        if audioRecorder == nil {
            startRecording()
            //
        }
    }
    
    
    func startRecording() {
        try! recordingSession.setCategory(.record)
         audioFilename = getDocumentsDirectory().appendingPathComponent("\(UUID().uuidString).m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename!, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            recordButton.setTitle("Tap to Stop", for: .normal)
        } catch {
            //
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
   

}
