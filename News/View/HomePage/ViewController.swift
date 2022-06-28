//
//  ViewController.swift
//  News
//
//  Created by Akhil on 27/06/22.
//

import UIKit

class ViewController: UIViewController {
    var countRefersh = 0
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var mTableView: UITableView!
    var newsList = [newsStructFile]()
    override func viewDidLoad() {
        super.viewDidLoad()
        newsAPI()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        mTableView.addSubview(refreshControl)
    }
    @objc func refreshData(){
        if countRefersh < newsList.count{
            newsList.append(newsList[countRefersh])
            countRefersh =  countRefersh+1
        }
        refreshControl.endRefreshing()
        mTableView.reloadData()
    }
    func newsAPI()
    {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=4e2beb825a804415a9be9255c7d3ca94")
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
            self.newsList = newsFullList!.articles
            DispatchQueue.main.async {
                self.mTableView.reloadData()
            }

        })
        dataTask.resume()
    }
}

extension UIImageView {
    func downloadImageView (from url :URL){
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
            (data,response,error) in
            guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200,
                  let mimeType = response?.mimeType?.hasPrefix("image"),
                  let data = data, error ==  nil,
                  let image = UIImage(data: data)
            else {
                return
        }
            DispatchQueue.main.async {
                self.image = image
            }
                  
        })
        dataTask.resume()
    }
}
extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsVC = mTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! newsCell
        if newsList[indexPath.row].author != nil{
            newsVC.authorName.text = newsList[indexPath.row].author
        }
        else
        {
            newsVC.authorName.text = " No author Name"
        }
        
        newsVC.newsTitle.text = newsList[indexPath.row].title
        if newsList[indexPath.row].urlToImage != nil{
            let url = URL(string: newsList[indexPath.row].urlToImage!)
            newsVC.ImageView.downloadImageView(from: url!)
            newsVC.ImageView.contentMode = .scaleToFill
        }
        else {
            //
        }
        newsVC.newsDescription.text = newsList[indexPath.row].description
        
        return newsVC
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "NewsContent", bundle: nil)
        let vc = str.instantiateViewController(withIdentifier: "NewsContent") as! NewsContent
        vc.newsContent = newsList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

