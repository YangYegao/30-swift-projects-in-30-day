//
//  ViewController.swift
//  Day04_Limit Input Text
//
//  Created by 杨业高(外包) on 2018/5/25.
//  Copyright © 2018年 杨业高(外包). All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextViewDelegate {

    var limitedTextView:UITextView!
    var allowInputNumberLabel:UILabel!
    var allowInputNumberLabel_origin_y : CGFloat = 0.0
    let MaxCount : Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        self.initNavigationBar()
        self.initInputField()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(note:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    func initInputField() {
        let naviFrame = self.navigationController?.navigationBar.frame
        let statusBarFrame = UIApplication.shared.statusBarFrame
        let avatarImgView = UIImageView(frame: CGRect(x: 0, y: (naviFrame?.height)!+statusBarFrame.height+10, width: 150, height: 200))
        avatarImgView.image = #imageLiteral(resourceName: "meinv.jpg")
        self.view.addSubview(avatarImgView)
        
        limitedTextView = UITextView(frame:CGRect(x: 160, y: avatarImgView.frame.origin.y, width: self.view.frame.width-150-20, height: 500))
        self.view.addSubview(limitedTextView)
        limitedTextView.delegate = self
        limitedTextView.font = UIFont.systemFont(ofSize: 20)
        limitedTextView.layer.borderColor = UIColor.lightGray.cgColor
        limitedTextView.layer.borderWidth = 1
        
        allowInputNumberLabel = UILabel(frame: CGRect(x: self.view.frame.width-60, y:self.limitedTextView.frame.maxY, width: 50, height: 40))
        self.view.addSubview(allowInputNumberLabel)
        allowInputNumberLabel.text = "\(MaxCount)"
        allowInputNumberLabel.textAlignment = .right
        allowInputNumberLabel_origin_y = allowInputNumberLabel.frame.origin.y
        
    }
    
    
    func initNavigationBar() {
        self.title = "1"
        let rightItem = UIBarButtonItem(title: "next", style: .plain, target: self, action: #selector(nextVC))
        self.navigationItem.rightBarButtonItem = rightItem
        rightItem.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.red
    }

    @objc func nextVC(){
        let next = UIViewController();
        next.title = "2"
        next.view.backgroundColor = UIColor.white
        next.navigationItem.titleView?.tintColor = UIColor.blue
        self.navigationController?.navigationBar.barTintColor = UIColor.cyan
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let currentcharactorCount = (textView.text?.count)!
        if currentcharactorCount >= MaxCount {
            limitedTextView.resignFirstResponder()
        }
        allowInputNumberLabel.text = "\(MaxCount-currentcharactorCount)"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentcharactorCount = (textView.text?.count)!
        if currentcharactorCount >= MaxCount {
            if text == "" {
                return true
            }
            limitedTextView.resignFirstResponder()
            return false
        }
        else{
            //剩余字数
            let remainingCout = MaxCount - currentcharactorCount;
            if text.count > remainingCout {
                //获取第 remaining 个字符的下标
                let index = text.index(text.startIndex, offsetBy: remainingCout)
                //从0截取到index的所有字符串
                let validText = text[..<index]
                textView.text = textView.text + validText
                limitedTextView.resignFirstResponder()
                self.allowInputNumberLabel.text = "0"
                return false
            }
        }
        return true
    }
    
    
    @objc func keyboardWillChangeFrame(note:Notification) {
        let duration = note.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let endFrame = (note.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = endFrame.origin.y
        
        let margin = UIScreen.main.bounds.height - y
        UIView.animate(withDuration: duration) {
            //键盘弹出
            if margin > 0 {
                self.allowInputNumberLabel.frame.origin.y = self.view.frame.maxY - margin - self.allowInputNumberLabel.frame.height
            }
            //键盘收起
            else {
                self.allowInputNumberLabel.frame.origin.y = self.limitedTextView.frame.maxY
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

