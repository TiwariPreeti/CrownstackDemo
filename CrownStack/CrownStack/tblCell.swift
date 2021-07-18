//
//  tblCell.swift
//  CrownStack
//
//  Created by Macbook on 11/07/21.
//

import UIKit

class tblCell: UITableViewCell {
    
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var collectionName : UILabel!
    @IBOutlet weak var trackName : UILabel!
    @IBOutlet weak var artworkUrl100 : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
