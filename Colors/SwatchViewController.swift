//
//  SwatchViewController.swift
//  Colors
//
//  Created by Evan Coleman on 11/28/15.
//  Copyright © 2015 Evan Coleman. All rights reserved.
//

import UIKit
import SnapKit

class SwatchViewController: ViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Swatches"
        self.tabBarItem.title = "Swatches"
        self.tabBarItem.image = UIImage(named: "tabbar_swatches_normal")
        
        let flowLayout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "SwatchCell")
        self.view.addSubview(self.collectionView)
        
        self.collectionView.snp_makeConstraints { (make) -> Void in
            let tabBarController = self.tabBarController as! TabBarController
            make.edges.equalTo(UIEdgeInsets(top: tabBarController.navigationBar.frame.maxY, left: 0, bottom: 0, right: 0))
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let viewModel = self.viewModel as! SwatchViewModel
        viewModel.deviceViewModel.setColorAction.apply(viewModel.colors[indexPath.row]).start()
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let viewModel = self.viewModel as! SwatchViewModel
        
        return viewModel.colors.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SwatchCell", forIndexPath: indexPath)
        
        let viewModel = self.viewModel as! SwatchViewModel
        let color = viewModel.colors[indexPath.row]
        cell.backgroundColor = color
        
        return cell
    }
}
