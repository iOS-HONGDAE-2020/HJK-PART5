//
//  RatingView.swift
//  TheMovie
//
//  Created by 오디언 on 2020/10/08.
//  Copyright © 2020 김호종. All rights reserved.
//

import UIKit

@IBDesignable
class RatingView: UIView {
    @IBOutlet var starImage: [UIImageView]!
    
    var rateValue: Double = 0.0
    @IBInspectable var rate: Double {
        get { return rateValue }
        set(value) {
            let correctValue: Double
            if value < 0 { correctValue = 0 }
            else if value > 10.0 { correctValue = 10.0 }
            else { correctValue = value }
            
            rateValue = correctValue
            
            if starImage == nil { return }
            
            starImage.forEach({$0.image = UIImage(named: "ic_star_large")})
            
            if correctValue >= 1, correctValue < 2 {
                starImage[0].image = UIImage(named: "ic_star_large_half")
            } else if correctValue >= 2, correctValue < 3 {
                starImage[0].image = UIImage(named: "ic_star_large_full")
            } else if correctValue >= 3, correctValue < 4 {
                starImage[0].image = UIImage(named: "ic_star_large_full")
                starImage[1].image = UIImage(named: "ic_star_large_half")
            } else if correctValue >= 4, correctValue < 5 {
                starImage[0].image = UIImage(named: "ic_star_large_full")
                starImage[1].image = UIImage(named: "ic_star_large_full")
            } else if correctValue >= 5, correctValue < 6 {
                starImage[0].image = UIImage(named: "ic_star_large_full")
                starImage[1].image = UIImage(named: "ic_star_large_full")
                starImage[2].image = UIImage(named: "ic_star_large_half")
            } else if correctValue >= 6, correctValue < 7 {
                starImage[0].image = UIImage(named: "ic_star_large_full")
                starImage[1].image = UIImage(named: "ic_star_large_full")
                starImage[2].image = UIImage(named: "ic_star_large_full")
            } else if correctValue >= 7, correctValue < 8 {
                starImage[0].image = UIImage(named: "ic_star_large_full")
                starImage[1].image = UIImage(named: "ic_star_large_full")
                starImage[2].image = UIImage(named: "ic_star_large_full")
                starImage[3].image = UIImage(named: "ic_star_large_half")
            } else if correctValue >= 8, correctValue < 9 {
                starImage[0].image = UIImage(named: "ic_star_large_full")
                starImage[1].image = UIImage(named: "ic_star_large_full")
                starImage[2].image = UIImage(named: "ic_star_large_full")
                starImage[3].image = UIImage(named: "ic_star_large_full")
            } else if correctValue >= 9, correctValue < 10 {
                starImage[0].image = UIImage(named: "ic_star_large_full")
                starImage[1].image = UIImage(named: "ic_star_large_full")
                starImage[2].image = UIImage(named: "ic_star_large_full")
                starImage[3].image = UIImage(named: "ic_star_large_full")
                starImage[4].image = UIImage(named: "ic_star_large_half")
            } else if correctValue >= 10 {
                starImage[0].image = UIImage(named: "ic_star_large_full")
                starImage[1].image = UIImage(named: "ic_star_large_full")
                starImage[2].image = UIImage(named: "ic_star_large_full")
                starImage[3].image = UIImage(named: "ic_star_large_full")
                starImage[4].image = UIImage(named: "ic_star_large_full")
            }
        }
    }
    
    let nibName = "RatingView"
    var contentView:UIView?
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }

        func commonInit() {
            guard let view = loadViewFromNib() else { return }
            view.frame = self.bounds
            self.addSubview(view)
            contentView = view
        }

        func loadViewFromNib() -> UIView? {
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: nibName, bundle: bundle)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }
}
