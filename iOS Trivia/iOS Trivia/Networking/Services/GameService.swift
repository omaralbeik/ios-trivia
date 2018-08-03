//
//  GameService.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation
import Moya

/// GameService
///
/// - question: get question.
public enum GameService {
	case question(id: Int)
}

extension GameService: TargetType {

	public var baseURL: URL {
		return URL(string: "https://ios-trivia.firebaseio.com")!
	}

	public var path: String {
		switch self {
		case .question(let id):
			return "questions/q\(id).json"
		}
	}

	public var method: Moya.Method {
		switch self {
		case .question:
			return .get
		}
	}

	public var task: Task {
		switch self {
		case .question:
			return .requestPlain
		}
	}

	public var headers: [String: String]? { return nil }
	public var sampleData: Data { return "".utf8Encoded }

}
