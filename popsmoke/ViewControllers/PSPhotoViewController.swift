//
//  PSPhotoViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/25/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

class PSImagePickerController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	weak var document: PSDocument?
	
	// MARK: - UIImagePickerControllerDelegate
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		guard let chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
			return
		}
		let filePath = PSPersistenceManager.newPNGFilePath()
		do {
			try PSPersistenceManager.save(image: chosenImage, fileName: filePath!)
		} catch PersistenceError.packetPersistence {
			print("Invalid Selection.")
		} catch {
			print("Invalid Selection.")
		}
		document?.filePath = filePath
		dismiss(animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
}
