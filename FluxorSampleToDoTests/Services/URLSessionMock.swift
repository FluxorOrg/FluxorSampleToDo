/*
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Foundation

public class URLProtocolMock: URLProtocol {
    public static var responseByPath: [String: (statusCode: Int, jsonBody: String)] = [:]

    public override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    public override func startLoading() {
        guard let (statusCode, jsonBody) = URLProtocolMock.responseByPath[request.url!.path],
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: statusCode,
                                           httpVersion: "1.1",
                                           headerFields: [:]),
            let data = jsonBody.data(using: .utf8) else {
            client?.urlProtocol(self, didFailWithError: URLError(.fileDoesNotExist))
            return
        }
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: data)
        client?.urlProtocolDidFinishLoading(self)
    }

    public override func stopLoading() {}
}

public extension URLSession {
    class var sessionWithMock: URLSession {
        let urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: urlSessionConfiguration)
    }
}
