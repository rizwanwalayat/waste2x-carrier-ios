//
//  BaseViewController.swift
//  haid3r
//
//  Created by HaiD3R AwaN on 20/05/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import UIKit
import SDWebImage

class BaseViewController: UIViewController {

    
    @IBOutlet weak var baseHolderView: UIView!
    
    var sideMenuLastSelectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseHolderView?.roundCornersTopView(36)
        baseHolderView?.backgroundColor = UIColor(hexString: "F0F2F4")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        baseHolderView?.addGradient(colors: [UIColor(hexString: "FFFFFF").cgColor, UIColor(hexString: "F0F2F4").cgColor])
    }

    /**************************************************/
    
    @objc func imageSelectedFromGalleryOrCamera(selectedImage:UIImage){
        
    }
    
    func setImage(imageView:UIImageView,url:URL,placeHolder : String = "dummy")  {
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_imageIndicator?.startAnimatingIndicator()
        imageView.sd_setImage(with: url) { (img, err, cahce, URI) in
            imageView.sd_imageIndicator?.stopAnimatingIndicator()
            if err == nil{
                imageView.image = img
            }else{
                imageView.image = UIImage(named: placeHolder)
            }
        }
    }
    
    func showToast(message : String) {

       
        let toastLabel = UILabel(frame: CGRect(x: 20 , y:ScreenSize.SCREEN_HEIGHT - 100, width: ScreenSize.SCREEN_WIDTH - 40, height: 40))
        toastLabel.backgroundColor = UIColor.appColor
        toastLabel.textColor = UIColor.white
        let font = UIFont.poppinFont(withSize: 13)
        
        
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 4;
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines  =  2
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func setAttributedTextInLabel(boldString:String,emailAddress :String) -> NSMutableAttributedString
    {
        let boldfont       = UIFont.poppinBoldFont(withSize: 18)
        let activityAttribute   = [ NSAttributedString.Key.font: boldfont, NSAttributedString.Key.foregroundColor: UIColor.init(hexString: "ffffff")]
        let nameAttrString      = NSMutableAttributedString(string: boldString, attributes: activityAttribute)
        
        let emailFont            = UIFont.poppinFont(withSize: 18)
        let nameAttribute       = [ NSAttributedString.Key.font: emailFont, NSAttributedString.Key.foregroundColor: UIColor.init(hexString: "ffffff")]
        let activityAttrString  = NSAttributedString(string: emailAddress, attributes: nameAttribute)
        
        nameAttrString.append(activityAttrString)
        
        return nameAttrString
    }
    func setAttributedTextInLabel(text1:String,text2 :String,size:Int) -> NSMutableAttributedString
    {
        let firstTitle       = UIFont.poppinFont(withSize: CGFloat(size))
        let activityAttribute   = [ NSAttributedString.Key.font: firstTitle, NSAttributedString.Key.foregroundColor: UIColor.init(red: 0.31, green: 0.31, blue: 0.31, alpha: 0.9)]
        let nameAttrString      = NSMutableAttributedString(string: text1, attributes: activityAttribute)
        
        let secondTitle            = UIFont.poppinBoldFont(withSize: CGFloat(size))
        let nameAttribute       = [ NSAttributedString.Key.font: secondTitle, NSAttributedString.Key.foregroundColor: UIColor.init(red: 0.31, green: 0.31, blue: 0.31, alpha: 1.0)]
        let activityAttrString  = NSAttributedString(string: text2, attributes: nameAttribute)
        
        nameAttrString.append(activityAttrString)
        return nameAttrString
    }
    
    func showAlerts(_ title: String, _ message: String, _ completionHandler: @escaping() -> ())
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
            
            completionHandler()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func backPressed(_ sender: UIButton){
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func menuPressed(_ sender: UIButton)
    {
        let sideMenuVC                      = SideMenuViewController(nibName: "SideMenuViewController", bundle: nil)
        sideMenuVC.modalPresentationStyle   = .overFullScreen
        sideMenuVC.fromVC = self
        self.present(sideMenuVC, animated: false, completion: nil)
    }
    
}
