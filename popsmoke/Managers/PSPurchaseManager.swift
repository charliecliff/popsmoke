//
//  PSPurchaseManager.swift
//  Reki
//
//  Created by Charles Cliff on 9/18/16.
//  Copyright © 2016 Reki. All rights reserved.
//

import StoreKit
import RxSwift
import RxCocoa

let PSPurchaseManagerPurchaseNotification = "PSPurchaseManagerPurchaseNotification"

let kIndividualLicenseProductID = "product_001"

public typealias ProductIdentifier = String
public typealias ProductsRequestCompletionHandler = (_ success: Bool, _ products: [SKProduct]?) -> ()

class PSPurchaseManager: NSObject {
	
	static let sharedInstance = PSPurchaseManager()

	private(set) var license = PSLicense()
	fileprivate var products = [SKProduct]()
	fileprivate var productIdentifiers = Set<ProductIdentifier>()
	fileprivate var productsRequestCompletionHandler: ProductsRequestCompletionHandler?
	fileprivate var productsRequest: SKProductsRequest?
	
	override init() {
		super.init()
		loadLicese()
		productIdentifiers = PSPurchaseManager.availableProductIdentifiers()
		SKPaymentQueue.default().add(self)
		requestProducts { (success, products) in
			if (success && products != nil) {
				self.products = products!
			}
		}
	}
	
	private class func availableProductIdentifiers() -> Set<ProductIdentifier> {
		let productIDs: Set<ProductIdentifier> = [kIndividualLicenseProductID]
		return productIDs
	}
	
	private func requestProducts(completionHandler: @escaping ProductsRequestCompletionHandler) {
		productsRequest?.cancel()
		productsRequestCompletionHandler = completionHandler
		productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
		productsRequest!.delegate = self
		productsRequest!.start()
	}

	private func buyProduct(_ product: SKProduct) {
		let payment = SKPayment(product: product)
		SKPaymentQueue.default().add(payment)
	}
	
	fileprivate func clearRequestAndHandler() {
		productsRequest = nil
		productsRequestCompletionHandler = nil
	}
	
	// MARK: - Persistence
	
	fileprivate func saveLicense() {
		PSPersistenceManager.save(license: license)
	}
	
	fileprivate func loadLicese() {
		do {
			let localLicense = try PSPersistenceManager.loadLicense()
			license = localLicense!
		} catch PersistenceError.userPersistence {
			
		} catch {
			PSErrorHandler.presentErrorWith(title: "Whoops!", message: "We had trouble loading your profile")
		}
	}
	
	class func canMakePayments() -> Bool {
		return SKPaymentQueue.canMakePayments()
	}
  
	class func restorePurchases() {
		SKPaymentQueue.default().restoreCompletedTransactions()
	}
	
	func buyIndividualLicense() {
		guard let individualLicenseProduct = products.first(where: { $0.productIdentifier == kIndividualLicenseProductID }) else {
			// TODO: Handle the Error
			return
		}
		buyProduct(individualLicenseProduct)
	}
	
	func buyProduct(productID: String) {
		guard let individualLicenseProduct = products.first(where: { $0.productIdentifier == productID }) else {
			// TODO: Handle the Error
			return
		}
		buyProduct(individualLicenseProduct)
	}
}

// MARK: - SKProductsRequestDelegate

extension PSPurchaseManager: SKProductsRequestDelegate {
	
	func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
		let products = response.products
		productsRequestCompletionHandler?(true, products)
		clearRequestAndHandler()
	}
	
	func request(_ request: SKRequest, didFailWithError error: Error) {
		productsRequestCompletionHandler?(false, nil)
	    clearRequestAndHandler()
	}
}

// MARK: - SKPaymentTransactionObserver
 
extension PSPurchaseManager: SKPaymentTransactionObserver {
 
	public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
		for transaction in transactions {
			switch (transaction.transactionState) {
			case .purchased:
				complete(transaction: transaction)
				break
			case .failed:
				fail(transaction: transaction)
				break
			case .restored:
				restore(transaction: transaction)
				break
			case .deferred:
				break
			case .purchasing:
				break
			}
		}
	}
 
	private func complete(transaction: SKPaymentTransaction) {
		deliverPurchaseFor(identifier: transaction.payment.productIdentifier)
		SKPaymentQueue.default().finishTransaction(transaction)
	}
 
	private func restore(transaction: SKPaymentTransaction) {
		guard let productIdentifier = transaction.original?.payment.productIdentifier else {
			return
		}
 		deliverPurchaseFor(identifier: productIdentifier)
		SKPaymentQueue.default().finishTransaction(transaction)
	}
 
	private func fail(transaction: SKPaymentTransaction) {
		if let transactionError = transaction.error as? NSError {
			if transactionError.code != SKError.paymentCancelled.rawValue {
				print("Transaction Error: \(transaction.error?.localizedDescription)")
			}
		}
		SKPaymentQueue.default().finishTransaction(transaction)
	}
 
	private func deliverPurchaseFor(identifier: String?) {
		guard let identifier = identifier else {
			return
		}
		if identifier == kIndividualLicenseProductID {
			license.didPurchaseIndividualLicense()
		}
		saveLicense()
	}
}

extension PSPurchaseManager: PSPermissions {
	
	func allowedToCreatePacket() -> Bool {
		return (license.type() != LicenseType.none)
	}
}
