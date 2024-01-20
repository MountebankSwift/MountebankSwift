import Foundation

/// Configuration of the Mountebank server
///
/// [mbtest.org/docs/api/contracts?type=config](https://www.mbtest.org/docs/api/contracts?type=config)
public struct Config: Codable, Equatable {
    public struct Options: Codable, Equatable {
        public struct Log: Codable, Equatable {
            let level: LogLevel
        }

        /// The port to run the main Mountebank server on
        public let port: Int

        /// Only accept requests from localhost. You should ALWAYS do this when running Mountebank with
        /// allowInjection directly on your developer machine, but will need to use ipWhitelist otherwise
        /// (or if running in Docker)
        public let localOnly: Bool

        /// A pipe-delimited string of remote IP addresses to whitelist (local IP addresses will always be allowed).
        /// Any request to the primary mb socket or an imposter socket that isn't whitelisted will be dropped.
        public let ipWhitelist: [String]

        /// A safe origin for CORS requests. Use the flag multiple times to enable multiple origins.
        public let origin: Bool

        /// File to load custom protocol implementations from.
        public let protofile: String

        /// The file where the process id is stored for the mb stop command
        public let pidfile: String?

        /// Advanced logging configuration, when you want to customize the log formats. While you can pass the JSON
        /// string on the command line, it's easier to put it in the rcfile. If you pass log, the simpler logging
        /// configuration options (loglevel, logfile, nologfile) will be ignored.
        /// You can set the format to "json" to log all fields as JSON, or set it to a string to customize the
        /// format. The supported fields are:
        /// - %level
        /// - %timestampd
        /// - %message
        public let log: Log?

        /// By default, Mountebank will render config files through EJS templating to allow modularizing rich
        /// configuration. Use this flag if you aren't using templating and have special character sequences in
        /// your configuration that cause rendering errors.
        public let noParse: Bool?

        /// Historically, Mountebank supported EJS templating when using the configfile option, and was limited to
        /// saving all configuration in a single file when calling mb save. For backwards compatibility, that
        /// remains the default option, even though EJS has subsequently made breaking changes.
        /// A custom formatter allows you to save test data in whatever format you want (including in ways that
        /// convert between other service virtualization products). See below for more details. In the context of
        /// mb start, the formatter will be used to parse the configfile.
        public let formatter: String?

        /// If present, Mountebank will load the contents of the specified file. See below for details.
        public let configFile: String?

        /// Mountebank supports JavaScript injection for predicates, stub responses, behavior decoration, wait
        /// behavior functions and tcp request resolution, but they are disabled by default. Including this
        /// parameter will enable them.
        ///
        /// > Note: Be aware that allowing injection means that an attacker can run random code on the machine running
        /// mb. Please see the security page for tips on securing your system.
        public let allowInjection: Bool

        /// Include a matches array with each stub in the body of a GET imposter response for debugging why a
        /// particular stub did or did not match a request. Every time a response from the stub is used, a
        /// match will be added containing the request, the response configuration, the actual generated
        /// response (even if it is proxied), and the overall processing time.
        public let debug: Bool
    }

    public struct Process: Codable, Equatable {

        /// The version of node.js witch Mountebank is useing
        public let nodeVersion: String

        /// The architecture of the machine running Mountebank.
        public let architecture: String

        /// The operating system of the machine running Mountebank.
        public let platform: String

        /// The memory (in bytes) used by Mountebank
        public let rss: Int

        /// The total heap usage of the V8 JavaScript engine.
        public let heapTotal: Int

        /// The heap used of the V8 JavaScript engine.
        public let heapUsed: Int

        /// The number of seconds this process has been running.
        public let uptime: Double

        /// The current directory, used to start mb
        public let cwd: String
    }

    /// The Mountebank version
    public let version: String

    /// The command line options used to start mb.
    public let options: Options

    /// Information about the running mb process
    public let process: Process
}
