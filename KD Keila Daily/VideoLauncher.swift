//
//  VideoLauncher.swift
//  KD Keila Daily
//
//  Created by Bunmeng on 5/31/17.
//  Copyright © 2017 Bunmeng. All rights reserved.
//

import UIKit
import AVFoundation
import youtube_ios_player_helper

class VideoPlayerView: UIView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
//        controlsContainerView.frame = frame
//        addSubview(controlsContainerView)
//        
//        controlsContainerView.addSubview(activityIndicatorView)
//        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        backgroundColor = UIColor.black
        
    }
    
    private func setupPlayerView() {
//        let urlString = "https://www.youtube.com/watch?v=u3u22OYqFGo"
//        if let url = URL(string: urlString) {
//            let player = AVPlayer(url: url)
//            
//            let playerLayer = AVPlayerLayer(player: player)
//            self.layer.addSublayer(playerLayer)
//            playerLayer.frame = self.frame
//            
//            player.play()
//            
//            player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
//        }
        let player: YTPlayerView = YTPlayerView(frame: self.frame)
        player.load(withVideoId: "WAAZJm6H9Ms")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            print("change")
            activityIndicatorView.stopAnimating()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideoLauncher: NSObject {

    func showVideoPlayer() {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            // 16 x 9 is the aspect ratio of all HD videos
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                
                view.frame = keyWindow.frame
                
            }, completion: { (completedAnimation) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
                
            })
        }
        
    }
    
}
