//
//  AddItemTableViewControllerDelegate.swift
//  Bucket List
//
//  Created by Mac on 08/05/1443 AH.
//

import UIKit

protocol AddItemTableViewControllerDelegate : AnyObject {
  
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?)
    func cancleButtonPressed(by controller: AddItemTableViewController)
}
