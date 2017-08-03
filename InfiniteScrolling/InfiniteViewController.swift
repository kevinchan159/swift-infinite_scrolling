//
//  InfiniteViewController.swift
//  InfiniteScrolling
//
//  Created by Kevin Chan on 8/3/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class InfiniteViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var infiniteCollectionView: UICollectionView!
    var array: [String] = ["Brunch", "Cafes", "Pizza", "Seafood", "Mexican", "Sushi",
                           "Noodles", "Happy Hour", "Ask Me Anything"]
    var didOnce: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Infinite Scrolling CollectionView"
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        infiniteCollectionView = UICollectionView(frame: CGRect(x: 0, y: view.frame.height*0.25, width: view.frame.width, height: view.frame.height*0.5), collectionViewLayout: layout)
        infiniteCollectionView.backgroundColor = UIColor.white
        infiniteCollectionView.delegate = self
        infiniteCollectionView.dataSource = self
        infiniteCollectionView.showsHorizontalScrollIndicator = false
        infiniteCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: "customCellId")
        view.addSubview(infiniteCollectionView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = infiniteCollectionView.dequeueReusableCell(withReuseIdentifier: "customCellId", for: indexPath) as! CustomCell
        let index = indexPath.item % array.count
        cell.title = array[index]
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // a big number
        return 100000
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width*0.6, height: view.frame.height*0.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if ((context.nextFocusedIndexPath != nil) && infiniteCollectionView.isScrollEnabled == false) {
            print("it works")
            infiniteCollectionView.scrollToItem(at: context.nextFocusedIndexPath!, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (didOnce == false) {
            let indexToScrollTo = IndexPath(item: 50000, section: 0)
            infiniteCollectionView.scrollToItem(at: indexToScrollTo, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            didOnce = true
        }
    }
    
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        // look for closest cell 0.5seconds after deceleration begins
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            var closestCell: UICollectionViewCell = self.infiniteCollectionView.visibleCells[0]
            for cell in self.infiniteCollectionView.visibleCells as [UICollectionViewCell] {
                // calculate distance of visible cells from center of collection view
                let closestCellDelta = abs(closestCell.center.x - self.infiniteCollectionView.bounds.size.width/2 - self.infiniteCollectionView.contentOffset.x)
                let cellDelta = abs(cell.center.x - self.infiniteCollectionView.bounds.size.width/2 - self.infiniteCollectionView.contentOffset.x)
                if (cellDelta < closestCellDelta) {
                    closestCell = cell
                }
            }
            // scroll to closest cell
            let indexPathOfClosest = self.infiniteCollectionView.indexPath(for: closestCell)
            self.infiniteCollectionView.scrollToItem(at: indexPathOfClosest!, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }
    }
    
    
    
    
}
