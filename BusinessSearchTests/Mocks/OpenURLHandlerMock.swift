import UIKit

@testable import BusinessSearch

class OpenURLHandlerMock: OpenURLHandler {

    var lastOpenedURL: URL?

    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?) {
        self.lastOpenedURL = url
    }
}
