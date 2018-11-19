//
//  FlickerSearchViewController.swift
//  Flicker
//
//  Created by Rahul Shivuni on 11/18/18.
//  Copyright © 2018 Rahul Shivuni. All rights reserved.
//

import Foundation
import UIKit

protocol FlickerSearchDisplaying: class {
    func reloadTableView()
}

class FlickerSearchViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.tableFooterView = UIView(frame: .zero)
            tableView.separatorInset = .zero
            tableView.estimatedRowHeight = 45
        }
    }
    var presenter: FlickerSearchPresenting!
    
    @IBOutlet weak private var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FlickerResultTableViewCell", bundle: nil), forCellReuseIdentifier: "FlickerCell")
        presenter.screenDidLoad()
    }
    
    @IBAction func searchTextValueChanged() {
        presenter.searchValue(with: searchTextField.text ?? "")
    }
    
}

extension FlickerSearchViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlickerCell", for: indexPath) as! FlickerResultTableViewCell
        let viewModel = presenter.viewModel(forRow: indexPath.row)
        cell.update(for: viewModel, index: indexPath.row)
        return cell
    }
}


extension FlickerSearchViewController: FlickerSearchDisplaying{
    func reloadTableView() {
        tableView.reloadData()
    }
}
