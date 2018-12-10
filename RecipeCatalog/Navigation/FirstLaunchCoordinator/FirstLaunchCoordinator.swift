//
//  FirstLaunchCoordinator.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 20.11.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation

final class FirstLaunchCoordinator: BaseCoordinator, FirstLaunchCoordinatorOutput {

    var finishFlow: CompletionBlock?

    fileprivate let factory: FirstLaunchFactoryProtocol
    fileprivate let router: Routable

    init(router: Routable, factory: FirstLaunchFactoryProtocol) {
        self.factory = factory
        self.router  = router
    }
}

// MARK:- Coordinatable
extension FirstLaunchCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK:- Private methods
private extension FirstLaunchCoordinator {
    func performFlow() {
        let enterView = factory.makeEnterView()
        enterView.onCompletion = finishFlow
        router.setRootModule(enterView, hideBar: true)
    }
}
