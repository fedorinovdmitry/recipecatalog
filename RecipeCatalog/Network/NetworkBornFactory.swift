//
//  NetworkBornFactory.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 07.11.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation

/** Фабрика сетевых запросов */
class NetworkBornFactory {
    func makeRequestsToFireBase() -> RequestsToFireBaseFactory {
        return RequestsToFireBase()
    }
    func makeRequestsToAlomofire() -> AlomofireNetworkFactory {
        return AlomofireNetworkRouter()
    }
}
