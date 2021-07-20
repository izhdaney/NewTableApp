//
//  PexelsViewController.swift
//  NewTableApp
//
//  Created by Ilya Zhdaney on 19.07.2021.
//

import UIKit

class PexelsViewController: UIViewController {
    
    @IBOutlet weak var clMyCollectionView: UICollectionView!
 
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBAction func txtEditingChanged(_ sender: Any) {
        searchPicture(searchText: txtSearch.text!)
    }
    
    var images = [PhotosResult]()
    let service = Service(baseUrl: "https://api.pexels.com/v1/search")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clMyCollectionView.register(UINib(nibName: "PexelsCollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: "PexelsCollectionViewCell")
        self.clMyCollectionView.dataSource = self
        self.clMyCollectionView.delegate = self
        searchPicture(searchText: "nature")
    }
    
    
    func searchPicture(searchText: String){

            self.service.getSearchImages(searchText: searchText){ [weak self] (images, status, message) in
                if status {
                    guard let self = self else {return}
                    self.images = images
                    self.clMyCollectionView.reloadData()
            }
        }
    }
    
    
    
}

extension PexelsViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clMyCollectionView.dequeueReusableCell(withReuseIdentifier: "PexelsCollectionViewCell", for: indexPath) as! PexelsCollectionViewCell
        let image = images[indexPath.row]
        DispatchQueue.main.async {
            cell.setupCell(imageResult: image)
        }
        return cell
    }
}
