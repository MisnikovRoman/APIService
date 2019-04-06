//
//  APIService.swift
//  APIKit
//
//  Created by MisnikovRoman on 06/04/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

public protocol IApiService {
	/// Отправляет запрос в сеть с указанными параметрами
	///
	/// - Parameters:
	///   - request: Параметры запроса
	///   - completion: Callback с результатом выполнения запроса
	func send(_ request: Request, completion: @escaping (Result<Response,Error>)->())

	/// Простая загрузка данных из сети и преобразование в собственную модель
	///
	/// - Parameters:
	///   - Type: Тип модели, которую необходимо загрузить
	///   - resource: Тестовая ссылка для загрузки данных
	///   - completion: Callback с результатом выполнения загрузки данных
	func getData<T: Decodable>(from resource: String, as Type: T.Type, completion: @escaping (Result<T, Error>)->())

	func test()
}

public class ApiService: IApiService {
	public init() {}

	public func test() {}

	public func send(_ request: Request, completion: @escaping (Result<Response,Error>) -> ()) {
		print("🌐 API Request: .\(request.type.rawValue), url: \(request.baseUrl + request.urlPath), parameters: \(request.params)" )

		guard let urlRequest = RequestBuilder().build(from: request) else { return }

		URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
			if let error = error {
				completion(.failure(error))
			}
			if let response = response,
				let simpleResponse = Response(response: response, data: data) {
				completion(.success(simpleResponse))
			}
		}.resume()
	}

	func cancel() {
		assertionFailure("Нет реализации")
	}


	struct Test: Decodable {
		let a: String
	}

	public func getData<T: Decodable>(from resource: String, as Type: T.Type, completion: @escaping (Result<T, Error>)->()) {
		let simpleRequest = Request(type: .GET, url: resource)
		self.send(simpleRequest) { completion(ResultConverter.convert(response: $0, to: Type)) }
	}
}

