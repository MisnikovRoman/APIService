//
//  NetworkError.swift
//  APIKit
//
//  Created by MisnikovRoman on 06/04/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

enum NetworkError: LocalizedError {
	case noData
	case notFound
	case otherResponseError
	case responseRedirection
	case responseClientError
	case responseServerError

	var localizedDescription: String {
		switch self {
		case .noData: return "Нет данных в ответе от сервера"
		case .notFound: return "404. Данные не найдены"
		case .responseRedirection: return "Для продолжения необходимы дополнительные действия"
		case .responseClientError: return "Неверное составление запроса к серверу"
		case .responseServerError: return "Ошибка ответа сервера"
		case .otherResponseError: return "Получен статус код отличный от 200"
		}
	}

	var errorDescription: String? {
		return localizedDescription
	}
}
