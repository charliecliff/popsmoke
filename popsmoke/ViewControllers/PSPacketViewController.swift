//
//  PSPacketCollectionViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/24/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit
import MessageUI
import RxSwift
import RxCocoa

fileprivate let minSpacing			= CGFloat(0)
fileprivate let sectionInsets		= UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
fileprivate let cellReuseIdentifier	= "document_cell"

class PSPacketViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {

	private var widthPerItem  = CGFloat(0)
	@IBOutlet weak var submitButton: UIButton?
	@IBOutlet weak var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
		let documentNib = UINib(nibName: "PSDocumentCollectionViewCell", bundle:nil)
		self.collectionView?.register(documentNib, forCellWithReuseIdentifier: cellReuseIdentifier)

		// RXSWift Bindings
		_ = PSPacketManager.sharedInstance.reloadCurrentPacket.asObservable().subscribe(onNext: {
			if $0 {
				self.reloadFromManager()
			}
		})
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		reloadFromManager()
	}

	// MARK: - 
	
	func reloadFromManager() {
		submitButton?.isHidden = !PSPacketManager.sharedInstance.packet.isCompleted()
		self.collectionView?.reloadData()
	}
	
	// MARK: Actions

	@IBAction func didPressHistoryButton(sender: UIButton) {
		
	}
	
	@IBAction func didPressSubmitButton(sender: UIButton) {
		let mailComposer = PSMailComposerFactory.mailComposerFor(packet: PSPacketManager.sharedInstance.packet)
		mailComposer.mailComposeDelegate = self
		if( !MFMailComposeViewController.canSendMail() ) {
			PSErrorHandler.presentErrorWith(title: "Whoops!", message: "Cannot send email.")
			return
		}
		present(mailComposer, animated: true, completion: nil)
	}
	
    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PSPacketManager.sharedInstance.packet.documents.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let index = indexPath.item
		let document = PSPacketManager.sharedInstance.packet.documents[index]
		guard let documentCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? PSDocumentCollectionViewCell else {
			return UICollectionViewCell()
		}
		documentCell.configure(document: document)
		return documentCell
    }
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if (kind == UICollectionElementKindSectionHeader) {
			let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath)
			return headerView
		}
		if (kind == UICollectionElementKindSectionFooter) {
			let footerview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "FooterView", for: indexPath)
			return footerview
		}
		return UICollectionReusableView()
	}
	
	// MARK: - UICollectionViewDelegate
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cell = collectionView.cellForItem(at: indexPath) as? PSDocumentCollectionViewCell else {
			PSErrorHandler.presentErrorWith(title: "Whoops!", message: "We can't seem to instantiate a colleciton cell.")
			return
		}
		guard let vc = PSDocumentViewFactory.documentView(forDocument: cell.document) else {
			PSErrorHandler.presentErrorWith(title: "Whoops!", message: "Cannot seem to make a View for your Document.")
			return
		}
		if vc is PSImagePickerController {
			present(vc, animated: true, completion: nil)
			return
		}
		navigationController?.pushViewController(vc, animated: true)
	}
	
	// MARK: - UICollectionViewDelegateFlowLayout
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		guard let size = self.collectionView?.frame.size else {
			return CGSize(width: 50, height: 50)
		}
		let widthPerItem = (size.width - sectionInsets.right - 2*sectionInsets.left - minSpacing) / 2
		return CGSize(width: widthPerItem, height: widthPerItem)
	}
 
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return sectionInsets
	}
 
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return minSpacing
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
		return minSpacing
	}
	
	// MARK: - MFMailCompseViewControllerDelegate
	
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?){
		if error != nil {
			PSErrorHandler.presentError(error: error as NSError?)
		} else {
			PSPacketManager.sharedInstance.savePacket(packet: PSPacketManager.sharedInstance.packet)
		}
		controller.dismiss(animated: true, completion: nil)
	}
}
