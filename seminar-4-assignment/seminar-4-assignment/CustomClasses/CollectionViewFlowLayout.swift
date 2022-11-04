//
//  CollectionViewFlowLayout.swift
//  seminar-3-assignment
//
//  Created by 최성혁 on 2022/10/08.
//

import Foundation
import UIKit

class CollectionViewFlowLayout : UICollectionViewFlowLayout {
    override init() {
        super.init()
        
        self.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        self.minimumLineSpacing = 5 //셀들 사이 수직 공간
        self.minimumInteritemSpacing = 5 //셀들 사이 수평 공간
        
        let width = CGFloat((UIScreen.main.bounds.width - 50 - self.minimumInteritemSpacing)/2)
        let height = CGFloat(300)
        self.itemSize = CGSize(width: width, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
