//
//  TestCell.swift
//  testCollectionView
//
//  Created by xiudou on 2016/12/5.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
import SDWebImage
class TestCell: UICollectionViewCell {
    
    // MARK:- 懒加载
    private lazy var iconImageView : UIImageView = {
       
        let iconImageView = UIImageView()
        
        
        return iconImageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconImageView)
        
    }
    
    var testModel : TestItem?{
        
        didSet{
            
            iconImageView.sd_setImageWithURL(NSURL(string: testModel?.img ?? ""), placeholderImage: UIImage(named: "QQ"))
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.frame = bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
