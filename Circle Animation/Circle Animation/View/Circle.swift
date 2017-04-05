//
//  Circle.swift
//  Circle Animation
//
//  Created by Avishek Khan on 4/4/17.
//  Copyright © 2017 framgia. All rights reserved.
//

import UIKit

class Circle {
    let rectShape = CAShapeLayer()
    var bounds = CGRect()
    var view: UIView
    
    init(view: UIView) {
        self.view = view
    }
    
    func create(bounds: CGRect) -> Circle {
        self.bounds = bounds
        rectShape.bounds = bounds
        rectShape.position = view.center
        rectShape.cornerRadius = bounds.width / 2
        view.layer.addSublayer(rectShape)
        
        return self
    }
    
    func destroy() {
        rectShape.removeFromSuperlayer()
    }
    
    func color(color color: CGColor) -> Circle {
        rectShape.fillColor = color
        return self
    }
    
    func animate(endShape endRect: CGRect, duration: CFTimeInterval) {
        let radius = CGFloat(sqrt(pow(Float(view.frame.width), 2) + pow(Float(view.frame.height), 2)))
        var animations = [CABasicAnimation]()
        animations.append(getPathAnimation(bounds: bounds , endRect: CGRect(x: -radius/2, y: -radius/2, width: radius, height: radius), duration: duration))
        
        animations.append(getOpacityAnimation(duration: duration))
        
        animate(animations: animations)
    }
    
    func animate(animations animations: [CABasicAnimation]) {
        for animation in animations {
            rectShape.addAnimation(animation, forKey: animation.keyPath)
        }
    }
    
    func getPathAnimation(bounds bounds: CGRect, endRect: CGRect, duration: CFTimeInterval) -> CABasicAnimation {
        
        let startShape = UIBezierPath(roundedRect: bounds, cornerRadius: 50).CGPath
        let endShape = UIBezierPath(roundedRect: endRect, cornerRadius: 500).CGPath
        
        rectShape.path = startShape
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = endShape
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.fillMode = kCAFillModeBoth
        animation.removedOnCompletion = false
        
        return animation
    }
    
    func getOpacityAnimation(duration duration: CFTimeInterval) -> CABasicAnimation {
        let animationOpacity = CABasicAnimation(keyPath: "opacity")
        animationOpacity.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animationOpacity.duration = duration
        animationOpacity.fromValue = 0
        animationOpacity.toValue = 1
        
        return animationOpacity
    }
}