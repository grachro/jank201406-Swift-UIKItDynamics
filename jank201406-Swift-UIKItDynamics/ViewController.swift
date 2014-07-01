//
//  ViewController.swift
//  jank201406-Swift-UIKItDynamics
//
//  Created by grachro on 2014/06/29.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var allItems:UIView[] = []
    var animator:UIDynamicAnimator?
    var gravity:UIGravityBehavior?
    var collision: UICollisionBehavior?
    
    override func viewWillAppear(animated: Bool)  {
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //初期化ボタン
        let clearBtn:UIButton =  addClearButton(110,title:"CLEAR" ,targetAction:"clickClear:" );
        
        //左ボタン
        let leftBtn:UIButton =  addButton(10,title:"トマト" ,targetAction:"clickLeft:" );
        
        //中央ボタン
        let centerBtn:UIButton =  addButton(110,title:"なす" ,targetAction:"clickCenter:" );

        //右ボタン
        let rightBtn:UIButton =  addButton(210,title:"キャベツ" ,targetAction:"clickRight:" );
        
        
        //アニメーター
        self.animator = UIDynamicAnimator(referenceView: self.view)
        
        //衝突
        self.collision = UICollisionBehavior(items:nil)
        self.collision!.translatesReferenceBoundsIntoBoundary = true;
        self.collision!.addItem(leftBtn);
        self.collision!.addItem(centerBtn);
        self.collision!.addItem(rightBtn);
        self.animator!.addBehavior(self.collision);
        
        //重力
        self.gravity = UIGravityBehavior(items:nil)
        self.animator!.addBehavior(self.gravity);
    }
    
    
    func addClearButton(x:CGFloat,title:String,targetAction:Selector) -> UIButton{
        let rightBtn:UIButton =  UIButton.buttonWithType(UIButtonType.System) as UIButton;
        rightBtn.frame = CGRectMake(x, 20 , 100, 40);
        rightBtn.setTitle(title , forState:UIControlState.Normal);
        rightBtn.addTarget(self, action:targetAction, forControlEvents:UIControlEvents.TouchUpInside);
        self.view.addSubview(rightBtn);
        return rightBtn
    }
    
    func addButton(x:CGFloat,title:String,targetAction:Selector) -> UIButton{
        let rightBtn:UIButton =  UIButton.buttonWithType(UIButtonType.System) as UIButton;
        rightBtn.frame = CGRectMake(x, 400 , 100, 40);
        rightBtn.setTitle(title , forState:UIControlState.Normal);
        rightBtn.addTarget(self, action:targetAction, forControlEvents:UIControlEvents.TouchUpInside);
        self.view.addSubview(rightBtn);
        return rightBtn
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clickClear(sender: AnyObject) {
        //self.view!.viewWithTag(1)!.removeFromSuperview();

        for item in self.allItems {
            item.removeFromSuperview();
            self.gravity!.removeItem(item);
            self.collision!.removeItem(item);
        }
    }
    
    func clickLeft(sender: AnyObject){
        addItem(10,pngName:"tomato.png");
    }
    
    func clickCenter(sender: AnyObject){
        addItem(110,pngName:"nasu.png");
    }
    
    func clickRight(sender: AnyObject){
        addItem(210,pngName:"kyabetu.png");
    }
    
    func addItem(x:CGFloat,pngName:String){
        let pngImage:UIImage = UIImage(named:pngName)
        let img = UIImageView(image:pngImage);
        img.center = CGPointMake(x, 0);
        img.tag = 1
        
        self.allItems += img;
        self.view!.addSubview(img);
        self.gravity!.addItem(img);
        self.collision!.addItem(img);
    }
}

