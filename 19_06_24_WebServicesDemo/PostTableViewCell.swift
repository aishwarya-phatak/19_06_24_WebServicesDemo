//
//  PostTableViewCell.swift
//  19_06_24_WebServicesDemo
//
//  Created by Vishal Jagtap on 30/07/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postUserIdLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
