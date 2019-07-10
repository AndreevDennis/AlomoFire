//
//  ViewController.swift
//  AlomoFire
//
//  Created by Денис Андреев on 7/10/19.
//  Copyright © 2019 Денис Андреев. All rights reserved.
//

import UIKit
import Alamofire

final class ViewController: UIViewController {
    
    @IBOutlet weak var myProgress: UIProgressView!
    @IBOutlet weak var myImageView: UIImageView!
    
    let myUrl = "http://jsonplaceholder.typicode.com/posts"
    
    
    override func viewDidLoad() {
        //        getResult()
        //        checkStatusCode()
        getPicture()
    }
    
    private func getResult(){
        request(myUrl).responseJSON { responseJSON in
            
            switch  responseJSON.result {
            case .success:
                guard let jsonArray = responseJSON.result.value as? [[String : Any]] else {return}
                print("Array \(jsonArray)")
                print("First object \(jsonArray[0])")
                print("First ID \(jsonArray[7]["title"]!)")
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    private func checkStatusCode(){
        request(myUrl).responseJSON { responseJSON in
            guard let statusCode = responseJSON.response?.statusCode else {return}
            
            print("statusCode = \(statusCode)")
            
            
        }
    }
    
    private func getPicture(){
        request("https://upload.wikimedia.org/wikipedia/commons/2/2c/A_new_map_of_Great_Britain_according_to_the_newest_and_most_exact_observations_%288342715024%29.jpg").validate()
            .downloadProgress { (progress) in
                print("totalUnitCount:\n", progress.totalUnitCount)
                print("completedUnitCount:\n", progress.completedUnitCount)
                print("fractionCompleted:\n", progress.fractionCompleted)
                print("localizedDescription:\n", progress.localizedDescription!)
                print("---------------------------------------------")
                self.myProgress.progress = Float(progress.fractionCompleted)
                
        }
        .response { (response) in
            guard let data = response.data,
                let image = UIImage(data: data) else {return}
            self.myImageView.image = image
        }
        .responseJSON { responseJSON in
            guard let statusCode = responseJSON.response?.statusCode else {return}
            if (200..<300).contains(statusCode) {
                let value = responseJSON.result.value
                print("value = \(value ?? "")")
            }
            else {
                print("Error")
            }
            
            print("statusCode = \(statusCode)")
            
            
        }
        
        
    }
    
}

