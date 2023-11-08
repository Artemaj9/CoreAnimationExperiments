//
//  ViewController.swift
//  CoreAnimationBasic
//
//  Created by Artem on 08.11.2023.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    lazy var layer: CALayer = {
        let layer = CALayer()
        layer.frame = CGRectMake(0, 0, 100, 100)
        layer.position = self.view.center
        layer.backgroundColor = UIColor.red.cgColor
        return layer
    }()
    
    var timer: Timer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        view.layer.addSublayer(layer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(sender:))))
        
    }
    
    @objc func tap(sender: UITapGestureRecognizer) {
        // Implicit animation
        /*
        layer.backgroundColor = UIColor.blue.cgColor
        layer.frame = CGRectMake(10, 10, 80, 80)
        */
        
        let anim = CABasicAnimation(keyPath: "backgroundColor")
        anim.fromValue = UIColor.darkGray.cgColor
        anim.toValue = UIColor.green.cgColor
        anim.repeatCount = 10
        anim.duration = 1.5
        anim.autoreverses =  true
        layer.add(anim, forKey: "colorAnimation")
        
        layer.backgroundColor = (anim.fromValue as! CGColor)
        
        let posAnim = CABasicAnimation(keyPath: "position.x")
        posAnim.fromValue = layer.bounds.width / 2
        posAnim.toValue = view.frame.size.width - layer.bounds.size.width / 2
        posAnim.duration = anim.duration
        posAnim.repeatCount = 3
        posAnim.autoreverses =  true
        posAnim.delegate = self
        posAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        layer.add(posAnim, forKey: "position.x")
        
        timer = Timer.scheduledTimer(timeInterval: 0.25,
                                     target: self,
                                     selector: #selector(tick),
                                     userInfo: nil,
                                     repeats: true)
    }
    
   @objc func tick() {
        print("x: \(layer.position.x)")
    }
    
    
    private func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        timer?.invalidate()
        
    }
}

