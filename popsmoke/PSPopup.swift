//
//  PSPopup.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/20/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

fileprivate let titleKey	= "title"
fileprivate let lineOneKey	= "lineOne"
fileprivate let iconKey		= "icon"

class PSPopup: NSObject {

	fileprivate static let sharedInstance = PSPopup()
	fileprivate var popup : HROPopupController?

	class func displayPurchasePopup(productID: String) {
		PSPopup.sharedInstance.popup = PSPopup.createPurchasePopup(productID: productID)
		PSPopup.sharedInstance.popup?.present(animated: true)
	}
	
	class func dismissPopup() {
		DispatchQueue.main.async {
			PSPopup.sharedInstance.popup?.dismiss(animated: true)
			PSPopup.sharedInstance.popup = nil
		}
	}
	
	fileprivate class func createPurchasePopup(productID: String) -> HROPopupController {
		
		let path = Bundle.main.path(forResource: "Product Data", ofType: "plist")
		guard let dict = NSDictionary(contentsOfFile: path!) as? [String: AnyObject] else {
			let popup = HROPopupController.init(contents: [])
			return popup
		}
		
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineBreakMode = .byWordWrapping
		paragraphStyle.alignment = .center
		
		var titleString = "You are about to make a purchase"
		if (dict[titleKey] as? String) != nil {
			titleString = (dict[titleKey] as? String)!
		}
		let title = NSAttributedString.init(string: titleString,
		                                    attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 24.0),NSParagraphStyleAttributeName : paragraphStyle])
		
		var lineOneString = ""
		if (dict[lineOneKey] as? String) != nil {
			lineOneString = (dict[lineOneKey] as? String)!
		}
		let lineOne = NSAttributedString.init(string: lineOneString,
		                                    attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 18.0),NSParagraphStyleAttributeName : paragraphStyle])
		var imageString = ""
		if (dict[iconKey] as? String) != nil {
			imageString = (dict[iconKey] as? String)!
		}
		
		let titleLabel = UILabel()
		titleLabel.numberOfLines = 0
		titleLabel.attributedText = title
		
		let lineOneLabel = UILabel()
		lineOneLabel.numberOfLines = 0
		lineOneLabel.attributedText = lineOne
		
		let imageView = UIImageView.init(image: UIImage.init(named: imageString))
		
		let spacerView = UIView.init(frame: CGRect(x:0, y:0, width:250, height:55))
		spacerView.backgroundColor = .clear
		
		let buttonView = PSPopup.buttonViewFor(productID: productID)
		
		let popup = HROPopupController.init(contents: [titleLabel, lineOneLabel, imageView, spacerView, buttonView])
		popup.theme = HROPopupTheme.default()
		return popup
	}

	fileprivate class func buttonViewFor(productID: String) -> UIView {
		let buttonContainer = UIView.init(frame: CGRect(x:0, y:0, width:200, height:60))
		buttonContainer.backgroundColor = .clear
		let cancelButton	= PSPopup.cancelButton()
		let purchaseButton	= PSPopup.purchaseButtonViewFor(productID: productID)
		buttonContainer.addSubview(cancelButton)
		buttonContainer.addSubview(purchaseButton)
		return buttonContainer
	}
	
	fileprivate class func purchaseButtonViewFor(productID: String) -> UIView {
		let purchaseButton = HROPopupButton.init(frame: CGRect(x:100, y:0, width:100, height:60))
		purchaseButton.setTitleColor(.black, for: .normal)
		purchaseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		purchaseButton.setTitle("OK", for: .normal)
		purchaseButton.backgroundColor = .clear
		purchaseButton.layer.cornerRadius = 4
		purchaseButton.selectionHandler = {(_ button: HROPopupButton) -> Void in
			PSPurchaseManager.sharedInstance.buyProduct(productID: productID)
			PSPopup.dismissPopup()
		}
		return purchaseButton
	}
	
	fileprivate class func cancelButton() -> UIView {
		let cancelButton = HROPopupButton.init(frame: CGRect(x:0, y:0, width:100, height:60))
		cancelButton.setTitleColor(.black, for: .normal)
		cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		cancelButton.setTitle("CANCEL", for: .normal)
		cancelButton.backgroundColor = .clear
		cancelButton.layer.cornerRadius = 4
		cancelButton.selectionHandler = {(_ button: HROPopupButton) -> Void in
			PSPopup.dismissPopup()
		}
		return cancelButton
	}
}
