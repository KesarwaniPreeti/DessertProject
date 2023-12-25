//
//  MealsDeatils.swift
//  DessertApp
//
//  Created by Preeti Kesarwani on 12/22/23.
//

import UIKit
import SDWebImage




class MealDetailsViewController: UIViewController {
    
    
    @IBOutlet var dessertHeading: UILabel!
    
    
    @IBOutlet var dessertImage: UIImageView!
    
    @IBOutlet var dessertDescription: UILabel!
    
    @IBOutlet var strIngredient1: UILabel!
    
    @IBOutlet var strIngredient2: UILabel!
    
    @IBOutlet var strIngredient3: UILabel!
    
    @IBOutlet var strIngredient4: UILabel!
    
    @IBOutlet var strIngredient5: UILabel!
    
    @IBOutlet var strIngredient6: UILabel!
    
    @IBOutlet var strIngredient7: UILabel!
    
    
    
    @IBOutlet var strIngredient8: UILabel!
    
    @IBOutlet var strIngredient9: UILabel!
    
    
    @IBOutlet var strIngredient10: UILabel!
    
    
    
    @IBOutlet var strMeasure1: UILabel!
    
    @IBOutlet var strMeasure2: UILabel!
    
    
    @IBOutlet var strMeasure3: UILabel!
    
    
    @IBOutlet var strMeasure4: UILabel!
    
    @IBOutlet var strMeasure5: UILabel!
    
    @IBOutlet var strMeasure6: UILabel!
    
    
    @IBOutlet var strMeasure7: UILabel!
    
    
    @IBOutlet var strMeasure8: UILabel!
    
    
    @IBOutlet var strMeasure9: UILabel!
    
    @IBOutlet var strMeasure10: UILabel!
    
    
    @IBOutlet var originfOOD: UILabel!
    
    var mealId: String?
    var dessertheading : String = ""
    var mealDetails: meals?
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Fetchdata()
        dessertHeading.text =  dessertheading
      
      
        
    }
    
    
    func Fetchdata(){
        
        
        guard let mealId = mealId, let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            
            
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode([String: [meals]].self, from: data)
                
                if let mealDetails = result["meals"]?.first {
                    self.mealDetails = mealDetails
                    DispatchQueue.main.async {
                        self.updateUI()
                    }
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        .resume()
    }
    
    func updateUI() {
        guard let mealDetails = mealDetails else {
            return
        }
        
        
        dessertDescription.text =  mealDetails.strInstructions
        strMeasure1.text = mealDetails.strMeasure1
        strMeasure2.text = mealDetails.strMeasure2
        strMeasure3.text = mealDetails.strMeasure3
        strMeasure4.text = mealDetails.strMeasure4
        strMeasure5.text = mealDetails.strMeasure5
        strMeasure6.text = mealDetails.strMeasure6
        strMeasure7.text = mealDetails.strMeasure7
        strMeasure8.text = mealDetails.strMeasure8
        strMeasure9.text = mealDetails.strMeasure9
        strMeasure10.text = mealDetails.strMeasure10
        strIngredient1.text = mealDetails.strIngredient1
        strIngredient2.text = mealDetails.strIngredient2
        strIngredient3.text = mealDetails.strIngredient3
        strIngredient4.text = mealDetails.strIngredient4
        strIngredient5.text = mealDetails.strIngredient5
        strIngredient6.text = mealDetails.strIngredient6
        strIngredient7.text =  mealDetails.strIngredient7
        strIngredient8.text = mealDetails.strIngredient8
        strIngredient9.text = mealDetails.strIngredient9
        strIngredient10.text = mealDetails.strIngredient10
      
    
        
        if let imageUrl = URL(string: mealDetails.strMealThumb) {
                dessertImage.sd_setImage(with: imageUrl, completed: nil)
            }
        
        
        
        
       
        
    }
    
    
    
}



















