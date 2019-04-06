//
//  RequestBuilder.swift
//  APIKit
//
//  Created by MisnikovRoman on 06/04/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

class RequestBuilder {
	func build(from request: Request) -> URLRequest? {
		// базовый URL
		guard let url = URL(string: request.baseUrl + request.urlPath),
			var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
			else { return nil }

		// добавление параметров к URL
		urlComponents.queryItems = request.params.map({
			URLQueryItem(name: $0.key, value: $0.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
		})

		// формирование запроса
		guard let fullUrl = urlComponents.url else { return nil }
		var urlRequest = URLRequest(url: fullUrl)

		// выбор типа запроса
		urlRequest.httpMethod = request.type.rawValue

		// добавление данных в запрос
		if let data = request.body?.toJSON() {
			urlRequest.httpBody = data
		}

		// добавление хедеров
		request.headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }

		return urlRequest
	}
}
