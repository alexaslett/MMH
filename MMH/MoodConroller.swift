//
//  MoodConroller.swift
//  MMH
//
//  Created by Alex Aslett on 8/31/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation

class MoodController {
    
    static let shared = MoodController()
    
    enum moodState: String {
        case H = "Happy"
        case S = "Sad"
        case N = "Neutral"
    }
    
    let moods: [Mood] = {[
        Mood(moodName: "Happy", moodState: moodState.H.rawValue),
        Mood(moodName: "Sad", moodState: moodState.S.rawValue),
        Mood(moodName: "Neutral", moodState: moodState.N.rawValue),
        Mood(moodName: "Joyful", moodState: moodState.H.rawValue),
        Mood(moodName: "Apathetic", moodState: moodState.N.rawValue),
        Mood(moodName: "Depressed", moodState: moodState.S.rawValue),
        Mood(moodName: "Excited", moodState: moodState.H.rawValue),
        Mood(moodName: "Bad", moodState: moodState.S.rawValue),
        ]
        }()
    
}
