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
		
		//DA31FormFactory.appendLeaveDetailsToForm(form: form)
		DA31FormFactory.appendPersonalInformationToForm(form: form)
		DA31FormFactory.appendAddressToForm(form: form)
		DA31FormFactory.appendStationToForm(form: form)
		DA31FormFactory.appendLeaveDaysToForm(form: form)
		DA31FormFactory.appendLeaveDatesToForm(form: form)
    }
}
