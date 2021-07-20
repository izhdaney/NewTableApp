//
//  PersonalViewController.swift
//  NewTableApp
//
//  Created by Ilya Zhdaney on 12.07.2021.
//

import UIKit

class PersonalViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblLastName: UILabel!
    
    
    var dataFromTableName : String?
    var dataFromTableLastName : String?
    var dataFromTableImageName : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        lblName.textColor = UIColor.white
        lblLastName.textColor = UIColor.white
        
        image.layer.cornerRadius = 75
        image.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblName.text = dataFromTableName
        lblLastName.text = dataFromTableLastName
//        image.image = UIImage(named: dataFromTableImageName!)
        DispatchQueue.main.async { [self] in
            image.image = UIImage(data: try! Data(contentsOf: URL(string: self.dataFromTableImageName!)!))
        }
    }

    

}
