//
//  Factories.swift
//  Spotify
//
//  Created by Terry Jason on 2023/12/3.
//

import Foundation
import UIKit

// MARK: - UIColor

extension UIColor {
    static let spotifyGreen = UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1.0)
    static let spotifyBlack = UIColor(red: 12/255, green: 12/255, blue: 12/255, alpha: 1.0)
}

// MARK: - UIFont

extension UIFont {
    
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
    
}

// MARK: - UIViewController

extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
}

