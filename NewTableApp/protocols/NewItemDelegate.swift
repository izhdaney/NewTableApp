//
//  NewItemDelegate.swift
//  NewTableApp
//
//  Created by Ilya Zhdaney on 13.07.2021.
//

import Foundation

protocol NewItemDelegate : AnyObject {
    func update(name: String?, lastName: String?, imageName: String?)
}
