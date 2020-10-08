//
//  PosterViewController.swift
//  TheMovie
//
//  Created by 오디언 on 2020/10/08.
//  Copyright © 2020 김호종. All rights reserved.
//

import UIKit

class PosterViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var posterImageView: UIImageView!
    var posterImage: UIImage?
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        posterImageView.image = posterImage
        
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
        scrollView.delegate = self
        
        let scrollViewTap = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        scrollView.addGestureRecognizer(scrollViewTap)
    }
    
    @objc func scrollViewTapped() {
        dismiss(animated: true)
    }

    
    @available(iOS 2.0, *)
        public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return self.posterImageView
        }

}
