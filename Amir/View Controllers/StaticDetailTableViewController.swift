//
//  StaticDetailTableViewController.swift
//  Amir
//
//  Created by Map04 on 2021-04-15.
//

import UIKit

class StaticDetailTableViewController: UITableViewController {
    var cosmetic : Cosmetic?
    private var urlString: String = ""
    
    @IBOutlet weak var imageStatic: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBAction func saveBtnPressed(_ sender: UIBarButtonItem) {
    }
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBAction func sharebtnPressed(_ sender: UIButton) {
        guard let image = imageStatic.image else {return}
        let activityController = UIActivityViewController (activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController, animated: true, completion: nil)
    }
    
    func updateSaveButtonState() {
        let cosmeticTitleText = titleTextField.text ?? ""
        let cosmeticDescriptionText = descriptionTextField.text ?? ""
        saveBtn.isEnabled = !cosmeticTitleText.isEmpty && !cosmeticDescriptionText.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let cosmetic = cosmetic {
            titleTextField.text = cosmetic.name
            descriptionTextField.text = cosmetic.brand
            let poster = cosmetic.image_link
            guard let posterImageURL = URL(string: poster!) else {
                self.imageStatic.image = UIImage(named: "noImageAvailable")
                return
            }
            
            self.imageStatic.image = nil
            getImageDataFrom(url: posterImageURL)
        }
        updateSaveButtonState()
    }
    
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.imageStatic.image = image
                }
            }
        }.resume()
    }
    
    
    @IBAction func textEdditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
    Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "From Save" else { return }
        let name = titleTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        cosmetic = Cosmetic(name: name, price: nil, brand: description, image_link : "https://d3t32hsnjxo7q6.cloudfront.net/i/991799d3e70b8856686979f8ff6dcfe0_ra,w158,h184_pa,w158,h184.png")
    }
}
