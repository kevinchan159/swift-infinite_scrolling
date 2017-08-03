//
//  CustomCell.swift
//  InfiniteScrolling
//
//  Created by Kevin Chan on 8/3/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.width*0.3))
        titleLabel.center = CGPoint(x: frame.width/2, y: frame.height/2)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
