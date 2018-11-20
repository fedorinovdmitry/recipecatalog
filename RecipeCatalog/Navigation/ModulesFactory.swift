//
//  ModulesFactory.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 20.11.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation

final class ModulesFactory {}

// MARK:- AuthorizationFactoryProtocol
extension ModulesFactory: FirstLaunchFactoryProtocol {
    func makeEnterView() -> ThemsViewController {
        let view: ThemsViewController = ThemsViewController.controllerFromStoryboard(.firstLaunch)
        //firstlaunch
//        EnterAssembly.assembly(with: view)
        return view
    }
}
extension ModulesFactory: MainCoordinatorFactoryProtocol {
    func makeCategoryListView() -> CategoryListViewController {
        let view: CategoryListViewController = CategoryListViewController.controllerFromStoryboard(.main)
        //firstlaunch
        //        EnterAssembly.assembly(with: view)
        return view
    }
}
