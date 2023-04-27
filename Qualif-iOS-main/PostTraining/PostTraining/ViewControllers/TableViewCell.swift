//
//  TableViewCell.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameTF: UITextField!
    var updateHandler = {}
    @IBOutlet weak var initialTF: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func updateButton(_ sender: Any) {
        updateHandler()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
