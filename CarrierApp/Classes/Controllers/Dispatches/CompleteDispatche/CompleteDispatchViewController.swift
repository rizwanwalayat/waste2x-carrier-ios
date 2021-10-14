//
//  CompleteDispatchViewController.swift
//  CarrierApp
//
//  Created by MAC on 13/10/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class CompleteDispatchViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var weightDeliverTextField: UITextField!
    @IBOutlet weak var collectionViewImages: UICollectionView!
    @IBOutlet weak var constCollectionViewHeight: NSLayoutConstraint!
    
    
    // MARK: - Variables
    
    var imagesArray = [UIImage]()
    
    // MARK: - Controller's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewImages.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagesCollectionViewCell")
        if imagesArray.count == 0 {
            
            constCollectionViewHeight.constant = 0
            DispatchQueue.main.async {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionViewImages.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        collectionViewImages.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        print("observeValue called")
        
        if keyPath == "contentSize"
        {
            if let newvalue = change?[.newKey]{
                let updatedVal                        = newvalue as! CGSize
                let viewHeight                        = updatedVal.height
                constCollectionViewHeight.constant    = viewHeight
                collectionViewImages.layoutIfNeeded()
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    // MARK: - Actions
    
    @IBAction func completeDispatchButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Please Select", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "I’m All Done", style: .default, handler: { action in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Create Another Load", style: .default, handler: { action in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    
    }
    
    @IBAction func uploadImageButtonPressed(_ sender: Any) {
        
        ImagePickerVC.shared.showImagePickerFromVC(fromVC: self, isGalleryOpen: true)
    }
    
    @IBAction func useCamButtonPressed(_ sender: Any) {
        
        ImagePickerVC.shared.showImagePickerFromVC(fromVC: self, isGalleryOpen: false)
    }
    
    
    // MARK: - Selectors
    @objc override func imageSelectedFromGalleryOrCamera(selectedImage:UIImage){
        
        imagesArray.append(selectedImage)
        collectionViewImages.reloadData()
        
    }
    
    @objc func deleteImageButtonPressed(_ sender : UIButton){
        
        if imagesArray.count > sender.tag {
            
            collectionViewImages.performBatchUpdates({
                imagesArray.remove(at: sender.tag)
                collectionViewImages.deleteItems(at: [IndexPath(item: sender.tag, section: 0)])
            }, completion: nil)
        }
    }
}

extension CompleteDispatchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
        
        cell.uploadImageView.image = imagesArray[indexPath.item]
        cell.crossButton.tag = indexPath.item
        cell.crossButton.addTarget(self, action: #selector(deleteImageButtonPressed(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionViewImages.bounds.width / 3) - 8
        return CGSize(width: size, height: size)
    }
}
