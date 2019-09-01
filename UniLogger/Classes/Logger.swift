//
//  Logger.swift
//  Identity
//
//  Created by Rubén Vázquez Otero on 17/08/2019.
//

import Foundation
import BugfenderSDK

public class Logger {
	
	public static var instance = Logger(consoleEnabled: true, bugfenderEnabled: true)
	
	var consoleEnabled: Bool
	var bugfenderEnabled: Bool
	
	public init(consoleEnabled: Bool = false, bugfenderEnabled: Bool = false) {
		self.consoleEnabled = consoleEnabled
		self.bugfenderEnabled = bugfenderEnabled
	}
	
	public func logRequestResult(request: URLRequest, response: URLResponse?, data: Data?) {
		if (!consoleEnabled) { return }
		
		// Request Logging
		log("Request to: \(request.url!)")
		log("Method: \(request.httpMethod!)")
		if let bodyData = request.httpBody,
			let bodyString = String(data: bodyData, encoding: .utf8) {
			log("Request body: \(bodyString)")
		}
		
		// Headers
		if let headers = request.allHTTPHeaderFields{
			log("Headers: [")
			for header in headers {
				log("\(header.key) \(header.value)")
			}
			log("]")
		}
		
		// Response logging
		if let r = response as? HTTPURLResponse {
			log("Response code: \(r.statusCode)")
		}
		
		// Data logging
		if let d = data {
			if let responseToString = String(data: d, encoding: .utf8) {
				log ("Response body: \(responseToString)")
			}
		}
	}
	
	public func log(_ log: String) {
		if (consoleEnabled) {
			print(log)
		}
		
		if bugfenderEnabled {
			Bugfender.setPrintToConsole(false)
			BFLog(log)
		}
	}
}
