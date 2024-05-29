enum Host {
    static var uiTestingListApiHost: URL? {
        ProcessInfo.processInfo.environment["listApiHost"].flatMap(URL.init(string:))
    }
    static var uiTestingImagesApiHost: URL? {
        ProcessInfo.processInfo.environment["imagesApiHost"].flatMap(URL.init(string:))
    }

    static var lists: URL {
        uiTestingListApiHost ??
        URL(string: "https://lists.pocketcasts.com")!
    }

    static var images: String {
        uiTestingImagesApiHost ??
        URL(string: "https://static.pocketcasts.com")!
    }
}
