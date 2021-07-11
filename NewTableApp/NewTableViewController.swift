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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMyTable.delegate = self
        tblMyTable.dataSource = self
        tblMyTable.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:  .add, target: self , action: #selector(editTapped))
        NotificationCenter.default.addObserver(self, selector: #selector(addItem), name: Notification.Name(rawValue: "NotificationFromAddItemVC"), object: nil)
    }

    
    @objc func editTapped(){
        let vc = AddItemViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func addItem(notifiction: Notification){
        
        guard let userInfo = notifiction.userInfo else {return}
        
        guard let name = userInfo["name"] as? String else {return}
        guard let lastName = userInfo["lastName"] as? String else {return}
        guard let imageName = userInfo["image"] as? String else {return}
        
        let newItem: Contacts = Contacts(name: name, lastName: lastName, imageName: imageName)
        self.data.insert(newItem, at: 0)
        tblMyTable.reloadData()
    }
    

}


extension NewTableViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblMyTable.dequeueReusableCell(withIdentifier: cellID) as! MyTableViewCell
        
        
        cell.tblName.text = data[indexPath.row].name
        cell.tblImage.image = UIImage(named: data[indexPath.row].imageName!)
        cell.tblLastName.text = data[indexPath.row].lastName

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
                let detailsVC = PersonalViewController(nibName: "PersonalViewController", bundle: nil)
        detailsVC.dataFromTableLastName = data[indexPath.row].lastName
        detailsVC.dataFromTableName = data[indexPath.row].name
        detailsVC.dataFromTableImageName = data[indexPath.row].imageName
        
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
