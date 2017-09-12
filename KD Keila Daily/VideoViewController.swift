//
//  VideoViewController.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 2/3/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit
import Material
import Haneke

class VideoViewController: UIViewController {

    @IBOutlet var advertisingImageView: UIImageView?
    @IBOutlet var mainVideoView: UIWebView!
    @IBOutlet var menuBarButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    var videos = [ClassVideo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        let image = UIImage(named: "keila_daily_adv.png")
        advertisingImageView?.image = image
        if isInternetAvailable() {
            let cache = Shared.JSONCache
            cache.removeAll()
        }
        getChannels()
    }
    
    func performGetRequest(targetURL: URL!, completion: @escaping (_ data: Data?, _ HTTPStatusCode: Int?, _ error: Error?) -> Void) {
        var request = URLRequest(url: targetURL)
        request.httpMethod = "GET"
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async(execute: { 
                completion(data, (response as? HTTPURLResponse)?.statusCode, error)
            })
        }
        task.resume()
    }
    
    func getChannels() {
        let urlString = "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=\(ReferenceValues.PlaylistId)&key=\(ReferenceValues.API_KEY)&part=snippet"
        let targetURL = URL(string: urlString)
        let session = URLSession.shared
        let task = session.dataTask(with: targetURL!) { (data, response, error) in
            do {
                let results = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSDictionary
                let items = results["items"] as! NSArray
                self.videos.removeAll()
                for i in 0..<items.count {
                    let item = items[i] as! NSDictionary
                    let snippet = item["snippet"] as! NSDictionary
                    let video = ClassVideo()
                    video.PublishedAt = snippet["publishedAt"] as! String
                    video.Description = snippet["description"] as! String
                    video.Title = snippet["title"] as! String
                    let thumbnails = snippet["thumbnails"] as! NSDictionary
                    let _default = thumbnails["default"] as! NSDictionary
                    let _medium = thumbnails["medium"] as! NSDictionary
                    let _high = thumbnails["high"] as! NSDictionary
                    
                    video.Default.append(_default["url"] as! String)
                    video.Default.append("\(_default["width"] as! Int)")
                    video.Default.append("\(_default["height"] as! Int)")
                    
                    video.Medium.append(_medium["url"] as! String)
                    video.Medium.append("\(_medium["width"] as! Int)")
                    video.Medium.append("\(_medium["height"] as! Int)")
                    
                    video.High.append(_high["url"] as! String)
                    video.High.append("\(_high["width"] as! Int)")
                    video.High.append("\(_high["height"] as! Int)")
                    
                    let resourceId = snippet["resourceId"] as! NSDictionary
                    video.VideoId = resourceId["videoId"] as! String
                    
                    self.videos.append(video)
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error \(error)")
            }
            
        }
        task.resume()
    }
    
}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! YoutubeVideoTableViewCell
        
        let video = videos[indexPath.row]
        cell.lbTitle.text = video.Title
        cell.imgVideoImage.sd_setImage(with: URL(string: video.Default[0])!)
        cell.lbDateTime.text = video.PublishedAt
        
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let videoPlayer = VideoLauncher()
        videoPlayer.showVideoPlayer()
    }
    
}
