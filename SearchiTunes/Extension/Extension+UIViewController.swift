//
//  Extension+UIViewController.swift
//  SearchiTunes
//
//  Created by 장혜성 on 2023/11/07.
//

import UIKit

import Toast

extension UIViewController {
    
    func showToast(
        msg: String,
        position: ToastPosition = .bottom,
        backgroundColor: UIColor = .black.withAlphaComponent(0.8)
    ) {
        var style = ToastStyle()
        style.messageFont =  .monospacedDigitSystemFont(ofSize: 12, weight: .regular)
        style.messageColor = .white
        style.messageAlignment = .center
        style.backgroundColor = backgroundColor
        self.view.makeToast(msg, duration: 2.0, position: position, style: style)
    }
}
