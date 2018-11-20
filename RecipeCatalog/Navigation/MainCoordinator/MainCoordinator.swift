//
//  MainCoordinator.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 20.11.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation

final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let factory: MainCoordinatorFactoryProtocol
    fileprivate let router: Routable
    
    init(router: Routable, factory: MainCoordinatorFactoryProtocol) {
        self.factory = factory
        self.router  = router
    }
}

// MARK:- Coordinatable
extension MainCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK:- Private methods
private extension MainCoordinator {
    func performFlow() {
        let enterView = factory.makeCategoryListView()
        enterView.onCompletion = finishFlow
        router.setRootModule(enterView)
    }
}
