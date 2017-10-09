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
            ["name" : "Keila Maney", "pro-image" : "pro-img-3",
                 "items": [["content" : "image", "item" : "img-3"], ["content" : "video", "item" : "output"], ["content" : "video", "item" : "output2"]]],
            ["name" : "Gilberto", "pro-image" : "pro-img-1",
                 "items": [["content" : "video", "item" : "output3"], ["content" : "image", "item" : "img-4"], ["content" : "image", "item" : "img-5"], ["content" : "video", "item" : "output"]]],
            ["name" : "Jonathan", "pro-image" : "pro-img-2",
                 "items": [["content" : "image", "item" : "img-1"], ["content" : "video", "item" : "output2"]]],
            ["name" : "Delmer", "pro-image" : "pro-img-4",
                 "items": [["content" : "image", "item" : "img-2"], ["content" : "video", "item" : "output"], ["content" : "image", "item" : "img-3"]]],
            ["name" : "Carolyne", "pro-image" : "pro-img-3",
                 "items": [["content" : "video", "item" : "output"], ["content" : "image", "item" : "img-4"], ["content" : "video", "item" : "output3"], ["content" : "image", "item" : "img-3"]]],
            ["name" : "Sabine", "pro-image" : "pro-img-5",
                 "items": [["content" : "video", "item" : "output2"], ["content" : "image", "item" : "img-5"], ["content" : "video", "item" : "output3"]]],
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
        
        cell.imgView.image = UIImage(named: userArr[indexPath.row]["pro-image"] as! String)
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
            vc.currentIndex = indexPath.row
            self.present(vc, animated: true, completion: nil)
        }
    }
}

