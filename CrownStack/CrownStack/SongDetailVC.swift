//
//  SongDetailVC.swift
//  CrownStack
//
//  Created by Macbook on 17/07/21.
//

import UIKit

class SongDetailVC: UIViewController {
    @IBOutlet weak var img_banner: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    var strImg : String = ""
    var strTitle : String = ""
    var strDetail : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = "Release Date - " + self.strTitle
        lblDescription.text = self.strDetail
        self.title = "Song Detail"
        if strImg == "" {
            
        }else{
            let url = URL(string:  strImg)
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    if data == nil {
                        
                    }else {
                        self.img_banner.image = UIImage(data: data!)
                    }
                }
            }
        }
    }
    


}
