//
//  PexelsCollectionViewCell.swift
//  NewTableApp
//
//  Created by Ilya Zhdaney on 19.07.2021.
//

import UIKit

class PexelsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImage.layer.cornerRadius = 20
    }
    
    func setupCell(imageResult: PhotosResult){
        let image:String = imageResult.arraySrc["small"]!
        self.mainImage.image = UIImage(data: try! Data(contentsOf: URL(string: image)!))
    }
}
