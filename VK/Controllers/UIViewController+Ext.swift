//
//  UIViewController+Ext.swift
//  VK
//
//  Created by Иван Пуриков on 16/06/2019.
//  Copyright © 2019 Иван Пуриков. All rights reserved.
//

import UIKit

extension UIViewController {
    public func show(_ error: Error) {
        let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
}
