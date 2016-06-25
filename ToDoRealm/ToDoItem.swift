//
//  ToDoItem.swift
//  ToDoRealm
//
//  Created by Andre Morais on 6/25/16.
//  Copyright © 2016 Andre Morais. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoItem: Object {
    dynamic var name = ""
    dynamic var finished = false
}
