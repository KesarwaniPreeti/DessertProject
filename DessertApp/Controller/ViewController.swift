//
//  ViewController.swift
//  DessertApp
//
//  Created by Preeti Kesarwani on 12/22/23.
//




import UIKit
import SDWebImage



class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var desserts: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchDesserts()
        searchBarSetup()
    }
    
    
    
    
    private func searchBarSetup(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController =  searchController
        
    }
    
    func fetchDesserts() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
             
            
                let result = try decoder.decode([String : [Meal]].self, from: data)
               
              
                if let meals = result["meals"] {
                    self.desserts = meals
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
             
                
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
}

// Table View
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return desserts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DessertTableViewCell", for: indexPath) as? DessertTableViewCell
        cell?.dessertName.text = desserts[indexPath.row].strMeal
        cell?.dessertImage.sd_setImage(with: URL(string: desserts[indexPath.row].strMealThumb))
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedDesserts = desserts[indexPath.row]
        
        showMealsDetails(dessert: selectedDesserts)
        
        
    }
    
    
    func showMealsDetails (dessert : Meal){
        
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "Main") as? MealDetailsViewController
        secondVC?.mealId = dessert.idMeal
        secondVC?.dessertheading = dessert.strMeal
      
        
        
        
        navigationController?.pushViewController(secondVC!, animated: true)
        
        
    }
    
    
    
    
}


// UISerach Bar

extension ViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else { return }

        if searchText.isEmpty {
            
            fetchDesserts()
        } else {
            // Filter the array based on the search text
            desserts = desserts.filter({
                $0.strMeal.lowercased().contains(searchText.lowercased())
            })
        }
        tableView.reloadData()
    }
}
