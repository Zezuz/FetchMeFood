//
//  ViewController.swift
//  FetchMeFood
//
//  Created by Michael Zanaty on 3/1/23.
//



import UIKit

class MealListVC: UITableViewController {

    var meals: [String] = []
    
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
                self.meals = response.meals.map { $0.strMeal }.sorted()
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
        let meal = meals[indexPath.row]
        cell.textLabel?.text = meal
        return cell
    }
    
    struct MealsResponse: Codable {
        let meals: [Meal]
    }

    struct Meal: Codable {
        let strMeal: String
    }
}


//class MealListVC: UITableViewController {
//
//    struct MealsResponse: Codable {
//        let meals: [Meal]
//    }
//
//    struct Meal: Codable {
//        let strName: String
//        let strMeal: String
//        let strCategory: String
//    }
//
//    var data = [Meal]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//            guard let data = data else {
//                print("Error: No data received")
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(MealsResponse.self, from: data)
//                self.data = Meals.sorted(by: { (item1, item2) -> Bool in
//                        let name1 = (item1 as? [String: Any])?["strMeal"] as? String ?? ""
//                        let name2 = (item2 as? [String: Any])?["strMeal"] as? String ?? ""
//                        return name1 < name2
//                    })
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            } catch {
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let item = data[indexPath.row]
//        cell.textLabel?.text = Meal.strMeal
//        cell.detailTextLabel?.text = Meal.idMeal
//        return cell
//    }
//}


//class MealListVC: UITableViewController {
//
//    var data = [Meal]()
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//
//        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//            guard let data = data else {
//                print("Error: No data received")
//                return
//            }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                if let dict = json as? [String: Any], let array = dict["meals"] as? [Any] {
//                    let response = try JSONDecoder().decode(MealsResponse.self, from: data)
//                    self.data = response.meals.map { Meal(name: $0.strMeal, category: $0.strCategory) }
//
//                        let name1 = (item1 as? [String: Any])?["strMeal"] as? String ?? ""
//                        let name2 = (item2 as? [String: Any])?["strMeal"] as? String ?? ""
//                        return name1 < name2
//                    })
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                }
//            } catch {
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let item = data[indexPath.row] as? [String: Any]
//        cell.textLabel?.text = item?["strMeal"] as? String
//        cell.detailTextLabel?.text = item?["strCategory"] as? String
//        return cell
//    }
//
//}
