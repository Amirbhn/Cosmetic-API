//
//  CosmeticTableViewCell.swift
//  Amir
//
//  Created by Map04 on 2021-04-15.
//

import UIKit

class CosmeticTableViewCell: UITableViewCell {
    @IBOutlet weak var imageCosmetic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    func setCellWithValuesOf( cosmetic:Cosmetic) {
        updateUI(title: cosmetic.name!, poster: cosmetic.image_link)
    }

    private func updateUI(title: String,  poster: String?) {
        self.nameLabel.text = title
        guard let posterString = poster else {return}
        guard let posterImageURL = URL(string: posterString) else {
            self.imageCosmetic.image = UIImage(named: "noImageAvailable")
            return
        }
        
        getImageDataFrom(url: posterImageURL)
    }
    
    func getImageDataFrom(url: URL) {
       URLSession.shared.dataTask(with: url) { (data, response, error) in
           guard let data = data else {
               print("Empty Data")
               return
           }
           
           DispatchQueue.main.async {
               if let image = UIImage(data: data) {
                   self.imageCosmetic.image = image
               }
           }
       }.resume()
   }
}
