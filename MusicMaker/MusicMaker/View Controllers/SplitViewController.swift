//
//  SplitViewController.swift
//  MusicMaker
//
//  Created by Linh Bouniol on 12/13/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController {

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super .viewWillTransition(to: size, with: coordinator)
        
        fixLastViewControllerTraits()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        fixLastViewControllerTraits()
    }
    
    override func showDetailViewController(_ vc: UIViewController, sender: Any?) {
        super.showDetailViewController(vc, sender: sender)
        
        fixLastViewControllerTraits()
    }
    
    func fixLastViewControllerTraits() {
        if let lastVC = children.last {
            if lastVC.view.bounds.width < 700 {
                let compactTraitCollection = UITraitCollection(horizontalSizeClass: .compact)
                setOverrideTraitCollection(UITraitCollection(traitsFrom: [lastVC.traitCollection, compactTraitCollection]), forChild: lastVC)
            } else {
                let regularTraitCollection = UITraitCollection(horizontalSizeClass: .regular)
                setOverrideTraitCollection(UITraitCollection(traitsFrom: [lastVC.traitCollection, regularTraitCollection]), forChild: lastVC)
            }
        }
    }

}
