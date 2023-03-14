//
//  DetailsViewController.swift
//  FetchMeFood
//
//  Created by Michael Zanaty on 3/9/23.
//


import UIKit

class RecipeVC: UIViewController{
    var dict: [Dictionary<String,Any>] = []
    var meal: Meal?
    var idMeal: String?
    var mealName: String?
    var ingredients: [String]?
    var instructions: String?
    
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var measureLabel: UILabel!
    
    struct MealsResponse: Codable {
        let meals: [Meal]
        
    }
    struct meal {
        let mealName: String = ""
        let instructions: String = ""
        let ingredients: String = ""
        let measurements: String = ""
    }
    
    
    override func viewDidLoad() {
        
        
        if let idMeal = idMeal {
            let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)"
            if let url = URL(string: urlString)  {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data,
                       let mealResponse = try? JSONDecoder().decode(MealsResponse.self, from: data) {
                        //                       let meal = mealResponse.meals.first
                        DispatchQueue.main.async {
                            for meal in mealResponse.meals {
                                
                                // Update UI with meal details
                                
                                let mealName = meal.strMeal
                                let ingredients = [meal.strIngredient1, meal.strIngredient2, meal.strIngredient3,meal.strIngredient4, meal.strIngredient5, meal.strIngredient6, meal.strIngredient7, meal.strIngredient8, meal.strIngredient9, ].compactMap { $0 }
                                let instructions = meal.strInstructions
                                let measure = [meal.strMeasure1, meal.strMeasure2, meal.strMeasure3, meal.strMeasure4, meal.strMeasure5, meal.strMeasure6, meal.strMeasure7, meal.strMeasure8, meal.strMeasure9, meal.strMeasure10].compactMap { $0 }
                                
                                self.mealNameLabel.text = mealName
                                self.ingredientsLabel.text = ingredients.joined(separator: ", ")
                                self.instructionsLabel.text = instructions
                                self.measureLabel.text = measure.joined(separator: ", ")
                                
                            }
                            
                            
                            
                        }
                    }
                    
                }
                task.resume()
            }
            
        }
    }
}


