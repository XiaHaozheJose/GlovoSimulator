//
//  JS_PresentAnimation.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/7/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

class PresentAnimationDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    weak var cell: UITableViewCell?
    var cellFrame: CGRect = CGRect.zero
    var presentingVC: JS_MenuViewController?
    func animationWith(presented: UIViewController, presenting: UIViewController, cell: UITableViewCell, cellFrame: CGRect, complete: ((Bool)-> Void)?) {
        self.cell = cell
        self.cellFrame = cellFrame
        presenting.transitioningDelegate = self
        self.presentingVC = presenting as? JS_MenuViewController
        presented.present(presenting, animated: true) {
            complete?(true)
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation.init(presentType: .presenting, cell: self.cell!, cellFrame: self.cellFrame)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation.init(presentType: .presented, cell: self.cell!, cellFrame: self.cellFrame)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        //        return self.presentingVC!.test
        return nil
        
    }
}

class PresentAnimation: NSObject {
    
    enum PresentAnimationType {
        case presented, presenting
    }
    
    weak var cell: UITableViewCell!
    
    //MARK: - 属性
    let presentType: PresentAnimationType
    let cellFrame: CGRect
    //MARK: - 构造方法
    init(presentType: PresentAnimationType, cell: UITableViewCell, cellFrame: CGRect) {
        self.presentType = presentType
        self.cellFrame = cellFrame
        self.cell = cell
        super.init()
    }
}

//MARK: - 转场动画代理
extension PresentAnimation: UIViewControllerAnimatedTransitioning {
    
    var timeInterval: TimeInterval {
        return 1
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return timeInterval
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.presentType {
        case .presenting:
            self.presenting(transitionContext)
        case .presented:
            self.presented(transitionContext)
        }
    }
    
    fileprivate func presenting(_ transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from) as? JS_HomeController
        let toVC = transitionContext.viewController(forKey: .to) as? JS_MenuViewController
        
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        
        guard fromVC != nil, toVC != nil else {
            return
        }
        
        guard fromView != nil, toView != nil else {
            return
        }
        let animationView = transitionContext.containerView
        
        // 2.添加toView
        animationView.addSubview(toView!)
        guard let selectCell = fromVC!.selectedCell else{ return }
        // 3.toView动画前frame
        let rect = selectCell.contentImageView.convert(self.cell.frame, to: fromView!)
        toVC!.view.frame = rect
        
        // 4.开始动画
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
            self.cell.contentView.isHidden = true
            animationView.layoutIfNeeded()
            toVC!.view.frame = CGRect.init(x: 30, y: 60, width: fromView!.frame.width - 60, height: fromView!.frame.height - 120)
        }) { (finish) in
            UIView.animate(withDuration: self.timeInterval - 0.3, delay: 0, options: [.curveLinear], animations: {
                animationView.layoutIfNeeded()
                toVC!.view.frame = fromView!.frame
                toVC!.view.layer.cornerRadius = 0.0
                toVC!.view.layer.masksToBounds = true
            }, completion: { (finish) in
                self.cell.contentView.isHidden = false
                if finish && !transitionContext.transitionWasCancelled
                {
                    transitionContext.completeTransition(true)
                }
                else
                {
                    toView!.removeFromSuperview()
                    fromView!.isHidden = false
                    transitionContext.completeTransition(false)
                }
            })
        }
    }
    
    fileprivate func presented(_ transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from) as? JS_MenuViewController
        let toVC = transitionContext.viewController(forKey: .to) as? JS_HomeController
        
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        
        guard fromVC != nil, toVC != nil else {
            return
        }
        
        guard fromView != nil, toView != nil else {
            return
        }
        
        let animationView = transitionContext.containerView
        toView?.frame = animationView.convert(fromView!.frame, from: fromView!.superview!)
        animationView.addSubview(toView!)
        animationView.bringSubviewToFront(fromView!)
        //
        ////        // 3.toView动画前frame
        let rect = self.cellFrame
        self.cell.alpha = 0.0
        fromVC!.view.alpha = 0.0
        fromView?.backgroundColor = UIColor.clear
        UIView.animate(withDuration: self.timeInterval - 0.3, delay: 0, options: [.curveLinear], animations: {
            animationView.layoutIfNeeded()
            fromVC!.view.frame = rect
            fromVC!.menuImageView.frame = CGRect.init(x: 0, y: 0, width: rect.width, height: rect.height)
            fromVC?.menuTableView.alpha = 0.0
        }, completion: { (finish) in
            if finish && !transitionContext.transitionWasCancelled
            {
                transitionContext.completeTransition(true)
            }
            else
            {
                toView!.removeFromSuperview()
                fromView!.isHidden = false
                transitionContext.completeTransition(false)
            }
            self.cell.alpha = 1.0
        })
    }
    
}

class InteractiveAnimator: UIPercentDrivenInteractiveTransition {
    
}
