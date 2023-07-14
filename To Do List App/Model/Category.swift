//
//  Category.swift
//  To Do List App
//
//  Created by Mohamed Elkomey on 09/07/2023.
//

import Foundation
import RealmSwift

class Category:Object{
    @objc dynamic var name:String = ""
    let items = List<Item>()
}
