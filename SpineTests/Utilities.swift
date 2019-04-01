//
//  Utilities.swift
//  Spine
//
//  Created by Ward van Teijlingen on 19-02-15.
//  Copyright (c) 2015 Ward van Teijlingen. All rights reserved.
//

import Foundation
import XCTest
import SwiftyJSON

extension XCTestCase {
	
	func JSONFixtureWithName(_ name: String) -> (data: Data, json: JSON) {
		let path = Bundle(for: type(of: self)).url(forResource: name, withExtension: "json")!
		let data = try! Data(contentsOf: path)
		let json = (try? JSON(data: data)) ?? JSON(NSNull())
		return (data: data, json: json)
	}
}

func ISO8601FormattedDate(_ date: Date) -> String {
	let dateFormatter = DateFormatter()
	let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
	dateFormatter.locale = enUSPosixLocale
	dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
	
	return dateFormatter.string(from: date)
}

// MARK: - Custom assertions

func assertFooResource(_ foo: Foo, isEqualToJSON json: JSON) {
	XCTAssertEqual(foo.stringAttribute!, json["attributes"]["string-attribute"].stringValue, "Deserialized string attribute is not equal.")
	XCTAssertEqual(foo.integerAttribute?.intValue, json["attributes"]["integer-attribute"].intValue, "Deserialized integer attribute is not equal.")
	XCTAssertEqual(foo.floatAttribute?.floatValue, json["attributes"]["float-attribute"].floatValue, "Deserialized float attribute is not equal.")
	XCTAssertEqual(foo.booleanAttribute?.boolValue, json["attributes"]["integer-attribute"].boolValue, "Deserialized boolean attribute is not equal.")
	XCTAssertNil(foo.nilAttribute, "Deserialized nil attribute is not equal.")
	XCTAssertEqual(foo.dateAttribute! as Date, Date(timeIntervalSince1970: 0), "Deserialized date attribute is not equal.")
}
