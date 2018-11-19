//
//  PictureInfoViewModel.swift
//  Flicker
//
//  Created by Rahul Shivuni on 11/18/18.
//  Copyright © 2018 Rahul Shivuni. All rights reserved.
//

import Foundation

final class PictureInfoViewModel: ViewModel {
    private let model: PictureInfo
    
    init(model: PictureInfo) {
        self.model = model
    }
    
    lazy var title: String =  {
        guard let title = self.model.title else {
            return "Unknown"
        }
        return title == "" ? "Unknown" : title.capitalized
    }()
    
    lazy var imageData: Data? = {
        var data: Data?
        guard let url = self.model.url_s else {
            return nil
        }
        let imageUrl = URL(string: url)
        DispatchQueue.global().async {
            data = try? Data(contentsOf: imageUrl!)
        }
        return data
    }()
}
