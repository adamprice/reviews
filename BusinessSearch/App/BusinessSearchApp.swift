import SwiftUI

@main
struct BusinessSearchApp: App {

    init() {
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("--stub-responses-mode") {
            URLProtocol.registerClass(StubURLProtocol.self)
        }
        #endif
    }

    var body: some Scene {
        WindowGroup {
            BusinessesGridView(viewModel: BusinessesGridViewModel())
        }
    }
}
