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
    
    fileprivate let factory: AuthorizationFactoryProtocol
    fileprivate let router : Routable
    
    init(with factory: AuthorizationFactoryProtocol, router: Routable) {
        self.factory = factory
        self.router  = router
    }
}

// MARK:- Coordinatable
extension AuthorizationCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK:- Private methods
private extension AuthorizationCoordinator {
    func performFlow() {
        let view = factory.makeEnterView()
        view.onCompletion = finishFlow
        router.setRootModule(view, hideBar: true)
    }
}
