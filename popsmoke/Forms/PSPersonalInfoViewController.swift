//
//  PSPersonalInfoViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/14/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Eureka

class PSPersonalInfoViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		PSPersonalInfoFormFactory.appendPersonalInformationToForm(form: form)
    }
	
}
