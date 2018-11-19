//
//  FlickerSearchRouter.swift
//  Flicker
//
//  Created by Rahul Shivuni on 11/18/18.
//  Copyright © 2018 Rahul Shivuni. All rights reserved.
//

import UIKit

protocol FlickerSearchRouting: class {
}

final class FlickerSearchRouter: FlickerSearchRouting {
    
    private weak var view: UIViewController!
    private weak var nav: UINavigationController!
    
    static func makeController() -> UIViewController {
        let board = UIStoryboard(name: "FlickerSearch", bundle: nil)
        let vc = board.instantiateInitialViewController() as! FlickerSearchViewController
        
        vc.title = "Flicker Search"
        let navController = UINavigationController(rootViewController: vc)
        let router = FlickerSearchRouter()
        let presenter = FlickerSearchPresenter(view: vc,
                                               router: router)
        vc.presenter = presenter
        router.view = vc
        router.nav = navController
        return navController
    }
}

