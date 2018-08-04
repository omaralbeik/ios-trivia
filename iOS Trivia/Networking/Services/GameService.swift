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
enum GameService {
	case question(id: Int)
}

extension GameService: TargetType {

	var baseURL: URL {
		return URL(string: "https://ios-trivia.firebaseio.com")!
	}

	var path: String {
		switch self {
		case .question(let id):
			return "questions/q\(id).json"
		}
	}

	var method: Moya.Method {
		switch self {
		case .question:
			return .get
		}
	}

	var task: Task {
		switch self {
		case .question:
			return .requestPlain
		}
	}

	var headers: [String: String]? { return nil }
	var sampleData: Data { return "".utf8Encoded }

}
