//
//  ViewController.swift
//  Day07_SimplePhotoBrowser
//
//  Created by 杨业高(外包) on 2018/5/29.
//  Copyright © 2018年 杨业高(外包). All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    var imageView:UIImageView!
    var scrollView:UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView = UIImageView(frame: self.view.bounds)
        imageView.image = UIImage(named: "meinv2.jpeg")
        imageView.isUserInteractionEnabled = true
        
        scrollView = UIScrollView(frame: self.view.frame)
        scrollView.maximumZoomScale = 4.0
        scrollView.minimumZoomScale = 1.0
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = imageView.bounds.size
        scrollView.delegate = self
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

