//
//  PreViewController.swift
//  InstagramStories
//
//  Created by mac05 on 05/10/17.
//

import UIKit
import AVFoundation
import AVKit

class PreViewController: UIViewController, SegmentedProgressBarDelegate {

    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    var pageIndex : Int = 0
    var items = [[String: Any]]()
    var item = [[String : String]]()
    var SPB: SegmentedProgressBar!
    var player: AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.size.height / 2;
        userProfileImage.image = UIImage(named: items[pageIndex]["pro-image"] as! String)
        lblUserName.text = items[pageIndex]["name"] as? String
        item = self.items[pageIndex]["items"] as! [[String : String]]
        
        SPB = SegmentedProgressBar(numberOfSegments: self.item.count, duration: 5)
        if #available(iOS 11.0, *) {
            SPB.frame = CGRect(x: 18, y: UIApplication.shared.statusBarFrame.height + 5, width: view.frame.width - 35, height: 3)
        } else {
            // Fallback on earlier versions
            SPB.frame = CGRect(x: 18, y: 15, width: view.frame.width - 35, height: 3)
        }
        
        SPB.delegate = self
        SPB.topColor = UIColor.white
        SPB.bottomColor = UIColor.white.withAlphaComponent(0.25)
        SPB.padding = 2
        SPB.isPaused = true
        SPB.currentAnimationIndex = 0
        view.addSubview(SPB)
        view.bringSubview(toFront: SPB)
        
        let tapGestureImage = UITapGestureRecognizer(target: self, action: #selector(self.tapOn(_:)))
        tapGestureImage.numberOfTapsRequired = 1
        tapGestureImage.numberOfTouchesRequired = 1
        imagePreview.addGestureRecognizer(tapGestureImage)
        
        let tapGestureVideo = UITapGestureRecognizer(target: self, action: #selector(self.tapOn(_:)))
        tapGestureVideo.numberOfTapsRequired = 1
        tapGestureVideo.numberOfTouchesRequired = 1
        videoView.addGestureRecognizer(tapGestureVideo)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIView.animate(withDuration: 0.8) {
            self.view.transform = .identity
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            self.SPB.currentAnimationIndex = 0
            self.SPB.startAnimation()
            self.playVideoOrLoadImage(index: 0)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DispatchQueue.main.async {
            self.SPB.currentAnimationIndex = 0
            self.SPB.isPaused = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - SegmentedProgressBarDelegate
    //1
    func segmentedProgressBarChangedIndex(index: Int) {
        playVideoOrLoadImage(index: index)
    }
    
    //2
    func segmentedProgressBarFinished() {
        if pageIndex == (self.items.count - 1) {
            self.dismiss(animated: true, completion: nil)
        }
        else {
            _ = ContentViewControllerVC.goNextPage(fowardTo: pageIndex + 1)
        }
    }
    
    @objc func tapOn(_ sender: UITapGestureRecognizer) {
        SPB.skip()
    }
    
    //MARK: - Play or show image
    func playVideoOrLoadImage(index: NSInteger) {
        
        if item[index]["content"] == "image" {
            self.SPB.duration = 5
            self.imagePreview.isHidden = false
            self.videoView.isHidden = true
            self.imagePreview.image = UIImage(named: item[index]["item"]!)
        }
        else {
            let moviePath = Bundle.main.path(forResource: item[index]["item"], ofType: "mp4")
            if let path = moviePath {
                self.imagePreview.isHidden = true
                self.videoView.isHidden = false
                
                let url = NSURL.fileURL(withPath: path)
                self.player = AVPlayer(url: url)
                
                let videoLayer = AVPlayerLayer(player: self.player)
                videoLayer.frame = view.bounds
                videoLayer.videoGravity = .resizeAspectFill
                self.videoView.layer.addSublayer(videoLayer)
                
                let asset = AVAsset(url: url)
                let duration = asset.duration
                let durationTime = CMTimeGetSeconds(duration)
                
                self.SPB.duration = durationTime
                self.player.play()
            }
        }
    }
    
    //MARK: - Button actions
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
