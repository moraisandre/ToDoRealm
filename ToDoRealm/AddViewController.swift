//
//  AddViewController.swift
//  ToDoRealm
//
//  Created by Andre Morais on 6/25/16.
//  Copyright © 2016 Andre Morais. All rights reserved.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController, UITextFieldDelegate {

    var textField: UITextField?
    var newItemText: String?
    
    override func viewDidLoad() { // [1]
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        setupTextField()
        setupNavigationBar()
    }
    
    override func viewDidAppear(animated: Bool) { // [2]
        super.viewDidAppear(animated)
        textField?.becomeFirstResponder()
    }
    
    func setupTextField() { // [3]
        textField = UITextField(frame: CGRectZero)
        textField?.placeholder = "Type in item"
        textField?.delegate = self
        view.addSubview(textField!)
    }
    
    func setupNavigationBar() { // [4]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(AddViewController.doneAction))
    }
    
    override func viewDidLayoutSubviews() { // [5]
        super.viewDidLayoutSubviews()
        let padding = CGFloat(11)
        textField?.frame = CGRectMake(padding, self.topLayoutGuide.length + 50, view.frame.size.width - padding * 2, 100)
    }
    
    func doneAction() { // [6]
        let realm = try! Realm() // [6.1]
        if self.textField?.text!.utf16.count  > 0 { // [6.2]
            let newTodoItem = ToDoItem() // [6.3]
            newTodoItem.name = self.textField!.text!
            
            try! realm.write {
                realm.add(newTodoItem)
            }
            
        }
        dismissViewControllerAnimated(true, completion: nil) // [7]
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool { // [8]
        doneAction()
        textField.resignFirstResponder()
        return true
    }

}


























