//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Gustavo Chavez Chavez on 4/5/15.
//  Copyright (c) 2015 Gustavo Chavez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func RecordAudio(sender: UIButton) {

        println("I hit the button Record")
        recordingOutlet.hidden = false
        
        //TODO: Save audio
    }

}

