//
//  ViewController.swift
//  FetchMeFood
//
//  Created by Michael Zanaty on 3/1/23.
//



import UIKit



class MealListVC: UITableViewController {
    
    
    
    var meals: [Any] = []
    var selectedMealID: String? = ""
    var destinationVC = RecipeVC.self
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MealsResponse.self, from: data)
                self.meals = response.meals
                //self.meals = response.meals.map { ($0.strMeal ?? "") }.sorted()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let meal = meals[indexPath.row] as? Meal
        cell.textLabel?.text = meal?.strMeal
        return cell
    }
    
    struct MealsResponse: Codable {
        let meals: [Meal]
    }
    
    struct Meal: Codable {
        let idMeal: String?
        let strMeal: String?
        let strInstructions: String?
        let strIngredient1: String?
        let strIngredient2: String?
        let strIngredient3: String?
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipe" {
            if let RecipeVC = segue.destination as? RecipeVC {
                if let selectedMealID = sender as? String{
                    RecipeVC.idMeal = selectedMealID
                }
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let RecipeVC = storyboard?.instantiateViewController(identifier: "RecipeVC") as! RecipeVC
        var tempMeal = meals[indexPath.row] as? Meal
        selectedMealID = tempMeal?.idMeal
        
        
        //selectedMealID = meals[indexPath.row]
        
        performSegue(withIdentifier: "ShowRecipe", sender: selectedMealID)
    }

}
