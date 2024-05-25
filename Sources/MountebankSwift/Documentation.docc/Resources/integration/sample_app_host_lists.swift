enum Host {
    // URL that will only not nil during UI testing
    static var uiTestingListApiHost: URL? {
        ProcessInfo.processInfo.environment["listApiHost"].flatMap(URL.init(string:))
    }

    static var lists: URL {
        // Use UI testing URL if it is set or use production URL otherwise
        uiTestingListApiHost ??
        URL(string: "https://lists.pocketcasts.com")!
    }

    static var images: String {
        URL(string: "https://static.pocketcasts.com")!
    }
}
