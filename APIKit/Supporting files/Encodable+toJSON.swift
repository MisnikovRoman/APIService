//
//  Encodable+toJSON.swift
//  APIKit
//
//  Created by MisnikovRoman on 06/04/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

extension Encodable {
	func toJSON() -> Data? {
		return try? JSONEncoder().encode(self)
	}
}
