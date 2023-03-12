//
//  DetailsViewController.swift
//  FetchMeFood
//
//  Created by Michael Zanaty on 3/9/23.
//


import UIKit

class RecipeVC: UIViewController{
    var meal: Meal?
    var idMeal: String?
    var mealName: String?
    var ingredients: [String]?
    var instructions: String?

    @IBOutlet weak var mealNamelabel: UILabel!
    @IBOutlet weak var ingredientslabel: UILabel!
    
    @IBOutlet weak var instructionslabel: UILabel!
        
        
        
     override func viewDidLoad() {
            
        if let idMeal = idMeal {
            let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)"
            if let url = URL(string: urlString)  {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data,
                       let mealResponse = try? JSONDecoder().decode(MealsResponse.self, from: data),
                       let meal = mealResponse.meals.first {
                        DispatchQueue.main.async {
                            // Update UI with meal details
                            self.mealNamelabel.text = "self.mealName"
                            self.ingredientslabel.text = "self.ingredients?.joined(sepa)"
                            self.instructionslabel.text = "self.instructions"
                        }
                    }
                }
                    
//                    let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//                        if let data = data,
//                            let mealResponse = try? JSONDecoder().decode(MealsResponse.self, from: data),
//                            let meal = mealResponse.meals.first {
//                            DispatchQueue.main.async {
//                                // Update UI with meal details
//                                self.mealNamelabel.text = self.mealName
//                                self.ingredientslabel.text = self.ingredients?.joined(separator: "\n")
//                                self.instructionslabel.text = self.instructions
//                            }
//                        }
                       
            
            
//
        }
        
        func formatIngredients(_ meal: Meal) -> String {
            var ingredients = ""
            let mirror = Mirror(reflecting: meal)
            for child in mirror.children {
                if let label = child.label, label.hasPrefix("strIngredient"), let ingredient = child.value as? String, !ingredient.isEmpty {
                    ingredients += "- \(ingredient)\n"
                }
            }
            return ingredients
        }
    }

    struct MealsResponse: Codable {
        let meals: [Meal]
    }



//    struct Meal: Codable {
//        let idMeal: String
//        let strMeal: String
//        let strInstructions: String
//        let strIngredient1: String
//        let strIngredient2: String
//        let strIngredient3: String
//        // add more strIngredient properties as needed
//    }

    
//     func viewDidLoad() {
//
//
//        // Set the meal name
//        mealName.text = meal?.strMeal
//
//        // Fetch the meal details
//        if let mealId = meal?.idMeal {
//            fetchMealDetails(mealId: mealId) { [weak self] meal in
//                guard let meal = meal else { return }
//                DispatchQueue.main.async {
//                    // Set the meal ingredients and instructions
//                    self?.ingredients.text = meal.strIngredients
//                    self?.instructions.text = meal.strInstructions
//                }
//            }
//        }
//    }
//
//    struct MealDetailsResponse: Codable {
//        let meals: [Meal]
//    }
//
//    struct Meal: Codable {
//        let idMeal: String
//        let strMeal: String
//        let strInstructions: String
//        let strIngredient1: String?
//        let strIngredient2: String?
//        let strIngredient3: String?
//        // Add more properties as needed
//
//        var strIngredients: String {
//            var ingredients = [String]()
//            if let ingredient = strIngredient1 {
//                ingredients.append(ingredient)
//            }
//            if let ingredient = strIngredient2 {
//                ingredients.append(ingredient)
//            }
//            if let ingredient = strIngredient3 {
//                ingredients.append(ingredient)
//            }
//            // Add more ingredients as needed
//
//            return ingredients.joined(separator: ", ")
//        }
//    }
//
//    func fetchMealDetails(mealId: String, completion: @escaping (Meal?) -> Void) {
//        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)"
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL: \(urlString)")
//            completion(nil)
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
//                completion(nil)
//                return
//            }
//
//            do {
//                let response = try JSONDecoder().decode(MealDetailsResponse.self, from: data)
//                completion(response.meals.first)
//            } catch {
//
//}
//        }
//    }
//}
         }
}
