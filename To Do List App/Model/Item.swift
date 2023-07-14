//
//  Item.swift
//  To Do List App
//
//  Created by Mohamed Elkomey on 09/07/2023.
//

import Foundation
import RealmSwift

class Item:Object {
 @objc dynamic  var name:String = ""
 @objc dynamic  var isChecked:Bool = false
    let parent = LinkingObjects(fromType: Category.self, property: "items")
}
