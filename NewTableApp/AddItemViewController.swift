//
//  AddItemViewController.swift
//  NewTableApp
//
//  Created by Ilya Zhdaney on 12.07.2021.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtImageName: UITextField!
    @IBOutlet weak var lblError: UILabel!
   
    weak var newItemDelegate :NewItemDelegate?
    
    @IBAction func btnAddTouchUpInside(_ sender: UIButton) {
        if (validation()){
            lblError.isHidden = true
            newItemDelegate?.update(name: txtName.text, lastName: txtLastName.text, imageName: txtImageName.text)
            dismiss(animated: true)
        }
        else{
            lblError.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblError.isHidden = true
        lblError.text = "Проверьте правильность ввода данных"
        lblError.textColor = UIColor.red

        // Do any additional setup after loading the view.
    }
    
    
    func validation()->Bool{
        if (txtName.text != "" && txtLastName.text != "" && txtImageName.text != ""){
            return true
        }
        else{
            return false
        }
    }
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
