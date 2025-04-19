import Foundation

public enum SimpleNetTracker {
    /// Starts tracking all API requests made via URLSession
    public static func start() {
        URLProtocol.registerClass(NetworkInterceptor.self)
    }

    /// Stops tracking API requests
    public static func stop() {
        URLProtocol.unregisterClass(NetworkInterceptor.self)
    }
}
