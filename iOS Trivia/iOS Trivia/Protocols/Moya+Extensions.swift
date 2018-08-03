//
//  Moya+Extensions.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation
import Moya
import Result

public extension MoyaProvider {

	public func request<T: Codable>(_ target: Target, dataType: T.Type, completion: @escaping (_ result: Result<T, APIError>) -> Void) {
		request(target) { result in
			switch result {
			case .failure(let error):
				completion(.failure(.error(error)))
			case .success(let response):
				guard let data = try? response.map(T.self, using: DefaultDecoder()) else {
					completion(.failure(.serverError(message: L10n.Api.Errors.serverError)))
					return
				}

				completion(.success(data))
			}
		}
	}

}
