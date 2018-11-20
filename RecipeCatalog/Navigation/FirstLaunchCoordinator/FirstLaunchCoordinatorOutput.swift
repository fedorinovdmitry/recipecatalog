//
//  FirstLaunchCoordinatorOutput.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 20.11.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation

///Протокол для осуществления связи с вышестоящем коррдинатором AppCoordinator
protocol FirstLaunchCoordinatorOutput: class {
    var finishFlow: CompletionBlock? { get set }
}
