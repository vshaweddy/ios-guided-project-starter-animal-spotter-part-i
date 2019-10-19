//
//  AnimalDetailViewController.swift
//  AnimalSpotter
//
//  Created by Vici Shaweddy on 9/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AnimalDetailViewController: UIViewController {

    @IBOutlet weak var spottedOnLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var animalImageView: UIImageView!
    
    var apiController: APIController?
    var animalName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetails()
        // Do any additional setup after loading the view.
    }
    
    private func getDetails() {
        guard let apiController = apiController, let animalName = animalName else {
            return
        }
        
        apiController.fetchDetails(for: animalName) { (result) in
            do {
                let animal = try result.get()
                DispatchQueue.main.async {
                        self.updateViews(with: animal)
                }
                    
                apiController.fetchImage(at: animal.imageURL, completion: { (result) in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.animalImageView.image = image
                        }
                    }
                })
                }
             catch let error as NetworkError {
                switch error {
                case .noAuth:
                    // present the login screen
                    print("No auth error")
                default:
                    print("Error")
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func updateViews(with animal: Animal) {
        title = animal.name
        descriptionLabel.text = animal.description
        coordinatesLabel.text = "lat: \(animal.latitude), long: \(animal.longitude)"
        spottedOnLabel.text = dateFormatter.string(from: animal.timeSeen)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
