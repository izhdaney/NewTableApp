//
//  NewTableViewController.swift
//  NewTableApp
//
//  Created by Ilya Zhdaney on 12.07.2021.
//

import UIKit

class NewTableViewController: UIViewController {

    @IBOutlet weak var tblMyTable: UITableView!
    let cellID = "MyTableViewCell"
    
    private var data: [Contacts] = [Contacts(name: "Ilya", lastName: "Zhdaney", imageName: "image4"), Contacts(name: "Dmitriy", lastName: "Dmitriev", imageName: "image4"), Contacts(name: "Dmitriy", lastName: "Dmitriev", imageName: "image4")]
    
    var drinks = [CocktailResults]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMyTable.delegate = self
        tblMyTable.dataSource = self
        tblMyTable.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:  .add, target: self , action: #selector(editTapped))
        
        let service = Service(baseUrl: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=rum")
        
        service.getAllDrinksList{ [weak self] (drinks, status, message) in
            if status {
                guard let self = self else {return}
                self.drinks = drinks
                self.tblMyTable.reloadData()
            }
        }
        
    }

    
    @objc func editTapped(){
        let vc = AddItemViewController()
        self.present(vc, animated: true, completion: nil)
        vc.newItemDelegate = self
    }
    

}


extension NewTableViewController:UITableViewDelegate,UITableViewDataSource, NewItemDelegate{
    func update(name: String?, lastName: String?, imageName: String?) {
        
        let name = name!
        let lastName = lastName!
        let imageName = imageName!
        
        let newItem: Contacts = Contacts(name: name, lastName: lastName, imageName: imageName)
        data.insert(newItem, at: 0)
        tblMyTable.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblMyTable.dequeueReusableCell(withIdentifier: cellID) as! MyTableViewCell
        
        
        cell.tblName.text = drinks[indexPath.row].drinkName
        cell.tblLastName.text = ""
        DispatchQueue.main.async {
            cell.tblImage.image = UIImage(data: try! Data(contentsOf: URL(string: self.drinks[indexPath.row].imageString)!))
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
                let detailsVC = PersonalViewController(nibName: "PersonalViewController", bundle: nil)
//        detailsVC.dataFromTableLastName = data[indexPath.row].lastName
//        detailsVC.dataFromTableName = data[indexPath.row].name
//        detailsVC.dataFromTableImageName = data[indexPath.row].imageName
        detailsVC.dataFromTableLastName = ""
        detailsVC.dataFromTableName = drinks[indexPath.row].drinkName
        detailsVC.dataFromTableImageName = drinks[indexPath.row].imageString
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                tableView.beginUpdates()
                data.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }
        }
    
    
}
