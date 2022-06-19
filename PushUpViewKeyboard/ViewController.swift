//
//  ViewController.swift
//  PushUpViewKeyboard
//
//  Created by Shah Md Imran Hossain on 19/6/22.
//

import UIKit

class ViewController: UIViewController {
    
    var dismissKeyboardGestureRecognizer = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // keyboard gesture
        self.dismissKeyboardGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        
        // notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        dismissKeyboardGestureRecognizer.cancelsTouchesInView = true
        view.addGestureRecognizer(dismissKeyboardGestureRecognizer)
        if let keyboardSize = (notification.userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                UIView.animate(withDuration: 5, delay: 0, animations: {
                    self.view.frame.origin.y -= keyboardSize.height
                }, completion: { result in
                    print("Complted \(result)")
                })
                
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        dismissKeyboardGestureRecognizer.cancelsTouchesInView = false
        view.removeGestureRecognizer(dismissKeyboardGestureRecognizer)
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
