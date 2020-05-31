//
//  ViewController.swift
//  Filterer
//
//  Created by Mohammed Rishan on 29/05/20.
//  Copyright © 2020 Mohammed Rishan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var filterImages: UIImage?
    var commonImage: UIImage?
    var compareImage: UIImage?
    
    var isChecked = false
    
    @IBOutlet weak var filterImage: UIImageView!
    
    @IBOutlet weak var newPhotoBtn: UIButton!
    @IBOutlet weak var secondMenuBtn: UIButton!
    @IBOutlet weak var compareBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet var secondaryMenuView: UIView!
    @IBOutlet weak var bottomMenuView: UIView!
    
    //MARK:- PrimaryView Buttons
    
    @IBAction func newPhotoBtnAction(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "ArialHebrew-Bold", size: 18.0)!]
        
        let titleAttrString = NSMutableAttributedString(string: "Select One", attributes: titleFont)
        
        actionSheet.setValue(titleAttrString, forKey: "attributedTitle")
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: { (action) in
            self.showAlbum()
        }))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func secondaryFilterAction(_ sender: UIButton) {
        
        secondaryMenuView.isHidden = false
        
        if (sender.isSelected) {
            hideSecondaryMenu()
            sender.isSelected = false
        }else {
            showSecondaryMenu()
            sender.isSelected = true
        }
    }
    
    @IBAction func compareBtnActions(_ sender: UIButton) {
        
         compareImage = commonImage
    
        if !isChecked {
           filterImage.image = commonImage
           isChecked = true
        } else {
            filterImage.image = filterImages
            isChecked = false
        }
        
    }
    
    @IBAction func shareBtnAction(_ sender: UIButton) {
        
        let activityController = UIActivityViewController(activityItems: ["Image to share",filterImage.image!], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
        
    }
    
    //MARK:- Filter Image
    
    @IBAction func redFilterBtn(_ sender: UIButton) {
        
        secondaryMenuView.isHidden = true
        
        let rgbImage = RGBAImage(image: commonImage!)
        
        let avgRed = 107
        
        for y in 0..<rgbImage!.height {
            for x in 0..<rgbImage!.width {
                let index = y * rgbImage!.width + x
                
                var pixel = rgbImage?.pixels[index]
                
                let redDelta = Int(pixel!.red) - avgRed
                
                var modifier = 1 + 4 * (Double(y) / Double(rgbImage!.height))
                if (Int(pixel!.red) < avgRed) {
                    modifier = 1
                }
                pixel!.red = UInt8(max(min(255, Int(round(Double(avgRed) + modifier * Double(redDelta)))), 0))
                rgbImage!.pixels[index] = pixel!
            }
        }
        filterImage.image = rgbImage!.toUIImage()!
        filterImages = filterImage.image
    }
    
    @IBAction func greenFilterBtn(_ sender: UIButton) {
        
        secondaryMenuView.isHidden = true
        
        let rgbImage = RGBAImage(image: commonImage!)
        
        let avgGreen = 75
        
        for y in 0..<rgbImage!.height {
            for x in 0..<rgbImage!.width {
                let index = y * rgbImage!.width + x
                
                var pixel = rgbImage?.pixels[index]
                
                let greenDelta = Int(pixel!.green) - avgGreen
                
                var modifier = 1 + 4 * (Double(y) / Double(rgbImage!.height))
                if (Int(pixel!.green) < avgGreen) {
                    modifier = 1
                }
                pixel!.green = UInt8(max(min(255, Int(round(Double(avgGreen) + modifier * Double(greenDelta)))), 0))
                rgbImage!.pixels[index] = pixel!
            }
        }
        filterImage.image = rgbImage!.toUIImage()!
        filterImages = filterImage.image

    }
    
    @IBAction func blueFilterBtn(_ sender: UIButton) {
        
        secondaryMenuView.isHidden = true
        
        let rgbImage = RGBAImage(image: commonImage!)
        
        let avgBlue = 105
        
        for y in 0..<rgbImage!.height {
            for x in 0..<rgbImage!.width {
                let index = y * rgbImage!.width + x
                
                var pixel = rgbImage?.pixels[index]
                
                let blueDelta = Int(pixel!.blue) - avgBlue
                
                var modifier = 1 + 4 * (Double(y) / Double(rgbImage!.height))
                if (Int(pixel!.blue) < avgBlue) {
                    modifier = 1
                }
                pixel!.green = UInt8(max(min(255, Int(round(Double(avgBlue) + modifier * Double(blueDelta)))), 0))
                rgbImage!.pixels[index] = pixel!
            }
        }
        filterImage.image = rgbImage!.toUIImage()!
        filterImages = filterImage.image

    }
    
    @IBAction func yellowFilterBtn(_ sender: UIButton) {
        
        secondaryMenuView.isHidden = true
        
        let rgbImage = RGBAImage(image: commonImage!)
        
        let avgRed = 0
        let avgGreen = 0
        
        for y in 0..<rgbImage!.height {
            for x in 0..<rgbImage!.width {
                let index = y * rgbImage!.width + x
                var pixel = rgbImage!.pixels[index]
                
                let redDiff = Int(pixel.red) - avgRed
                let greenDiff = Int(pixel.green) - avgGreen
                if (redDiff>0 && greenDiff>0) {
                    pixel.red = UInt8( max(0, min(255, avgRed + redDiff*5) ) )
                    pixel.green = UInt8( max(0, min(255, avgGreen + greenDiff*2) ) )
                    rgbImage!.pixels[index] = pixel
                }
            }
        }
        filterImage.image = rgbImage!.toUIImage()!
        filterImages = filterImage.image

    }
    
    @IBAction func purpleFilterBtn(_ sender: UIButton) {
        
        secondaryMenuView.isHidden = true
        
        let rgbImage = RGBAImage(image: commonImage!)
        
        let avgRed = 0
        let avgGreen = 0
        let avgBlue = 120
        
        for y in 0..<rgbImage!.height {
            for x in 0..<rgbImage!.width {
                let index = y * rgbImage!.width + x
                var pixel = rgbImage!.pixels[index]
                
                let redDiff = Int(pixel.red) - avgRed
                let greenDiff = Int(pixel.red) - avgGreen
                let blueDiff = Int(pixel.blue) - avgBlue
                if (redDiff>0 && greenDiff>0 && blueDiff>0) {
                    pixel.red = UInt8( max(255, min(90, avgRed + redDiff*5) ) )
                    pixel.green = UInt8( max(0, min(90, avgGreen + greenDiff*3) ) )
                    pixel.blue = UInt8( max(0, min(70, avgBlue + blueDiff*5) ) )
                    rgbImage!.pixels[index] = pixel
                }
            }
        }
        filterImage.image = rgbImage!.toUIImage()!
        filterImages = filterImage.image

    }
    
    //MARK:- Show Camera and Album
    
    func showCamera() {
        
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        self.present(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .photoLibrary
        self.present(cameraPicker, animated: true, completion: nil)
    }
    
    //MARK:- ImagePicker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            filterImage.image = image
            commonImage = filterImage.image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Constrains to SecondaryViews
    
    func showSecondaryMenu()  {
        view.addSubview(secondaryMenuView)
        
        let bottomConstraint = secondaryMenuView.bottomAnchor.constraint(equalTo: bottomMenuView.topAnchor)
        
        let leftConstraint = secondaryMenuView.leftAnchor.constraint(equalTo: view.leftAnchor)
        
        let rightConstraint = secondaryMenuView.rightAnchor.constraint(equalTo: view.rightAnchor)
        
        let heightConstraint = secondaryMenuView.heightAnchor.constraint(equalToConstant: 44.0)
        
        NSLayoutConstraint.activate([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        self.secondaryMenuView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.secondaryMenuView.alpha = 1.0
        }
    }
    
    //MARK:- Hide unHide SecondaryView
    
    func hideSecondaryMenu() {
        
        UIView.animate(withDuration: 0.4, animations: {
            self.secondaryMenuView.alpha = 0
        }) { completed in
            if completed == true {
            self.secondaryMenuView.removeFromSuperview()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        secondaryMenuView.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        secondaryMenuView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if filterImage.image == nil {
            secondMenuBtn.isEnabled = false
            compareBtn.isEnabled = false
            shareBtn.isEnabled = false
        }else{
            secondMenuBtn.isEnabled = true
            compareBtn.isEnabled = true
            shareBtn.isEnabled = true
        }
    }
}

