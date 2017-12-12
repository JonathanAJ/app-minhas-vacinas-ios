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

    @IBOutlet weak var myView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.myImage.layer.masksToBounds = true
        self.myImage.layer.cornerRadius = myImage.frame.height * 0.5
    }
    
    func displayCell(image : UIImage?, name : String, age : String, progress : Double){
        
        if let imageSuccess = image {
            self.myImage.image = imageSuccess
        }else{
            self.myImage.image = #imageLiteral(resourceName: "ios7-person-outline")
        }
        
        self.myLabelName.text = name
        self.myLabelAge.text = age
        
        var badgeAppearance = BadgeAppearance()
        badgeAppearance.backgroundColor = UIColor.blue //default is red
        badgeAppearance.textColor = UIColor.white // default is white
        badgeAppearance.textAlignment = .center //default is center
        badgeAppearance.textSize = 10 //default is 12
        badgeAppearance.distanceFromCenterX = 20 //default is 0
        badgeAppearance.distanceFromCenterY = 2 //default is 0
        self.myView.badge(text: "\(String(format:"%.0f", progress * 100))%", appearance: badgeAppearance)
    }
}
