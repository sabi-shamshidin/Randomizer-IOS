//
//  ViewController.swift
//  Randomizer
//
//  Created by Sabi on 21.03.2022.
//

import UIKit

class RandomController: UIViewController {

    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var cocktailButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var manager = MediaManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        
    }
    @IBAction func randomGenerator(_ sender: UIButton) {
        if sender == foodButton {
            manager.showImage(isFood: true)
        } else {
            manager.showImage(isFood: false)
        }
    }
    
}

extension RandomController: MediaManagerDelegate {
    
    func updateImage(image: String) {
        DispatchQueue.main.async {
            let url = URL(string: image)
            let data = try? Data(contentsOf: url!)
            self.imageView.image = UIImage(data: data!)
        }
    }
}
