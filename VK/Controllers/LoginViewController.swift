//
//  ViewController.swift
//  VK
//
//  Created by Иван Пуриков on 02/04/2019.
//  Copyright © 2019 Иван Пуриков. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //MARK: - outlets
    @IBOutlet weak var Passwordinput: UITextField!
    @IBOutlet weak var usernameinput: UITextField!
    @IBOutlet weak var scrollView:UIScrollView!
    
    //MARK: - Properties
    
    private let networkingService = NetworkingService()
    private var handler: AuthStateDidChangeListenerHandle?
    
 
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //networkingService.exampleOfCodeble()
        
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        print(#function)
        
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 5, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.Passwordinput.transform = .identity
            self.usernameinput.transform = .identity
        }, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
      
        handler = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "Show Main Screen", sender: self)
                self.usernameinput.text = nil
                self.Passwordinput.text = nil
            }
        }
        
    }
    
    

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
          print(#function)
        
        if let handler = self.handler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
        
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
        
        if let handler = self.handler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
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
//
//    if usernameinput.text == "",
//        Passwordinput.text == "" {
//        performSegue(withIdentifier: "Show Main Screen", sender: sender)
//    } else {
//        showLoginError()
//
//    }
    

//        if usernameinput.text == "",
//            Passwordinput.text == "" {
//        print("AuthSuccess")
//        } else {
//            print("Failed")
//        }
    guard let email = usernameinput.text,
        let password = Passwordinput.text else {
            let error = VKError.loginPassIncorrect(message: "The login/password is incorrect")
            show(error)
            return
    }
    
    
    Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
        if let error = error {
            self?.show(error)
        }
    }
}
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        let alertVC = UIAlertController(title: "Register", message: "Enter your data", preferredStyle: .alert)
        
        alertVC.addTextField { txf in
            txf.placeholder = "Enter your email"
        }
        
        alertVC.addTextField { txf in
            txf.placeholder = "Enter your password"
            txf.isSecureTextEntry = true
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let email = alertVC.textFields?[0].text,
                let password = alertVC.textFields?[1].text else {
                    let error = VKError.loginPassIncorrect(message: "The login/password is incorrect")
                    self?.show(error)
                    return
            }
            
            Auth.auth().createUser(withEmail: email, password: password)
            { (result, error) in
                if let error = error {
                    self?.show(error)
                    return
                } else {
                    Auth.auth().signIn(withEmail: email, password: password)
                }
            }
        }
        
        alertVC.addAction(saveAction)
        alertVC.addAction(cancelAction)
        
        present(alertVC, animated: true)
    }
    //MARK: - API
    
    @IBAction func signBtnPressed(_ sender: Any) {
        
        let alertVC = UIAlertController(title: "Register", message: "Enter your data", preferredStyle: .alert)
        
        alertVC.addTextField { txf in
            txf.placeholder = "Enter your email"
        }
        
        alertVC.addTextField { txf in
            txf.placeholder = "Enter your pwd"
            txf.isSecureTextEntry = true
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self]  _ in
            
            guard let email = alertVC.textFields?[0].text,
                
                let password = alertVC.textFields?[1].text else {
                    
                    let error = VKError.loginPassIncorrect(message: "login/password is incorrect")
                    self?.show(error)
                    return
            }
            
            Auth.auth().createUser(withEmail: email, password: password)
            { (result, error) in
                if let error = error {
                    self?.show(error)
                    return
                } else {
                        
                    Auth.auth().signInAnonymously(completion: .none)
                }
            }
        }
        
        alertVC.addAction(saveAction)
        alertVC.addAction(cancelAction)
        
        present(alertVC, animated: true)
    }
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
        guard identifier == "Show Main Screen" else { return true }
        return false
        if usernameinput.text == "",
            Passwordinput.text == "" {
            return true
        } else {
            showLoginError()
            return false
        }
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



