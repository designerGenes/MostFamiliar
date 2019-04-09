//
//  SpineViewController.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/9/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//


// this controller lives beneath the others and is used
// for custom transitions such as the side cabinet
import UIKit

@objc protocol SideCabinetHostDelegate: class {
    func didSetCabinetOpen(cabinetHost: HostsSideCabinet, isOpen: Bool)
}

@objc protocol HostsSideCabinet: class {
    func toggleCabinetOpen()
    func setCabinetOpen(shouldOpen: Bool)
    func getCabinetIsOpen() -> Bool
}

class SpineViewController: UIViewController, HostsSideCabinet {
    private var centerViewController: UIViewController!
    private var sideCabinetController: SideCabinetController?
    private var hazeView = UIControl()
    private var snapShotView: UIImageView?
    private static let animationTransitionTime: Double = 0.35
    weak public var delegate: SideCabinetHostDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let centerInnerVC = Bundle.main.loadNibNamed("ExamplesTableViewController", owner: self, options: nil)?.first as! ExamplesTableViewController
    
        centerInnerVC.delegate = self
        delegate = centerInnerVC
        centerViewController = UINavigationController(rootViewController: centerInnerVC)
        
        view.addSubview(centerViewController.view)
        view.backgroundColor = .bgroundGray()
        addChild(centerViewController)
        centerViewController.didMove(toParent: self)
        
    }
    
    override func viewDidLayoutSubviews() {
        hazeView.frame = UIScreen.main.bounds
    }
    
    // MARK: - HostsSideCabinet methods
    func getCabinetIsOpen() -> Bool {
        return sideCabinetController?.state == SideCabinetController.CabinetState.open
    }

    public func toggleCabinetOpen() {
        let isOpen = getCabinetIsOpen()
        animateCabinetOpen(shouldOpen: !isOpen)
        setCabinetOpen(shouldOpen: !isOpen)
    }
    
    public func setCabinetOpen(shouldOpen: Bool) {
        guard getCabinetIsOpen() == !shouldOpen else {
            return
        }
        
        addCabinetVC()
        sideCabinetController?.state = shouldOpen ? .open : .closed
        
        animateCabinetOpen(shouldOpen: shouldOpen)
        delegate?.didSetCabinetOpen(cabinetHost: self, isOpen: shouldOpen)
        sideCabinetController?.state = shouldOpen ? SideCabinetController.CabinetState.open : .closed
    }
    
    @objc private func tappedHaze(sender: NSObject) {
        animateCabinetOpen(shouldOpen: false)
    }
    
    private func animateCabinetOpen(shouldOpen: Bool) {
        guard let sideCabinetController = sideCabinetController, let sideCabinetView = sideCabinetController.view, let centerView = centerViewController.view else {
            return
        }
        
        let offset: CGFloat = shouldOpen ? UIScreen.main.bounds.width * 0.6 : 0
        let zOffset: CGFloat = shouldOpen ? 0.8 : 1
        let anchorPoint = CGPoint(x: shouldOpen ? 1 : 0.5, y: 0.5)
        // animate haze
        if shouldOpen {
            hazeView = UIControl()
            view.coverSelfEntirely(with: hazeView)  // make sure it stays on top
            hazeView.backgroundColor = UIColor.lightPurple()
            hazeView.addTarget(self, action: #selector(tappedHaze(sender:)), for: .touchUpInside)
            hazeView.alpha = 0
        }
        
        var centerCoverView: UIView?
        if shouldOpen {
            view.bringSubviewToFront(sideCabinetView)
            
            let snapShotView = UIImageView(image: centerView.takeScreenShot())
            self.snapShotView = snapShotView
            
            centerCoverView = UIView()
            centerCoverView!.backgroundColor = UIColor.bgroundGray()
            
            centerView.coverSelfEntirely(with: centerCoverView!)
            centerView.coverSelfEntirely(with: snapShotView)
        }

        // this is ugly code written in a hurry
        UIView.animate(withDuration: SpineViewController.animationTransitionTime, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.hazeView.alpha = shouldOpen ? 0.4 : 0
            sideCabinetView.transform = CGAffineTransform.identity.translatedBy(x: offset, y: 0)
            if let snapShotView = self.snapShotView {
                centerView.transform = CGAffineTransform.identity.translatedBy(x: offset, y: 0)
                
                snapShotView.transform = CGAffineTransform.identity.scaledBy(x: zOffset, y: zOffset)
                
                
            }
            
        }, completion: { (done) in
            if done == true && shouldOpen == false {
                self.hazeView.removeFromSuperview()
                centerView.subviews[centerView.subviews.count - 2].removeFromSuperview()
                self.sideCabinetController?.removeFromParent()
                self.sideCabinetController = nil
                self.snapShotView?.removeFromSuperview()
                self.snapShotView = nil
            }
        })
    }
    
    
    
    private func addCabinetVC() {
        guard sideCabinetController == nil else {
            return
        }
        let sideCabinetController = SideCabinetController()
        self.sideCabinetController = sideCabinetController
        sideCabinetController.delegate = self
        view.addSubview(sideCabinetController.view)
        addChild(sideCabinetController)
        sideCabinetController.didMove(toParent: self)
        sideCabinetController.view.frame = CGRect(origin: CGPoint(x: -UIScreen.main.bounds.width, y: 0), size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }

}
