//
//  FlickerSearchPresenter.swift
//  Flicker
//
//  Created by Rahul Shivuni on 11/18/18.
//  Copyright © 2018 Rahul Shivuni. All rights reserved.
//

import Foundation

protocol FlickerSearchPresenting: class {
    func numberOfRows() -> Int
    func numberOfSections() -> Int
    func viewModel(forRow row: Int) -> ViewModel
    func screenDidLoad()
    func searchValue(with text: String)
}

final class FlickerSearchPresenter: FlickerSearchPresenting {
    
    private let router: FlickerSearchRouting
    private weak var view: FlickerSearchDisplaying!
    private let serviceInteractor: FlickerSearchServiceInteracting
    private var flickerDetails: [PictureInfo]
    
    init(view: FlickerSearchDisplaying,
         router: FlickerSearchRouting,
         serviceInteractor: FlickerSearchServiceInteracting = FlickerSearchServiceInteractor(),
         flickerDetails: [PictureInfo] = []) {
        self.view = view
        self.router = router
        self.serviceInteractor = serviceInteractor
        self.flickerDetails = flickerDetails
        self.serviceInteractor.observer = self
    }
    
    func screenDidLoad() {
    }
    
    func numberOfRows() -> Int {
        return flickerDetails.count
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func viewModel(forRow row: Int) -> ViewModel {
        return PictureInfoViewModel(model: flickerDetails[row])
    }
    
    func searchValue(with text: String) {
        if !text.isEmpty {
            serviceInteractor.fetchResults(searchText: text)
            view.reloadTableView()
        }
    }
    
}

extension FlickerSearchPresenter: FlickerSearchResultObserving {
    func flickerServiceSucceded(_ details: PictureDetails) {
        self.flickerDetails = details.photo ?? [PictureInfo]()
        view.reloadTableView()
        
    }
    
    func flickerServiceFailed() {
        
    }
    
    
}


