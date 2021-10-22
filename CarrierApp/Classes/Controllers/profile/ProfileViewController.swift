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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel = ProfileEditVM()
        viewModel?.getUserData()

    }
    
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        populateUserData()
    }
    
    // MARK: - Actions
    @IBAction func editBtnPressed(_ sender: Any) {
        let popupVC = PopupProfileEdit(nibName: "PopupProfileEdit", bundle: nil)
        popupVC.viewModel = self.viewModel
        popupVC.changedUserName = {
            self.userName.text = self.viewModel?.userName
        }
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
        
        userName.text = viewModel?.userName
        userEmail.text = viewModel?.userEmail
        userPhone.text = viewModel?.userPhone
        
        
        self.downloadImageFromServer(viewModel?.userImage ?? "") { image, error, success in
            
            self.userImage.stopAnimating()
            if success ?? false && image != nil {
                self.userImage.image = image
            }
        }
    }
}
