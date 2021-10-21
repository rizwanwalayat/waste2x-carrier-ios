//
//  ProfileViewController.swift
//  CarrierApp
//
//  Created by MAC on 18/10/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var userImage:UIImageView!
    
    
    // MARK: - Controller's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    // MARK: - Actions
    @IBAction func editBtnPressed(_ sender: Any) {
        let popupVC = PopupProfileEdit(nibName: "PopupProfileEdit", bundle: nil)
        popupVC.modalPresentationStyle = .overFullScreen
        self.present(popupVC, animated: true, completion: nil)
    }
    
    @IBAction func editPhotoPressed(_ sender: UIButton){
        ImagePickerVC.shared.showImagePickerFromVC(fromVC: self, isGalleryOpen: nil)
        
    }
    
    override func imageSelectedFromGalleryOrCamera(selectedImage: UIImage) {
        userImage.image = selectedImage
    }
    
}
