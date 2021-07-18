//
//  ViewController.swift
//  CrownStack
//
//  Created by Macbook on 11/07/21.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var jsonResult = NSMutableArray()
    var arrData = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Songs"
        self.tableView.isHidden = true
        self.callData()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblCell", for: indexPath) as! tblCell
        
        let info = self.arrData[indexPath.row]  //as! SongListModal
        if self.arrData.count > 0{
            
            self.tableView.isHidden = false
            cell.lblName.text = info["artistName"] as? String
            cell.collectionName.text = info["collectionName"] as? String
            cell.trackName.text = info["trackName"] as? String
            let url = URL(string:  info["artworkUrl100"] as? String ?? "" )
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    if data == nil {
                        
                    }else {
                        cell.imgView.image = UIImage(data: data!)
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let vc = ( storyboard?.instantiateViewController (withIdentifier: "SongDetailVC")  as!  SongDetailVC)
        let info = self.arrData[indexPath.row]  //as! SongListModal
        if self.arrData.count > 0{
            vc.strImg =  info["artworkUrl30"] as? String ?? ""
            vc.strTitle = info["collectionName"] as? String ?? ""
            vc.strDetail = info["longDescription"] as? String ?? ""
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    // MARK: - API Method
    func callData() {
        let params = [:] as Dictionary<String, String>
        
        var request = URLRequest(url: URL(string: "https://itunes.apple.com/search?term=Michael+jackson")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!) as? [String:Any],
                   let jsonArray = jsonResult["results"] as? [[String:Any]] {
                    print(jsonArray, "===")
                    self.arrData = jsonArray
                    //                    let songListData = SongListModal()
                    //                    self.jsonResult.removeAllObjects()
                    //                    for jsonElement in jsonArray {
                    //                        songListData.artistName = jsonElement["artistName"] as? String ?? ""
                    //                        songListData.collectionName = jsonElement["collectionName"] as? String ?? ""
                    //                        songListData.artworkUrl100 =  jsonElement["artworkUrl100"] as? String ?? ""
                    //                        songListData.trackName =  jsonElement["trackName"] as? String ?? ""
                    //                        self.jsonResult.add(songListData)
                    //
                    //                    }
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("error")
            }
        })
        task.resume()
    }
    
}

