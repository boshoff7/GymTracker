//
//  Keyboard+Extensions.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/29.
//

import Foundation
import UIKit


//extension DetailController: UITextFieldDelegate {
//    func hideKeyboardWhenTappedAround() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//    
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//    
//    func addDoneButton(textField1: UITextField, textField2: UITextField, textField3: UITextField, textField4: UITextField) {
//        let toolBar = UIToolbar()
//        toolBar.sizeToFit()
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneTapped))
//        
//        toolBar.setItems([doneButton], animated: false)
//        
//        textField1.inputAccessoryView = toolBar
//        textField2.inputAccessoryView = toolBar
//        textField3.inputAccessoryView = toolBar
//        textField4.inputAccessoryView = toolBar
//    }
//    
//    @objc func doneTapped() {
//        view.endEditing(true)
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//}
