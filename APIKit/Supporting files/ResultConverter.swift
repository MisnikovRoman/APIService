//
//  ResultConverter.swift
//  APIKit
//
//  Created by MisnikovRoman on 06/04/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

class ResultConverter {

	/// Преобразовывает результат загрузки из сети к необходимому типу
	///
	/// - Parameter response: Данные полученые после выполнения APIService().send(response)
	/// - Returns: Загружаемая модель 
	static func convert<T: Decodable>(response: Result<Response,Error>, to type: T.Type) -> Result<T,Error> {
		switch response {
		case .success(let response):
			print("🌐 API Response: \(response.statusCode): \(Constant.HTTPStatusCodes[response.statusCode] ?? "Unknown error")")

			switch response.statusCode {
			case 200...299: break
			case 300...399: return .failure(NetworkError.responseRedirection)
			case 400...499: return .failure(NetworkError.responseClientError)
			case 500...599: return .failure(NetworkError.responseServerError)
			default: return .failure(NetworkError.otherResponseError)
			}

			guard let data = response.body else { return .failure(NetworkError.noData) }
			do {
				let output = try JSONDecoder().decode(type, from: data)
				return .success(output)
			} catch {
				return .failure(error)
			}
		case .failure(let error):
			return .failure(error)
		}
	}
}
