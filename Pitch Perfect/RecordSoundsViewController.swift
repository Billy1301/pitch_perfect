//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Billy on 11/15/16.
//  Copyright © 2016 Billy. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    // using audio - import AVFoundation
    @IBAction func recordAudio(_ sender: AnyObject) {
        setUIState(isRecording: false, recordingText: "Recording in Progress")
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker);
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    //set func with arguments to avoid duplicate codes
    
    func setUIState(isRecording:Bool, recordingText:String)
    {
        recordButton.isEnabled = isRecording
        recordingLabel.text = recordingText
        if isRecording {
             stopRecordingButton.isEnabled = false
        } else {
            stopRecordingButton.isEnabled = true
        }
    }
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        setUIState(isRecording: true, recordingText: "Tap to Record")
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            //alert user - help from stack overflow 
            // http://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
            
            let alert = UIAlertController(title: "Alert", message: "recording was not successful", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL as NSURL!
        }
    }
}

