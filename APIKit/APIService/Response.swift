//
//  Response.swift
//  APIKit
//
//  Created by MisnikovRoman on 06/04/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

public struct Response {
	public let statusCode: Int
	public let headers: [AnyHashable: Any]
	public let body: Data?

	public init(statusCode: Int, headers: [AnyHashable: Any], body: Data? ) {
		self.statusCode = statusCode
		self.headers = headers
		self.body = body
	}

	public init?(response: URLResponse, data: Data?) {
		guard let response = response as? HTTPURLResponse else { return nil }
		self.init(statusCode: response.statusCode, headers: response.allHeaderFields, body: data)
	}
}
