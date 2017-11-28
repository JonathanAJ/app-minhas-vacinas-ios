//
//  MyCollectionController.swift
//  MinhaVacinas
//
//  Created by Jonathan Alves Jardim on 21/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import UIKit

class MyCollectionCellController: UICollectionViewCell {
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myLabelName: UILabel!
    @IBOutlet weak var myLabelAge: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.myImage.layer.masksToBounds = true
        self.myImage.layer.cornerRadius = myImage.frame.height * 0.5
    }
    
    func displayCell(image : UIImage?, name : String, age : String){
        
        if let imageSuccess = image {
            myImage.image = imageSuccess
        }else{
            myImage.image = #imageLiteral(resourceName: "ios7-person-outline")
        }
        
        myLabelName.text = name
        myLabelAge.text = age
    }
}
