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
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPhone: UITextField!
    
    var viewModel: ProfileEditVM?
    // MARK: - Controller's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateUserData()
        
       
    }
    
    
    // MARK: - Actions
    @IBAction func editBtnPressed(_ sender: Any) {
        let popupVC = PopupProfileEdit(nibName: "PopupProfileEdit", bundle: nil)
        popupVC.nameToEdit = self.userName.text ?? ""
        popupVC.modalPresentationStyle = .overFullScreen
        self.present(popupVC, animated: false, completion: nil)
    }
    
    @IBAction func editPhotoPressed(_ sender: UIButton){
        ImagePickerVC.shared.showImagePickerFromVC(fromVC: self, isGalleryOpen: nil)
        
    }
    
    override func imageSelectedFromGalleryOrCamera(selectedImage: UIImage) {
        userImage.image = selectedImage
    }
    
    fileprivate func populateUserData(){
        
        guard let user = DataManager.shared.getUsersDetail() else {return}
        
        userName.text = user.name
        userEmail.text = user.email
        userPhone.text = user.phone
        
        self.downloadImageFromServer(user.image) { image, error, success in
            
            self.userImage.stopAnimating()
            if success ?? false && image != nil {
                self.userImage.image = image
            }
        }
    }
}
