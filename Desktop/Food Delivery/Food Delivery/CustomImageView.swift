//
//  Class.swift
//  Food Delivery
//
//  Created by Andre Assadi on 5/20/18.
//  Copyright © 2018 BHSAppDevClub. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString:String){
        
        imageUrlString = urlString
        let url = URL(string: urlString)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url!,completionHandler:{(data,response,error) in
            
            if (error != nil ) {
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data:data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!,forKey:urlString as AnyObject)
                
            }
            
        }).resume()
        
        
        
    }
    
    
    
}

