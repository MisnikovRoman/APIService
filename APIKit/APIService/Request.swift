//
//  Request.swift
//  APIKit
//
//  Created by MisnikovRoman on 06/04/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

public enum HTTPRequest: String { case GET, PUT, POST, DELETE }

public struct Request {
	public let type: HTTPRequest
	public let baseUrl: String
	public let urlPath: String
	public let params: [String: String]
	public let headers: [String: String]
	public let body: Codable?

	public init(
		type: HTTPRequest,
		baseUrl: String,
		urlPath: String,
		params: [String: String],
		headers: [String: String],
		body: Codable?
	){
		self.type = type
		self.baseUrl = baseUrl
		self.urlPath = urlPath
		self.params = params
		self.headers = headers
		self.body = body
	}

	public init(type: HTTPRequest, url: String) {
		self.init(type: type, baseUrl: url, urlPath: "", params: [:], headers: [:], body: nil)
	}
}
