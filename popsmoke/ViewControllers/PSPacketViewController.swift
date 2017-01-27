//
//  PSPacketCollectionViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/24/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

fileprivate let minSpacing			= CGFloat(0)
fileprivate let sectionInsets		= UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
fileprivate let cellReuseIdentifier	= "document_cell"

class PSPacketViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	private var packet: PSPacket?
	private var widthPerItem  = CGFloat(0)
	private var heightPerItem = CGFloat(0)
	@IBOutlet weak var submitButton: UIButton?
	@IBOutlet weak var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
		let documentNib = UINib(nibName: "PSDocumentCollectionViewCell", bundle:nil)
		self.collectionView?.register(documentNib, forCellWithReuseIdentifier: cellReuseIdentifier)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if packet != nil {
			submitButton?.isHidden = !(packet!.isCompleted())
		} else {
			submitButton?.isHidden = true
		}
		self.collectionView?.reloadData()
	}
	
	// MARK: Setting the Packet Data
	
	func set(packetType: PacketType) {
		switch packetType {
		case .leave:
			self.loadPacketFileFor(name: "DA31_Packet")
		default:
			return
		}
	}
	
	private func loadPacketFileFor(name: String) {
		guard let path = Bundle.main.path(forResource: name, ofType:"plist") else {
			return
		}
		guard let packetDictionary = NSDictionary(contentsOfFile:path) as? [String : Any?] else {
			return
		}
		packet = PSPacket.init(dictionary: packetDictionary)
		self.collectionView?.reloadData()
	}
	
	// MARK: Actions

	@IBAction func didPressSettingButton(sender: UIButton) {
		NotificationCenter.default.post(name: NOTIFICATION_TOGGLE_NAV_DRAWER, object: nil)
	}

	@IBAction func didPressHistoryButton(sender: UIButton) {
		
		
	}
	
	@IBAction func didPressSubmitButton(sender: UIButton) {
		
		guard packet != nil else {
			return
		}
		let mailComposer = PSMailComposerFactory.mailComposerFor(packet: packet!)
		present(mailComposer, animated: true, completion: nil)
	}
	
    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard packet != nil else {
			return 0
		}
        return packet!.documents.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let index = indexPath.item
		guard let document = packet?.documents[index] else {
			let errorCell = UICollectionViewCell()
			errorCell.backgroundColor = .red
			return errorCell
		}
		guard let documentCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? PSDocumentCollectionViewCell else {
			let errorCell = UICollectionViewCell()
			errorCell.backgroundColor = .red
			return errorCell
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
			//TODO: Handle the errors in a global error alert
			return
		}
		guard let vc = PSDocumentViewFactory.documentView(forDocument: cell.document) else {
			//TODO: Handle the errors in a global error alert
			return
		}
		segueTo(viewController: vc)
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
}
