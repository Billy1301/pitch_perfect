//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Billy on 11/29/16.
//  Copyright © 2016 Billy. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    // you can enter code first then connect them at the connection inspector or drag at mainstoryboard
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // must import AVFoundation to use these features
    // then we have to import the file
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    //this uses the tag number with the switch statement
    enum ButtonType: Int {
            // tags in order = 0, 1,2,3,4,5
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    //MARK: playButton
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        
        //this connects with the enum ButtonType by tag 0 to 5
        switch(ButtonType(rawValue: sender.tag)!) {
            case .slow:
                playSound(rate: 0.5)
            case .fast:
                playSound(rate: 1.5)
            case .chipmunk:
                playSound(pitch: 1000)
            case .vader:
                playSound(pitch: -1000)
            case .echo:
                playSound(echo: true)
            case .reverb:
                playSound(reverb: true)
            }
            configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        setButtonFit()
    }
    
    func setButtonFit(){
        snailButton.imageView?.contentMode = .scaleAspectFit
        chipmunkButton.imageView!.contentMode = .scaleAspectFit
        rabbitButton.imageView!.contentMode = .scaleAspectFit
        vaderButton.imageView!.contentMode = .scaleAspectFit
        echoButton.imageView!.contentMode = .scaleAspectFit
        reverbButton.imageView!.contentMode = .scaleAspectFit
        stopButton.imageView!.contentMode = .scaleAspectFit
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }

}
