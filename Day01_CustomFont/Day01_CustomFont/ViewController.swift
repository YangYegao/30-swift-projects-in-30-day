//
//  ViewController.swift
//  Day01_CustomFont
//
//  Created by 杨业高(外包) on 2018/5/8.
//  Copyright © 2018年 杨业高(外包). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let label = UILabel(frame: CGRect(x: 20.0, y: 60.0, width: UIScreen.main.bounds.size.width-40.0, height: 300.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = """
        题龙阳县青草湖
         [元·唐温如]

        西风吹老洞庭波，一夜湘君白发多。
        醉后不知天在水，满船清梦压星河。
        """
        label.textAlignment = .center
        label.layer.borderColor = UIColor.red.cgColor
        label.numberOfLines = 0
        label.layer.borderWidth = 2
        label.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(label)
        
        let changeBtn = UIButton(type: .custom)
        changeBtn.frame = CGRect(x: 100.0, y: 500.0, width: UIScreen.main.bounds.size.width-200.0, height: 30.0)
        changeBtn.setTitle("Change Font Family", for: UIControlState.normal)
        changeBtn.setTitleColor(.blue, for: .normal)
        changeBtn.setTitleColor(.gray, for: .highlighted)
        changeBtn.addTarget(self, action: #selector(changeTextFont), for:.touchUpInside)
        changeBtn.layer.borderColor = UIColor.blue.cgColor
        changeBtn.layer.borderWidth = 1
        self.view.addSubview(changeBtn)
    
    }
    
    @objc func changeTextFont(){
        let familyNames = UIFont.familyNames
        let index = arc4random() % UInt32(familyNames.count)
        let selectFamilyName = familyNames[familyNames.index(familyNames.startIndex, offsetBy: Int(index))]
      
        let fontNames = UIFont.fontNames(forFamilyName: selectFamilyName)
        if fontNames.count > 0 {
            let index2 = arc4random() % UInt32(fontNames.count)
            let selectFontName = fontNames[fontNames.index(fontNames.startIndex, offsetBy: Int(index2))]
            label.font = UIFont(name: selectFontName, size: 20)
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

