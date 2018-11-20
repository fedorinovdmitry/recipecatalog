//
//  NSObject+ClassDefinition.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 20.11.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation

extension NSObject {
    static func nameOfClass() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
