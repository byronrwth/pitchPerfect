//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Gustavo Chavez Chavez on 4/5/15.
//  Copyright (c) 2015 Gustavo Chavez. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {

    @IBOutlet weak var recordingOutlet: UILabel!
    @IBOutlet weak var stopButtonOutlet: UIButton!
    @IBOutlet weak var recordButtonOutlet: UIButton!
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        stopButtonOutlet.hidden=true
        recordButtonOutlet.enabled = true
    }

    @IBAction func RecordAudio(sender: UIButton) {

        println("GC: I hit the button Record")
        recordButtonOutlet.enabled = false
        stopButtonOutlet.hidden=false
        recordingOutlet.hidden = false
        
        //TODO: Save audio
        //Inside func recordAudio(sender: UIButton)
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss" 
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println("GC: File Path = \(filePath)")
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        

        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {

        // TODO: Step 1. Save the recording audio
        if (flag) {
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent

            // TODO: Step 2. Pass it to the next scene
            self.performSegueWithIdentifier("stopRecordingSegue", sender: recordedAudio)
        }
        
        else {
            println("GC: Recording was not successful")
            recordButtonOutlet.enabled = true
            stopButtonOutlet.hidden = true
        }


    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // CG: check the correspoding segue
        if (segue.identifier == "stopRecordingSegue") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.recievedAudio = data
            
        }
    }

    @IBAction func stopAudio(sender: UIButton) {
        recordingOutlet.hidden=true

        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

