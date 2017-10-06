//
//  ViewController.swift
//  InstagramStories
//
//  Created by mac05 on 05/10/17.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var usersCollectionView: UICollectionView!
    
    fileprivate var userArr = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        userArr = [
            ["name" : "Amira", "pro-image" : "header2.jpg",
                 "items": [["content" : "image", "item" : "img-1"], ["content" : "image", "item" : "img-2"]]],
            ["name" : "Keila Maney", "pro-image" : "header2.jpg",
                 "items": [["content" : "image", "item" : "img-1"], ["content" : "video", "item" : "output"], ["content" : "video", "item" : "output2"]]],
            ["name" : "Gilberto", "pro-image" : "header2.jpg",
                 "items": [["content" : "image", "item" : "img-1"], ["content" : "image", "item" : "img-2"]]],
            ["name" : "Jonathan", "pro-image" : "header2.jpg",
                 "items": [["content" : "image", "item" : "img-1"], ["content" : "video", "item" : "output2"]]],
            ["name" : "Delmer", "pro-image" : "header2.jpg",
                 "items": [["content" : "image", "item" : "img-1"], ["content" : "image", "item" : "img-2"]]],
            ["name" : "Carolyne", "pro-image" : "header2.jpg",
                 "items": [["content" : "video", "item" : "output"], ["content" : "image", "item" : "img-2"]]],
            ["name" : "Sabine", "pro-image" : "header2.jpg",
                 "items": [["content" : "video", "item" : "output2"], ["content" : "image", "item" : "img-2"]]],
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDataSource
    //1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return userArr.count
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! usersCollectionViewCell
        
        cell.imgView.image = UIImage(named: "Product-img")
        cell.lblUserName.text = userArr[indexPath.row]["name"]! as? String
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    //1
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContentView") as! ContentViewController
            vc.modalPresentationStyle = .overFullScreen
            vc.pages = self.userArr
            self.present(vc, animated: true, completion: nil)
        }
    }
}

