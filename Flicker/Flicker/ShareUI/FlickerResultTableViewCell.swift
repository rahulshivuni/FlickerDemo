//
//  FlickerResultTableViewCell.swift
//  Flicker
//
//  Created by Rahul Shivuni on 11/18/18.
//  Copyright © 2018 Rahul Shivuni. All rights reserved.
//

import UIKit

class FlickerResultTableViewCell: UITableViewCell {

    @IBOutlet weak private var flickerTextLabel: UILabel!
    @IBOutlet weak private var contentImageView: UIImageView!
    
    func update(for viewmodel: ViewModel, index: Int) {
        let viewModel = viewmodel as! PictureInfoViewModel
        flickerTextLabel.text = viewModel.title
        guard let imageData = viewModel.imageData else {
            return
        }
        contentImageView.image = UIImage(data: imageData)
    }
    
}
