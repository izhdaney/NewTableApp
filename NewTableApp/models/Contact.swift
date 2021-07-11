//
//  Contact.swift
//  NewTableApp
//
//  Created by Ilya Zhdaney on 13.07.2021.
//

public struct Contacts {
    
    var name:String?
    var lastName:String?
    var imageName:String?
    
    init(name: String, lastName: String, imageName: String)
    {
        self.name = name
        self.lastName = lastName
        self.imageName = imageName
    }
}
