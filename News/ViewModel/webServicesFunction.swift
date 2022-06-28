//
//  webServicesFunction.swift
//  News
//
//  Created by Akhil on 28/06/22.
//

import Foundation
import UIKit
extension UIViewController{
    func newsAPI()
    {
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=4e2beb825a804415a9be9255c7d3ca94")
      let loader =   self.loader()
        let dataTask =  URLSession.shared.dataTask(with: url!, completionHandler: {
            (data,response, error) in
            guard let data = data, error == nil  else {
                print("Error")
                return
            }
            var newsFullList:newsData?
            do {
                newsFullList = try JSONDecoder().decode(newsData.self, from: data)
            }
            catch{
                print("Error\(error)")
            }
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
            }
            self.newsList = newsFullList!.articles
            DispatchQueue.main.async {
                self.mTableView.reloadData()
            }

        })
        dataTask.resume()
    }
}
