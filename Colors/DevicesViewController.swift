//
//  DevicesViewController.swift
//  Colors
//
//  Created by Evan Coleman on 11/28/15.
//  Copyright © 2015 Evan Coleman. All rights reserved.
//

import UIKit
import SnapKit

class DevicesViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Devices"

        let viewModel = self.viewModel as! DevicesViewModel
        
        self.tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "DeviceCell")
        self.view.addSubview(self.tableView)
        
        self.tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(UIEdgeInsetsZero)
        }
        
        viewModel.viewModels.producer
            .startWithNext { [unowned self] _ in
                self.tableView.reloadData()
            }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let viewModel = self.viewModel as! DevicesViewModel
        viewModel.selectDeviceAction.apply(viewModel.viewModels.value[indexPath.row]).start()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let viewModel = self.viewModel as! DevicesViewModel
        return viewModel.viewModels.value.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeviceCell", forIndexPath: indexPath)
        
        let viewModel = self.viewModel as! DevicesViewModel
        let deviceViewModel = viewModel.viewModels.value[indexPath.row]
        
        cell.textLabel?.text = deviceViewModel.name
        cell.textLabel?.textColor = (viewModel.selectedDeviceViewModel.value === deviceViewModel) ? UIColor.redColor() : UIColor.blackColor()
        
        return cell
    }
}
