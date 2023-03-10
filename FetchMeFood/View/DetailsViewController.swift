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


    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    
    @IBOutlet weak var instructions: UILabel!
        
        
        
     override func viewDidLoad() {
            
            if let idMeal = idMeal {
                    let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)"
                    let url = URL(string: urlString)!
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        if let data = data,
                            let mealResponse = try? JSONDecoder().decode(MealsResponse.self, from: data),
                            let meal = mealResponse.meals.first {
                            DispatchQueue.main.async {
                                // Update UI with meal details
                                self.mealName.text = meal.strMeal
                                self.ingredients.text = meal.strIngredient1
                                self.instructions.text = meal.strInstructions
                            }
                        }
            
            
            guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)") else {
                fatalError("Invalid URL")
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("Error: No data received")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MealsResponse.self, from: data)
                    guard let meal = response.meals.first else {
                        print("Error: No meal data received")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.mealName.text = meal.strMeal
                        self.ingredients.text = meal.strIngredient1
                        self.instructions.text = meal.strInstructions
                    }
                    
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }
            
            task.resume()
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
