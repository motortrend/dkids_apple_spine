//
//  Logging.swift
//  Spine
//
//  Created by Ward van Teijlingen on 05-04-15.
//  Copyright (c) 2015 Ward van Teijlingen. All rights reserved.
//

import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


public enum LogLevel: Int {
	case debug = 0
	case info = 1
	case warning = 2
	case error = 3
	case none = 4
	
	var description: String {
		switch self {
		case .debug:   return "Debug   "
		case .info:    return "Info    "
		case .warning: return "Warning "
		case .error:   return "Error   "
		case .none:    return "None    "
		}
	}
}

private var logLevel: LogLevel = .none

/// Extension regarding logging.
extension Spine {
	public static var logger: Logger = ConsoleLogger()
	
	public class func setLogLevel(_ level: LogLevel) {
		logLevel = level
	}
	
	class func shouldLog(_ level: LogLevel) -> Bool {
		return (level.rawValue >= logLevel.rawValue)
	}

	class func logDebug<T>(_ object: T) {
		if shouldLog(.debug) {
			logger.log(object, level: .debug)
		}
	}
	
	class func logInfo<T>(_ object: T) {
		if shouldLog(.info) {
			logger.log(object, level: .info)
		}
	}
	
	class func logWarning<T>(_ object: T) {
		if shouldLog(.warning) {
			logger.log(object, level: .warning)
		}
	}
	
	class func logError<T>(_ object: T) {
		if shouldLog(.error) {
			logger.log(object, level: .error)
		}
	}
}

public protocol Logger {
	/// Logs the textual representations of `object`.
	func log<T>(_ object: T, level: LogLevel)
}

/// Logger that logs to the console using the Swift built in `print` function.
struct ConsoleLogger: Logger {
	func log<T>(_ object: T, level: LogLevel) {
		print("\(level.description) - \(object)")
	}
}
