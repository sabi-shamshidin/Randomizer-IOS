//
//  MediaManager.swift
//  Randomizer
//
//  Created by Sabi on 21.03.2022.
//

import Foundation

protocol MediaManagerDelegate {
    func updateImage(image: String)
}

class MediaManager {
    
    var delegate: MediaManagerDelegate?
    
    let foodUrl = "https://foodish-api.herokuapp.com/api/"
    let cocktailUrl = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
    
    var recipeArray: [FoodData] = []
    var drinkArray: [CocktailData] = []
    
    func getFood(completed: @escaping ()->()) {
        print("We are accessing the url \(foodUrl)")
        
        guard let url = URL(string: foodUrl) else {
            print("ERROR: Could not create a URL from \(foodUrl)")
            completed()
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR:  \(error.localizedDescription)")
            }
            
            do {
                let returned = try JSONDecoder().decode(FoodData.self, from: data!)
                self.delegate?.updateImage(image: returned.image)
                
            } catch {
                print("ERROR:  \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
    
    func getCocktail(completed: @escaping ()->()) {
        print("We are accessing the url \(cocktailUrl)")
        
        guard let url = URL(string: cocktailUrl) else {
            print("ERROR: Could not create a URL from \(cocktailUrl)")
            completed()
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR:  \(error.localizedDescription)")
            }
            
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                self.drinkArray = returned.drinks
                self.delegate?.updateImage(image: self.drinkArray[0].strDrinkThumb)
                
            } catch {
                print("ERROR:  \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
    
    func showImage(isFood: Bool) {
        if isFood {
            self.getFood {}
        } else {
            self.getCocktail {}
        }
    }
}
