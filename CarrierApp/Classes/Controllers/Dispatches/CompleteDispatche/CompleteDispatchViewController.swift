//
//  CompleteDispatchViewController.swift
//  CarrierApp
//
//  Created by MAC on 13/10/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit
import DKImagePickerController

class CompleteDispatchViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var weightDeliverTextField: UITextField!
    @IBOutlet weak var collectionViewImages: UICollectionView!
    @IBOutlet weak var constCollectionViewHeight: NSLayoutConstraint!
    
    
    // MARK: - Variables
    
    var imagesArray = [UIImage]()
    var viewModel : CompleteDispatchViewModel?
    var disptachId = Int()
    
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
        
        viewModel = CompleteDispatchViewModel()
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
        
        if allFieldsAuth() {
            
            let actionVc = CreateAnOtherLoadViewController(nibName: "CreateAnOtherLoadViewController", bundle: nil)
            actionVc.modalPresentationStyle = .overFullScreen
            actionVc.iAmAllDoneButtonPressed = {
                
                self.iAmAllDoneDataSentToServer()
            }
            
            actionVc.createAnothetLoadButtonPressed = {
                
                // create an other load code here
            }
            self.present(actionVc, animated: false, completion: nil)
        }
    
    }
    
    @IBAction func uploadImageButtonPressed(_ sender: Any) {
        
        if imagesArray.count < 5 {
            
            let maxLimit = 5 - imagesArray.count
            ImagePickerVC.shared.showImagePickerForMultipleSelection(fromVC: self, isGalleryOpen: true, selectionLimit: maxLimit)
        }
        else {
            showToast(message: "Images Limit reached")
        }
    }
    
    @IBAction func useCamButtonPressed(_ sender: Any) {
        
        if imagesArray.count < 5 {
            let maxLimit = 5 - imagesArray.count
            ImagePickerVC.shared.showImagePickerForMultipleSelection(fromVC: self, isGalleryOpen: false, selectionLimit: maxLimit)
        }
        else {
            showToast(message: "Images Limit reached")
        }
    }
    
    
    // MARK: - Selectors
    @objc override func imageSelectedFromGalleryOrCamera(selectedImages:[DKAsset]){
        
        getAssetThumbnail(assets: selectedImages)
        
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


// MARK: - Custom Methods
extension CompleteDispatchViewController {
    
    fileprivate func getAssetThumbnail(assets: [DKAsset]){
        
        for asset in assets {
            
            asset.fetchImage(with: CGSize(width: 100, height: 100)) { img, response in
                
                if let image = img {
                    
                    self.imagesArray.append(image)
                }
            }
            self.collectionViewImages.reloadData()
        }
    }
    
    fileprivate func allFieldsAuth() -> Bool
    {
        if imagesArray.count > 0 && weightDeliverTextField.text!.count > 0{
            
            return true
        }
        else {
            if imagesArray.count == 0{
                self.showToast(message: "Please upload images")
            }
            else {
                self.showToast(message: "Please enter delivery weight")
            }
            
            return false
        }
    }
    
    fileprivate func getParamsForIamAllDone() -> [String : Any]
    {
        var postDict = [String: Any]()
        
        let deliveryWeight = weightDeliverTextField.text ?? ""
        
        postDict["delivered_weight"] = deliveryWeight
        postDict["receipt_type"] = "POD"
        postDict["image"] = imagesArray
        postDict["dispatch_id"] = disptachId
        
        return postDict
    }
}


// MARK: - API Calling related methods
extension CompleteDispatchViewController {
    
    fileprivate func iAmAllDoneDataSentToServer()
    {
        let params = getParamsForIamAllDone()
        viewModel?.compeleteDispatch(params, { response, error, success, message in
            
            if (success ?? false), error == nil {
                
                print(response)

            } else {
                self.showToast(message: error?.localizedDescription ?? message )
            }
        })
    }
}
