//
//  AppCoordinator.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 20.11.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation

final class AppCoordinator: BaseCoordinator {
    fileprivate let factory: CoordinatorFactoryProtocol
    fileprivate let router : Routable
//    fileprivate let gateway = Gateway()
    init(router: Routable, factory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        
    }
}


// MARK:- Coordinatable

extension AppCoordinator: Coordinatable {
    func start() {
        let userDefaults = UserDefaults.standard
        let set = userDefaults.bool(forKey: "ThemChoisen")
        if set {
            self.performMainFlow()
        } else {
            self.performFirstLaunchFlow()
        }
        
    }
    
}


// MARK:- Private methods
private extension AppCoordinator {
    
    func performFirstLaunchFlow() {
        let coordinator = factory.makeFirstLaunchCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard let `self` = self,
                let `coordinator` = coordinator
                else { return }
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
        
    }
    
    func performMainFlow() {
        let coordinator = factory.makeMainCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard let `self` = self,
                let `coordinator` = coordinator
                else { return }
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}

