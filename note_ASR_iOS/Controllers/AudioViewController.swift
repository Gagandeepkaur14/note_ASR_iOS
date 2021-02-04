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
    var bombSoundEffect: AVAudioPlayer?
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
            }  else {
          finishRecording(success: true)
            }
    }
    
    //MARK: - start recording audio
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
            finishRecording(success: false)

        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }
    
    //MARK: - SAVE fun is used to save recorded audio
    @IBAction func savePressed(_ sender: Any) {
       
       
         self.navigationController?.popViewController(animated: true)
        
    }
    
// MARK: - play fun is used to play recorded audio
    @IBAction func playPressed(_ sender: Any) {
        if let url = audioFilename{
            do {
                bombSoundEffect = try AVAudioPlayer(contentsOf: url)
                bombSoundEffect?.play()
                print("Playinngngg....")
            } catch {
                 print("couldn't load file :(")
            }
        }
        else{
            print("file not found")
        }
       
    }
    
    
        
       
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print(audioFilename?.absoluteURL ?? "")
        print(audioFilename?.absoluteString ?? "")
        print(audioFilename?.relativeString ?? "")
        if !flag {
            finishRecording(success: false)
        }
        try! recordingSession.setCategory(.playback)
    }

}

