//
//  STWwaterfallLayout.swift
//  STPageView
//
//  Created by xiudou on 2016/12/5.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

// MARK:- 定义数据源
public protocol STWaterfallLayoutDataSource : class {
    
    /// 返回多少列
    func numberOfCols(_ stWaterfallLayout : STWaterfallLayout)->Int
    
    /// 每一个item的高度
    func heightOfItem(_ stWaterfallLayout : STWaterfallLayout, indexPath : IndexPath, itemWidth : CGFloat)->CGFloat
}

public class STWaterfallLayout: UICollectionViewFlowLayout {
    
    // MARK:- 变量
    fileprivate var startIndex : Int = 0
    /// 列数
    weak var dataSource : STWaterfallLayoutDataSource?
    /// 所有列的高
    fileprivate lazy var totleHeightArray : [CGFloat] = Array(repeating: self.sectionInset.top, count: self.column)
    /// 记录当前itemCount个数
    fileprivate var currentCount = 0
    // MARK:- 懒加载
    fileprivate lazy var layoutAttributeArray : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    fileprivate lazy var column : Int = 2
        
//        return self.dataSource?.numberOfCols(self) ?? 2
        
//    }()
    
    
}

// MARK:- 初始准备工作
public extension STWaterfallLayout {
    
    override func prepare() {
        super.prepare()
        // 获取所有的item 默认只有一部分
        guard let count = collectionView?.numberOfItems(inSection: 0) else { return }

        // 判断上拉加载更多和下拉刷新对数据的处理
        if startIndex > count{
            startIndex = 0
            layoutAttributeArray.removeAll()
            totleHeightArray = Array(repeating: self.sectionInset.top, count: self.column)
        }
        
        // 设置尺寸
        let itemWidth : CGFloat = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - CGFloat(column - 1) * minimumInteritemSpacing) / CGFloat(column)
        
        for index in startIndex..<count{
            // 创建indexpath
            let indexPath = IndexPath(item: index, section: 0)
            
            // 创建一个layoutAttribute
            let layoutAttribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 获取行高
            let itemHeight = dataSource?.heightOfItem(self, indexPath: indexPath, itemWidth: itemWidth) ?? 100
            
            // 在找出每一列最短的那一列的高度
            guard let mincolumnHeight = totleHeightArray.min() else { return }
            
            // 取出最短列号
            guard let minColumn = totleHeightArray.index(of: mincolumnHeight) else { return }
            
            // item的X值
            let item_x : CGFloat = sectionInset.left + CGFloat(minColumn) * (itemWidth + minimumInteritemSpacing)
            
            // item的Y值(这里不需要再次加minimumLineSpacing,因为系统已经帮添加过)
            let item_y : CGFloat = mincolumnHeight
            
            // 设置item的Frame
            layoutAttribute.frame = CGRect(x: item_x, y: item_y, width: itemWidth, height: itemHeight)
            
            // 把计算好的item添加到数组中
            layoutAttributeArray.append(layoutAttribute)
            
            // 记录当前列最新的高度保存一下
            totleHeightArray[minColumn] = mincolumnHeight + minimumLineSpacing + itemHeight
            
            
        }
        // 记录开始的index
        startIndex = count
    }
}

// MARK:- 设置滚动区域
public extension STWaterfallLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return layoutAttributeArray
    }
}

// MARK:- 返回所有要显示的item
public extension STWaterfallLayout {
    
    override var collectionViewContentSize : CGSize {
        
        guard let lastItem = layoutAttributeArray.last else { return CGSize.zero }
        
        return CGSize(width: 0, height: lastItem.frame.maxY + sectionInset.bottom)
    }
}
