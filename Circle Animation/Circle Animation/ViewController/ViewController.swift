//
//  ViewController.swift
//  Circle Animation
//
//  Created by Avishek Khan on 4/3/17.
//  Copyright © 2017 framgia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelOceanize: UILabel!
    
    let notificationCenter = NSNotificationCenter.defaultCenter()
    let rectShape = CAShapeLayer()
    var bounds = CGRect()
    var circle: Circle? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
    }
    
    func addObservers() {
        notificationCenter.addObserver(self,
                                       selector:#selector(ViewController.setUpUI),
                                       name:UIApplicationDidBecomeActiveNotification,
                                       object:nil)
        notificationCenter.addObserver(self,
                                       selector:#selector(ViewController.clearUI),
                                       name:UIApplicationWillResignActiveNotification,
                                       object:nil)
    }
    
    func setUpUI() {
        labelOceanize.hidden = true
        
        let bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
        let radius = CGFloat(sqrt(pow(Float(self.view.frame.width), 2) + pow(Float(self.view.frame.height), 2)))
        let duration = CFTimeInterval(1)
        
        var animations = [CABasicAnimation]()
        
        circle = Circle(view: self.view)
        
        if let _circle = circle {
            animations.append(_circle.getPathAnimation(bounds: bounds , endRect: CGRect(x: -radius/2, y: -radius/2, width: radius, height: radius), duration: duration))
            
            animations.append(_circle.getOpacityAnimation(duration: duration))
            
            animations[0].delegate = self
            
            //color code #01C9F1
            _circle.create(bounds).color(color: UIColor(rgb: 0x01C9F1).CGColor).animate(animations: animations)
        }
    }
    
    func clearUI() {
        if let _circle = circle {
            _circle.destroy()
        }
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        showLabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showLabel() {
        labelOceanize.hidden = false
        self.view.layer.addSublayer(labelOceanize.layer)
        
        if let _circle = circle {
            let animationOpacity = _circle.getOpacityAnimation(duration: 1)
            labelOceanize.layer.addAnimation(animationOpacity, forKey: animationOpacity.keyPath)
        }
    }
}
