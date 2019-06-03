//
//  ViewController.swift
//  VK
//
//  Created by Иван Пуриков on 02/04/2019.
//  Copyright © 2019 Иван Пуриков. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - outlets
    @IBOutlet weak var Passwordinput: UITextField!
    @IBOutlet weak var usernameinput: UITextField!
    @IBOutlet weak var scrollView:UIScrollView!
    
    //MARK: - Properties
    private let networkingService = NetworkingService()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        print(#function)
        
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
      
    }
    
    

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
          print(#function)
       
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(#function)
    }
 /*
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(#function)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print(#function)
    }
    
   */
    
    //MARK: - actions
   @IBAction func loginButtonPressed(_ sender: UIButton) {
    
    if usernameinput.text == "",
        Passwordinput.text == "" {
        performSegue(withIdentifier: "Show Main Screen", sender: sender)
    } else {
        showLoginError()
        
    }
    

//        if usernameinput.text == "",
//            Passwordinput.text == "" {
//        print("AuthSuccess")
//        } else {
//            print("Failed")
//        }

        }
    //MARK: - API
    
    @objc private func keyboardWasShown(notification: Notification) {
        
        let info = notification.userInfo as NSDictionary?
        let keyboardSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        
        let contentsInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0 )
        
        scrollView?.contentInset = contentsInsets
        scrollView?.scrollIndicatorInsets = contentsInsets
    }
    
    @objc private func keyboardWasHidden (notification: Notification)  {
        let contentsInsets = UIEdgeInsets.zero
        
        scrollView?.contentInset = contentsInsets
        scrollView?.scrollIndicatorInsets = contentsInsets
    }
    
    @objc private func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //guard identifier == "Show Main Screen" else { return true }
        return false
//        if usernameinput.text == "1",
//            Passwordinput.text == "1" {
//            return true
//        } else {
//            showLoginError()
//            return false
//        }
    }
    
    
    private func showLoginError() {
        let loginAlert = UIAlertController(title: "Err", message: "login-pwd incorrect", preferredStyle: .alert)
    
    
        let action = UIAlertAction(title: "OK", style: .default) {
            _ in self.Passwordinput.text = ""
        }
         loginAlert.addAction(action)
        present(loginAlert, animated: true)
    
    }
    
    
  
}



