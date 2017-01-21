//
//  DA31ViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/14/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Eureka

class DA31FormViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		form +++ Section() {
			$0.header = HeaderFooterView<EurekaLogoView>(.class)
		}
		
		DA31FormFactory.appendLeaveDetailsToForm(form: form)
		DA31FormFactory.appendPersonalInformationToForm(form: form)
		DA31FormFactory.appendAddressToForm(form: form)
		DA31FormFactory.appendStationToForm(form: form)
		DA31FormFactory.appendLeaveDaysToForm(form: form)
		DA31FormFactory.appendLeaveDatesToForm(form: form)
    }
}

class EurekaLogoView: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		let imageView = UIImageView(image: UIImage(named: "Eureka"))
		imageView.frame = CGRect(x: 0, y: 0, width: 320, height: 130)
		imageView.autoresizingMask = .flexibleWidth
		self.frame = CGRect(x: 0, y: 0, width: 320, height: 130)
		imageView.contentMode = .scaleAspectFit
		self.addSubview(imageView)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
