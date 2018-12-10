//
//  CoordinatorFactoryProtocol.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 20.11.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation

protocol CoordinatorFactoryProtocol {

    func makeFirstLaunchCoordinator(router: Routable) -> Coordinatable & FirstLaunchCoordinatorOutput
    func makeMainCoordinator(router: Routable) -> Coordinatable & MainCoordinatorOutput
}
