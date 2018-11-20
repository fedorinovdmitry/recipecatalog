//
//  CoordinatorFactory.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 20.11.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation

final class CoordinatorFactory {
    fileprivate let modulesFactory = ModulesFactory()
}

extension CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeFirstLaunchCoordinator(router: Routable) -> Coordinatable & FirstLaunchCoordinatorOutput {
        return FirstLaunchCoordinator(router: router, factory: modulesFactory)
    }
    func makeMainCoordinator(router: Routable) -> Coordinatable & MainCoordinatorOutput {
        return MainCoordinator(router: router, factory: modulesFactory)
    }
}
