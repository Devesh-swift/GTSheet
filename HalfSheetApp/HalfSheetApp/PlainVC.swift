//
//  PlainVC.swift
//  HalfSheetApp
//
//  Created by Matt Banach on 9/22/17.
//  Copyright © 2017 Gametime. All rights reserved.
//

import UIKit
import GTSheet

class PlainVC: UIViewController, HalfSheetPresentableProtocol, HalfSheetTopVCProviderProtocol {

    var topVCTransitionStyle: HalfSheetTopVCTransitionStyle {
        return .slide
    }

    lazy var topVC: UIViewController = {
        return DismissBarVC.instance(tintColor: .white)
    }()

    var sheetHeight: CGFloat? = 250.0

    var managedScrollView: UIScrollView? {
        return nil
    }

    var dismissMethod: [DismissMethod] {
        return [.tap, .swipe]
    }

    @IBAction func becomeLarger() {
        sheetHeight = (sheetHeight ?? 0.0) + 30.0
        didUpdateSheetHeight()
    }

    @IBAction func becomeSmaller() {
        sheetHeight = (sheetHeight ?? 0.0) - 30.0
        didUpdateSheetHeight()
    }

    @IBAction func dismiss() {
        dismiss(animated: true)
    }
}

extension PlainVC: HalfSheetAppearanceProtocol {
    var cornerRadius: CGFloat {
        return 8.0
    }
}

class HatParentVC: UIViewController, HalfSheetTopVCProviderProtocol {

    lazy var topVC: UIViewController = {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HatVC")
    }()

    var topVCTransitionStyle: HalfSheetTopVCTransitionStyle = .slide

    @IBAction func dismiss() {
        dismiss(animated: true)
    }
}

class InputVC: UIViewController, HalfSheetPresentableProtocol, HalfSheetTopVCProviderProtocol {

    var topVCTransitionStyle: HalfSheetTopVCTransitionStyle {
        return .slide
    }

    lazy var topVC: UIViewController = {
        return DismissBarVC.instance(tintColor: .white)
    }()

    private var isKeyboardUp = false {
        didSet {
            let keyboardHeight: CGFloat = isKeyboardUp ? 300.0 : 0.0
            sheetHeight = 250.0 + keyboardHeight
            didUpdateSheetHeight()
        }
    }

    @IBOutlet weak var textField: UITextField?

    var sheetHeight: CGFloat? = 250.0

    var managedScrollView: UIScrollView? {
        return nil
    }

    var dismissMethod: [DismissMethod] {
        return [.tap, .swipe]
    }

    @IBAction func dismiss() {
        dismiss(animated: true)
    }

    @IBAction func editingDidBegin(_ sender: Any) {
        isKeyboardUp = true
    }

    @IBAction func editingDidEnd(_ sender: Any) {
        isKeyboardUp = false
    }
}

class HatVC: UIViewController { }
class ScrollingVC: UITableViewController { }

class ScrollingNC: UINavigationController, HalfSheetTopVCProviderProtocol {

    var topVCTransitionStyle: HalfSheetTopVCTransitionStyle {
        return .slide
    }

    lazy var topVC: UIViewController = {
        return DismissBarVC.instance(tintColor: .white)
    }()
}

extension ScrollingNC: HalfSheetPresentableProtocol {

    var managedScrollView: UIScrollView? {
        return (viewControllers.last as? HalfSheetPresentableProtocol)?.managedScrollView
    }

    var dismissMethod: [DismissMethod] {
        return [.tap, .swipe]
    }

    var sheetHeight: CGFloat? {
        return 396.0
    }
}

extension ScrollingVC: HalfSheetAppearanceProtocol {
    var cornerRadius: CGFloat {
        return 8.0
    }
}

extension ScrollingVC: HalfSheetPresentableProtocol {

    var managedScrollView: UIScrollView? {
        return tableView
    }

    var dismissMethod: [DismissMethod] {
        return [.tap, .swipe]
    }

    var sheetHeight: CGFloat? {
        return nil
    }
}

extension HatParentVC: HalfSheetPresentableProtocol {

    var managedScrollView: UIScrollView? {
        return nil
    }

    var dismissMethod: [DismissMethod] {
        return []
    }

    var sheetHeight: CGFloat? {
        return 250.0
    }
}

