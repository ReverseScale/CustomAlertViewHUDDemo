//
//  AlertHUDTransitioner.swift
//  CustomAlertViewHUDDemo
//
//  Created by WhatsXie on 2017/9/15.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

import UIKit
import QuartzCore

class CAVTransitioner : NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController)
        -> UIPresentationController? {
            return HUDPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

class HUDPresentationController : UIPresentationController {
    
    func decorateView(_ v:UIView) {
        v.layer.cornerRadius = 8
        
        let movenow = UIInterpolatingMotionEffect(keyPath:"center.x", type:.tiltAlongHorizontalAxis)
        movenow.maximumRelativeValue = 10.0
        movenow.minimumRelativeValue = -10.0
        
        let movelast = UIInterpolatingMotionEffect(keyPath:"center.y", type:.tiltAlongVerticalAxis)
        movelast.maximumRelativeValue = 10.0
        movelast.minimumRelativeValue = -10.0
        
        let groupEffect = UIMotionEffectGroup()
        groupEffect.motionEffects = [movenow,movelast]
        v.addMotionEffect(groupEffect)
    }
    
    override func presentationTransitionWillBegin() {
        self.decorateView(self.presentedView!)
        let nowViewController = self.presentingViewController
        let v = nowViewController.view!
        let nowContainerView = self.containerView!
        let shadow = UIView(frame:nowContainerView.bounds)
        shadow.backgroundColor = UIColor(white:0, alpha:0.4)
        shadow.alpha = 0
        nowContainerView.insertSubview(shadow, at: 0)
        shadow.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let nowTransitionCoordinator = nowViewController.transitionCoordinator!
        nowTransitionCoordinator.animate(alongsideTransition: { _ in
            shadow.alpha = 1
        }) { _ in
            v.tintAdjustmentMode = .dimmed
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let nowPresentViewController = self.presentingViewController
        let presentView = nowPresentViewController.view!
        let nowContainerView = self.containerView!
        let shadow = nowContainerView.subviews[0]
        let nowTransitionCoordinator = nowPresentViewController.transitionCoordinator!
        nowTransitionCoordinator.animate(alongsideTransition: { _ in
            shadow.alpha = 0
        }) { _ in
            presentView.tintAdjustmentMode = .automatic
        }
    }
    
    override var frameOfPresentedViewInContainerView : CGRect {
        let nowPresentedView = self.presentedView!
        let nowcontainerView = self.containerView!
        nowPresentedView.center = CGPoint(x: nowcontainerView.bounds.midX, y: nowcontainerView.bounds.midY)
        return nowPresentedView.frame.integral
    }
    
    override func containerViewWillLayoutSubviews() {
        let nowPresentedView = self.presentedView!
        nowPresentedView.autoresizingMask = [
            .flexibleTopMargin, .flexibleBottomMargin,
            .flexibleLeftMargin, .flexibleRightMargin
        ]
        nowPresentedView.translatesAutoresizingMaskIntoConstraints = true
    }
    
}
// UIViewControllerTransitioningDelegate
extension CAVTransitioner {
    func animationController(
        forPresented presented:UIViewController,
        presenting: UIViewController,
        source: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return self
    }
    
    func animationController(
        forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return self
    }
}

extension CAVTransitioner : UIViewControllerAnimatedTransitioning {
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?)
        -> TimeInterval {
            return 0.25
    }
    
    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning) {
        
        let nowContainerView = transitionContext.containerView
        
        let viewNow = transitionContext.view(forKey: .from)
        let viewLast = transitionContext.view(forKey: .to)
        
        // presenting and dismissing
        if let viewNow = viewLast {
            nowContainerView.addSubview(viewNow)
            let scale = CGAffineTransform(scaleX: 1.6, y: 1.6)
            viewNow.transform = scale
            viewNow.alpha = 0
            UIView.animate(withDuration: 0.25, animations: {
                viewNow.alpha = 1
                viewNow.transform = .identity
            }) { _ in
                transitionContext.completeTransition(true)
            }
        } else if let viewLast = viewNow {
            UIView.animate(withDuration: 0.25, animations: {
                viewLast.alpha = 0
            }) { _ in
                transitionContext.completeTransition(true)
            }
        }
        
    }
    
}
