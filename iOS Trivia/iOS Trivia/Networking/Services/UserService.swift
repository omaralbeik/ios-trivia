//
//  UserService.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation
import Moya

public enum UserService {
	case all
	case saveEmail(authResult: AuthResult)
	case clearPoints(userId: String, token: String)
	case submitAnswer(questionId: String, score: Int, userId: String, token: String)
}

extension UserService: TargetType {

	public var baseURL: URL {
		return URL(string: "https://ios-trivia.firebaseio.com")!
	}

	public var path: String {
		switch self {
		case .all:
			return "users.json"

		case .saveEmail(let authResult):
			return "users/\(authResult.localId).json"

		case .clearPoints(let userId, _):
			return "users/\(userId)/points.json"

		case .submitAnswer(_, _, let userId, _):
			return "users/\(userId)/points.json"
		}
	}

	public var method: Moya.Method {
		switch self {
		case .all:
			return .get

		case .clearPoints:
			return .delete

		case .saveEmail,
			 .submitAnswer:
			return .patch
		}
	}

	public var task: Task {
		switch self {
		case .all:
			return .requestPlain

		case .saveEmail(let authResult):
			let bodyParameters = ["email": authResult.email, "id": authResult.localId]
			let urlParameters = ["auth": authResult.idToken]
			return .requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: JSONEncoding.default, urlParameters: urlParameters)

		case .clearPoints(_, let token):
			let urlParameters = ["auth": token]
			return .requestParameters(parameters: urlParameters, encoding: URLEncoding.queryString)

		case .submitAnswer(let questionId, let score, _, let token):
			let bodyParameters = [questionId: score]
			let urlParameters = ["auth": token]
			return .requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: JSONEncoding.default, urlParameters: urlParameters)
		}
	}

	public var headers: [String: String]? { return nil }
	public var sampleData: Data { return "".utf8Encoded }

}
