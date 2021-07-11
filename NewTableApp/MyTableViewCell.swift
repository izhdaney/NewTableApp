//
//  MyTableViewCell.swift
//  NewTableApp
//
//  Created by Ilya Zhdaney on 12.07.2021.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var cellMyTableCell: UIView!
    
    @IBOutlet weak var tblImage: UIImageView!
    @IBOutlet weak var tblName: UILabel!
    @IBOutlet weak var tblLastName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tblImage.layer.cornerRadius = 20
        tblImage.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
