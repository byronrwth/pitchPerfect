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
        
        audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true

        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playAudioWithVariableRate(rate: Float){

        // GC: Stopping audioPlayer and audioEngine before reproducing new sound
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func PlaySoundSnail(sender: UIButton) {
        playAudioWithVariableRate(0.5)
    }

    @IBAction func PlaySoundRabbit(sender: UIButton) {
        playAudioWithVariableRate(2.0)
    }
    
    func playAudioWithVariablePitch(pitch: Float){

        // GC: Stopping audioPlayer and audioEngine before reproducing new sound
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

    func playAudioWithReverbEffect(wetDryMix: Float){
        
        // GC: Stopping audioPlayer and audioEngine before reproducing new sound
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changeEffectReverb = AVAudioUnitReverb()
        changeEffectReverb.wetDryMix = wetDryMix

        // GC: Connect te nodes
        audioEngine.attachNode(changeEffectReverb)
        audioEngine.connect(audioPlayerNode, to: changeEffectReverb, format: nil)
        audioEngine.connect(changeEffectReverb, to: audioEngine.outputNode, format: nil)
        
        // GC: Start the audio player
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

    func playAudioWithEchoEffect() {
        
        // GC: Stopping audioPlayer and audioEngine before reproducing new sound
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changeEffectReverb = AVAudioUnitDelay()
        changeEffectReverb.delayTime = 0.3

        // GC: Connect te nodes
        audioEngine.attachNode(changeEffectReverb)
        audioEngine.connect(audioPlayerNode, to: changeEffectReverb, format: nil)
        audioEngine.connect(changeEffectReverb, to: audioEngine.outputNode, format: nil)
        
        // GC: Start the audio player
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func PlaySoundChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func PlayEchoSound(sender: UIButton) {
        playAudioWithEchoEffect()
    }
    
    
    @IBAction func playReverbSound(sender: UIButton) {
        playAudioWithReverbEffect(90)
    }
    
    @IBAction func playSoundDarthvader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func StopButton(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
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
