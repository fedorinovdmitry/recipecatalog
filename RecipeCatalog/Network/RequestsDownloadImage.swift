//
//  RequestsDownloadImage.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 07.11.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

/** Фабрика запросов через аламофаер */
protocol AlomofireNetworkFactory {
    func downloadImage(url:String, completion: @escaping (Image?) -> Void)
}
/** Класс реализующий запросы через аламофаер */
class AlomofireNetworkRouter: AlomofireNetworkFactory{
    
    ///получение картинки по ее урл
    /// - completion - затыкание где будет использована данная картинка
    func downloadImage(url:String, completion: @escaping (Image?) -> Void) {
        Alamofire.request(url).responseImage { response in
            completion(response.result.value)
        }
    }
}
