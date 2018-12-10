//
//  Constants.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 20.11.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation

// MARK:- Typealiases
typealias CompletionBlock = () -> Void
typealias AlertCompletionBlock = (String) -> Void

// MARK:- Storyboards enum
enum Storyboards: String {
    
    case main = "Main"
    case firstLaunch = "FirstLaunch"
    
}

