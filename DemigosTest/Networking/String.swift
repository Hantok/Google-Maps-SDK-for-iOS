//
//  String.swift
//  Networking

import Foundation

extension String {

    typealias NetworkingCompletion = RSResponse -> Void

    /// Simply does an HTTP GET/POST/PUT/DELETE using the receiver as the endpoint eg 'users'.
    /// This endpoint is appended to the baseURL which is specified in Constants below.
    /// These should be your main entry-point into project from the rest of your app.
    /// It's an exercise to the reader to extend these to allow custom headers if you require.
    /// Also, if you think this string extension technique is a tad twee (i'll concede that's possible) you can of course
    /// make these as static functions of a class of your choosing.
    func get(parameters: [String: String]? = nil, headers: [String: String]? = nil, completion: NetworkingCompletion) {
        requestWithMethod("GET", queryParameters: parameters, headers: headers, completion: completion)
    }
    func post(parameters: [String : String]? = nil, headers: [String: String]? = nil, completion: NetworkingCompletion) {
        requestWithMethod("POST", bodyParameters: parameters, headers: headers, completion: completion)
    }
    func put(parameters: NSDictionary? = nil, headers: [String: String]? = nil, completion: NetworkingCompletion) {
        requestWithMethod("PUT", bodyParameters: parameters, headers: headers, completion: completion)
    }
    func delete(parameters: NSDictionary? = nil, headers: [String: String]? = nil, completion: NetworkingCompletion) {
        requestWithMethod("DELETE", bodyParameters: parameters, headers: headers, completion: completion)
    }

    /// Used to contain the common code for GET and POST and DELETE and PUT.
    private func requestWithMethod(method: String,
        queryParameters: [String: String]? = nil,
        bodyParameters: NSDictionary? = nil,
        headers: [String: String]? = nil,
        completion: NetworkingCompletion) {
        /// Tack on the endpoint to the base URL.
        let URL = NSURL(string: self, relativeToURL: geocodeURL)!
        // Create the request, with the JSON payload or querystring if necessary.
        let request = NSURLRequest.requestWithURL(URL,
            method: method,
            queryParameters: queryParameters,
            bodyParameters: bodyParameters,
            headers: headers)
        let task = NSURLSession.sharedRsSession.dataTaskWithRequest(request) {
            data, response, sessionError in
            
            // Check for a non-200 response, as NSURLSession doesn't raise that as an error.
            var error = sessionError
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode < 200 || httpResponse.statusCode >= 300 {
                    let description = "HTTP response was \(httpResponse.statusCode)"
                    error = NSError(domain: "Custom", code: 0, userInfo: [NSLocalizedDescriptionKey: description])
                }
            }
            
            let wrappedResponse = RSResponse(data: data, response: response, error: error)
            completion(wrappedResponse)
        }
        task.resume()
    }
}
