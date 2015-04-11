//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Gustavo Chavez Chavez on 4/10/15.
//  Copyright (c) 2015 Gustavo Chavez. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var recievedAudio:RecordedAudio!

    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view. 
        
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//            var filepathURL = NSURL.fileURLWithPath(filePath)
//            audioPlayer = AVAudioPlayer(contentsOfURL: filepathURL, error: nil)
//            audioPlayer.enableRate = true
//        }
//        else {
//                println("GC: The filePath is empty")
//        }
        
        audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true

        //var audioEngine: AVAudioEngine!

        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PlaySoundSnail(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    @IBAction func PlaySoundRabbit(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 2.0
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){

        // GC: Stop all audio
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        // GC: Connect te nodes
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        // GC: Start the audio player
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    @IBAction func PlaySoundChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func playSoundDarthvader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func StopButton(sender: UIButton) {
        audioPlayer.stop()
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
