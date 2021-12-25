//
//  AddItemViewController.swift
//  Bucket List
//
//  Created by Mac on 08/05/1443 AH.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    weak var delegate: AddItemTableViewControllerDelegate?
    
    var itemEdit: String?
    
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var itemTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTextField.text = itemEdit
    }

    @IBAction func cancleButtonPressed(_ sender: UIBarButtonItem) {
        
        delegate?.cancleButtonPressed(by: self)
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let text = itemTextField.text else {return}
        delegate?.itemSaved(by: self, with: text, at :indexPath)
    }
}
