//
//  ViewController.swift
//  ToDoRealm
//
//  Created by Andre Morais on 6/25/16.
//  Copyright © 2016 Andre Morais. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    
    var toDoItems:Results<ToDoItem>?{
        do{
            let realm = try Realm()
            return realm.objects(ToDoItem)
        }catch{
            print("Error")
        }
        
        return nil
    }
    
    var todos: Results<ToDoItem> {
        get {
            let predicate = NSPredicate(format: "finished == false", argumentArray: nil)
            let realm = try! Realm()
            return realm.objects(ToDoItem).filter(predicate)
        }
    }
    
    var finished: Results<ToDoItem> {
        get {
            let predicate = NSPredicate(format: "finished == true", argumentArray: nil)
            let realm = try! Realm()
            return realm.objects(ToDoItem).filter(predicate)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        setupNavigationBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() // [2]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationBar() {
        self.title = "ToDo List w/ Realm"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.addButtonAction))
    }
    
    func addButtonAction() {
        let addViewController = AddViewController(nibName: nil, bundle: nil)
        //addViewController.delegate = self
        let navController = UINavigationController(rootViewController: addViewController)
        presentViewController(navController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "To do"
        case 1:
            return "Finished"
        default:
            return ""
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return Int(toDoItems!.count)
        switch section {
            case 0:
                return Int(todos.count)
            case 1:
                return Int(finished.count)
            default:
                return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        switch indexPath.section {
            case 0:
                let list = todos[indexPath.row]
                cell.textLabel!.text = list.name
            case 1:
                let list = finished[indexPath.row]
                let attributedText = NSMutableAttributedString(string: list.name)
                attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributedText.length))
                cell.textLabel!.attributedText = attributedText
            default:
                fatalError("Error on loading values")
        }
     
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var todoItem: ToDoItem?
        
        switch indexPath.section {
            case 0:
                todoItem = todos[indexPath.row]
            case 1:
                todoItem = finished[indexPath.row]
            default:
                fatalError("Error on tapping value")
        }
        
        
        let realm = try! Realm()
        
        try! realm.write {
            todoItem?.finished = !todoItem!.finished
        }
        
        
        tableView.reloadData()
    }
 
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            var todoItem: ToDoItem?
            
            switch indexPath.section {
                case 0:
                    todoItem = todos[indexPath.row]
                case 1:
                    todoItem = finished[indexPath.row]
                default:
                    fatalError("Error on tapping value")
            }
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.delete(todoItem!)
            }
            
            tableView.reloadData()
        }
    }

}




















