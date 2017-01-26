//
//  PSPhotoViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/25/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

class PSPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet public var attachmentImageView: UIImageView?
	@IBOutlet public var cameraButton: UIButton?
	@IBOutlet public var photoLibraryButton: UIButton?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		attachmentImageView?.isHidden = true
	}
	
	@IBAction func didSelectPhotoSelectionButton(_ sender: UIButton) {
		
		let pickerVC = UIImagePickerController.init()
		pickerVC.delegate = self
		pickerVC.allowsEditing = true
		pickerVC.sourceType =  UIImagePickerControllerSourceType.photoLibrary
		present(pickerVC, animated: true, completion: nil)
	}
	
	@IBAction func didSelectCameraButton(_ sender: UIButton) {

		let cameraVC = UIImagePickerController.init()
		cameraVC.delegate = self
		cameraVC.allowsEditing = true
		cameraVC.sourceType =  UIImagePickerControllerSourceType.camera
		present(cameraVC, animated: true, completion: nil)
	}

	// MARK: - UIImagePickerControllerDelegate
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		
		guard let chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
			return
		}
		attachmentImageView?.image = chosenImage
		attachmentImageView?.isHidden = true
		dismiss(animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		
		dismiss(animated: true, completion: nil)
	}
}
