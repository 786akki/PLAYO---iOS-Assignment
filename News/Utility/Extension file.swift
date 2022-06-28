//
//  Extension file.swift
//  News
//
//  Created by Akhil on 28/06/22.
//

import Foundation
import UIKit
extension UIViewController{
    func loader() -> UIAlertController{
        let alert = UIAlertController(title: nil, message: "Loading", preferredStyle: .alert)
        let indicater = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicater.hidesWhenStopped = true
        indicater.startAnimating()
        indicater.style = .large
        alert.view.addSubview(indicater)
        present(alert, animated: true, completion: nil)
        return alert
    }
    func stopLoader(loader : UIAlertController){
        DispatchQueue.main.async {
            loader.dismiss(animated: true,completion: nil)
           
        }
    }
}
