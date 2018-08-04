//
//  UserService.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation
import Moya

/// UserService
///
/// - all: get all users.
/// - saveInfo: save info for a user from an auth result.
/// - clearPoints: clear points for a user.
/// - submitAnswer: submit an answer for a question.
enum UserService {
	case all
	case saveInfo(authResult: AuthResult)
	case clearPoints(userId: String, token: String)
	case submitAnswer(questionId: String, score: Int, userId: String, token: String)
}

extension UserService: TargetType {

	var baseURL: URL {
		return URL(string: "https://ios-trivia.firebaseio.com")!
	}

	var path: String {
		switch self {
		case .all:
			return "users.json"

		case .saveInfo(let authResult):
			return "users/\(authResult.localId).json"

		case .clearPoints(let userId, _):
			return "users/\(userId)/points.json"

		case .submitAnswer(_, _, let userId, _):
			return "users/\(userId)/points.json"
		}
	}

	var method: Moya.Method {
		switch self {
		case .all:
			return .get

		case .clearPoints:
			return .delete

		case .saveInfo,
			 .submitAnswer:
			return .patch
		}
	}

	var task: Task {
		switch self {
		case .all:
			return .requestPlain

		case .saveInfo(let authResult):
			let bodyParameters = ["email": authResult.email, "id": authResult.localId]
			return .requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: JSONEncoding.default, urlParameters: API.authParameters(for: authResult.idToken))

		case .clearPoints(_, let token):
			return .requestParameters(parameters: API.authParameters(for: token), encoding: URLEncoding.queryString)

		case .submitAnswer(let questionId, let score, _, let token):
			let bodyParameters = [questionId: score]
			return .requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: JSONEncoding.default, urlParameters: API.authParameters(for: token))
		}
	}

	var headers: [String: String]? { return nil }
	var sampleData: Data { return "".utf8Encoded }

}
