//
//  ViewController.swift
//  JSONPlaceholderExample
//
//  Created by MisnikovRoman on 06/04/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

import UIKit
import APIKit

struct Post: Codable {
	let userId: Int
	let id: Int
	let title: String
	let body: String
}

extension Post: CustomStringConvertible {
	var description: String {
		return """
		Post \(id) from \(userId)
		\(title)
		\(body)
		"""
	}
}

class ViewController: UIViewController {

	@IBOutlet weak var urlTextField: UITextField!
	@IBOutlet weak var resultTextView: UITextView!
	@IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

	private let api: IApiService = ApiService()

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func loadButtonTap(_ sender: Any) {
		loadDataFromUrl(url: getUrl())
	}
}

private extension ViewController {
	func loadDataFromUrl(url: String) {
		startLoading()

		api.getData(from: url, as: [Post].self){ [weak self] result in
			DispatchQueue.main.async {
				self?.stopLoading()
				switch result {
				case .success(let posts):
					self?.show(posts)
				case .failure(let error):
					self?.showAlert(with: error.localizedDescription)
				}
			}
		}
	}

	func startLoading() {
		loadingIndicator.isHidden = false
		loadingIndicator.startAnimating()
	}

	func stopLoading() {
		loadingIndicator.isHidden = true
		loadingIndicator.stopAnimating()
	}

	func getUrl() -> String {
		return urlTextField.text ?? ""
	}

	func show(_ posts: [Post]) {
		resultTextView.isHidden = false
		var text = ""
		posts.forEach { text.append(contentsOf: $0.description + "\n\n") }
		resultTextView.text = text
	}

	func showAlert(with text: String) {
		let alert = UIAlertController(title: "⚠️ Ошибка", message: text, preferredStyle: .alert)
		let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
}

