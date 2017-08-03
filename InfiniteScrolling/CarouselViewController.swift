//
//  CarouselViewController.swift
//  InfiniteScrolling
//
//  Created by Kevin Chan on 8/3/17.
//  Copyright © 2017 Kevin Chan. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController, iCarouselDelegate, iCarouselDataSource {
    
    var carouselCollectionView: iCarousel!
    var array: [String] = ["Brunch", "Cafes", "Pizza", "Seafood", "Mexican", "Sushi",
                           "Noodles", "Happy Hour", "Ask Me Anything"]
    var getRecoButton: UIButton!
    var recoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Carousel"
        
        view.backgroundColor = .white
        
        carouselCollectionView = iCarousel(frame: CGRect(x: 0, y: view.frame.height*0.3, width: view.frame.width, height: view.frame.height*0.4))
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        carouselCollectionView.type = iCarouselType.cylinder
        view.addSubview(carouselCollectionView)
        
        getRecoButton = UIButton(frame: CGRect(x: 0, y: carouselCollectionView.frame.origin.y + carouselCollectionView.frame.height + 30, width: view.frame.width*0.4, height: view.frame.height*0.1))
        getRecoButton.center = CGPoint(x: view.frame.width/2, y: getRecoButton.center.y)
        getRecoButton.setTitle("Get A Reco", for: .normal)
        getRecoButton.backgroundColor = .red
        getRecoButton.layer.cornerRadius = 5
        getRecoButton.addTarget(self, action: #selector(getReco), for: .touchUpInside)
        view.addSubview(getRecoButton)
        
        recoLabel = UILabel(frame: CGRect(x: 0, y: view.frame.height*0.15, width: view.frame.width, height: view.frame.height*0.1))
        recoLabel.text = "Looking Reco For: "
        recoLabel.center = CGPoint(x: view.frame.width/2, y: recoLabel.center.y)
        recoLabel.textAlignment = .center
        view.addSubview(recoLabel)
        
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return array.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let carouselView = CarouselView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        carouselView.title = array[index]
        
        return carouselView
    }
 
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        if option == iCarouselOption.spacing {
            return value * 1.05
        }
        
        return value
    }
    
    func getReco() {
        
        if let currentCarouselView = carouselCollectionView.currentItemView as? CarouselView {
            if let currentItem = currentCarouselView.title {
                recoLabel.text = "Looking Reco For: \(currentItem)"
            }
        }
        
    }
    
    
    
}
