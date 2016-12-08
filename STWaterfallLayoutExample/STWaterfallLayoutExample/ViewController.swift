//
//  ViewController.swift
//  STWaterfallLayoutExample
//
//  Created by xiudou on 2016/12/6.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
import MJRefresh
import MJExtension
//import STWaterfallLayout

private let collectionViewCellIdentifier = "collectionViewCellIdentifier"

class ViewController: UIViewController {
    
    lazy var dataArray : [TestItem] = [TestItem]()
    
    lazy var collectionView : UICollectionView = {
        
        let layout = STWaterfallLayout()
        layout.dataSource = self
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 30
        
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.dataSource = self
        collectionView.registerClass(TestCell.self, forCellWithReuseIdentifier: collectionViewCellIdentifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tempArray = TestItem.mj_objectArrayWithFilename("1.plist")
        for item in tempArray!{
            
            dataArray.append(item as! TestItem)
        }
        
        collectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "headRefreshing")
        collectionView.mj_footer = MJRefreshBackFooter(refreshingTarget: self, refreshingAction: "loadMoreData")
        view.addSubview(collectionView)
        
    }
    
    // 下拉刷新
    func headRefreshing(){
        
        dataArray.removeAll()
        let tempArray = TestItem.mj_objectArrayWithFilename("1.plist")
        for item in tempArray!{
            
            dataArray.append(item as! TestItem)
        }
        collectionView.reloadData()
        collectionView.mj_header.endRefreshing()
    }
    
    // 加载更多
    func loadMoreData(){
        let tempArray = TestItem.mj_objectArrayWithFilename("1.plist")
        for item in tempArray!{
            
            dataArray.append(item as! TestItem)
        }
        collectionView.reloadData()
        collectionView.mj_footer.endRefreshing()
    }
    
    
}

extension ViewController : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionViewCellIdentifier, forIndexPath: indexPath) as! TestCell
        cell.backgroundColor = UIColor.redColor()
        cell.testModel = dataArray[indexPath.item]
        return cell
    }
}

extension ViewController : STWaterfallLayoutDataSource {
    
    func numberOfCols(stWaterfallLayout: STWaterfallLayout) -> Int {
        
        return 3
    }
    
    func heightOfItem(stWaterfallLayout: STWaterfallLayout, indexPath: NSIndexPath, itemWidth: CGFloat) -> CGFloat {
        
        let item = dataArray[indexPath.item]
        let h = item.h * itemWidth / item.w
        
        return h
    }
}






