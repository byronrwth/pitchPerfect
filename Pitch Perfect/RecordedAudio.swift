//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Gustavo Chavez Chavez on 4/10/15.
//  Copyright (c) 2015 Gustavo Chavez. All rights reserved.
//

import Foundation

// GC: This is the model class of the project
class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!

    init(filePathUrl: NSURL, title: String)
    {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}