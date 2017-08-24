//
//  MeetingDetailTVC.swift
//  RM53
//
//  Created by Ayu on 8/9/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit
import Speech

class MeetingDetailTVC: UITableViewController, UITextViewDelegate {
    
    @IBOutlet weak var companyIcon: UIImageView!
    
    @IBOutlet weak var callPlanIcon: UIImageView!
    
    @IBOutlet weak var callReportIcon: UIImageView!
    @IBOutlet weak var reasonIcon: UIImageView!
    
    
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var callPlanLbl: UILabel!
    @IBOutlet weak var reasonLbl: UILabel!
    
    @IBOutlet weak var callReportLbl: UITextView!
    @IBOutlet weak var detailLbl: UILabel!
    
    var saveButton: UIBarButtonItem!
    var editButton: UIBarButtonItem!
    var meetings = [String: String]()
    
    //Spech
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    let tintColor = UIColor(red: 101/255.0, green: 143/255.0, blue: 25/255.0, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.callReportLbl.delegate = self
        recordButton.isEnabled = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 00/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationItem.title = meetings["company"]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        saveButton = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(saveItem))
        
         editButton = UIBarButtonItem(image: UIImage(named: "edit"), style: .plain, target: self, action: #selector(editItem))
        updateRow()
        saveButton.isEnabled = false
        editButton.isEnabled = true
        callReportLbl.isEditable = false
        self.navigationItem.rightBarButtonItems = [editButton,saveButton]
        self.tableView.tableFooterView = UIView()
        self.tableView.isScrollEnabled = true
        companyIcon.tintColor = tintColor
        callPlanIcon.tintColor = tintColor
        reasonIcon.tintColor = tintColor
        callReportIcon.tintColor = tintColor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        speechRecognizer.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            /*
             The callback may not be called on the main thread. Add an
             operation to the main queue to update the record button's state.
             */
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.recordButton.isEnabled = true
                    print("User given permission")
                case .denied:
                    self.recordButton.isEnabled = false
                   // self.recordButton.setTitle("User denied access to speech recognition", for: .disabled)
                    print("User denied access to speech recognition")
                    
                case .restricted:
                    self.recordButton.isEnabled = false
                 //   self.recordButton.setTitle("Speech recognition restricted on this device", for: .disabled)
                    print("Speech recognition restricted on this device")
                    
                case .notDetermined:
                    self.recordButton.isEnabled = false
                   // self.recordButton.setTitle("Speech recognition not yet authorized", for: .disabled)
                     print("Speech recognition not yet authorized")
                }
            }
        }
    }
    
    func updateRow(){
        companyLbl.text = meetings["company"]
        callPlanLbl.text = meetings["callPlaneName"]
        reasonLbl.text = meetings["reason"]
        callReportLbl.text = meetings["details"]
        callReportLbl.sizeToFit()
    }

    func saveItem(){
        saveButton.isEnabled = false
        editButton.isEnabled = true
        callReportLbl.isEditable = false
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func editItem(){
        callReportLbl.isEditable = true
        callReportLbl.becomeFirstResponder()
        //callReportLbl.sizeToFit()
        editButton.isEnabled = false
        saveButton.isEnabled = true
    }
    
    @IBAction func recordCallReport(_ sender: UIButton) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recordButton.isEnabled = false
            //recordButton.setTitle("Stopping", for: .disabled)
            self.recordButton.setImage(UIImage(named: "microphone1"), for: .disabled)
        } else {
            try! startRecording()
            //recordButton.setTitle("Stop recording", for: [])
            self.recordButton.setImage(UIImage(named: "mute1"), for: [])
            self.recordButton.tintColor = UIColor.red
        }
    }
    
    private func startRecording() throws {
        
        // Cancel the previous task if it's running.
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else { fatalError("Audio engine has no input node") }
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        // Configure request so that results are returned before audio recording is finished
        recognitionRequest.shouldReportPartialResults = true
        
        // A recognition task represents a speech recognition session.
        // We keep a reference to the task so that it can be cancelled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                self.callReportLbl.text = result.bestTranscription.formattedString
                //self.callReportLbl.text = self.callReportLbl.text.appending(result.bestTranscription.formattedString)
                //self.callReportLbl.text.append(result.bestTranscription.formattedString)
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.recordButton.isEnabled = true
                self.recordButton.setImage(UIImage(named: "microphone1"), for: .normal)
               // self.recordButton.setTitle("Start Recording", for: [])
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        try audioEngine.start()
        if callReportLbl.text == "" {
            callReportLbl.text = "(Started recording)"
        }
    }

}

extension  MeetingDetailTVC: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            recordButton.isEnabled = true
            recordButton.setTitle("Start Recording", for: [])
        } else {
            recordButton.isEnabled = false
            recordButton.setTitle("Recognition not available", for: .disabled)
        }
    }
}
