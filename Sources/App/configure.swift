import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    // Enable TLS.
     let f = try! NIOSSLCertificate.fromPEMFile("/etc/letsencrypt/live/jimmyhoughjr.freeddns.org/fullchain.pem")
    app.http.server.configuration.tlsConfiguration = .makeServerConfiguration(
        certificateChain: f.map { .certificate($0) },
        privateKey: .file("/etc/letsencrypt/live/jimmyhoughjr.freeddns.org/privkey.pem")
    )
    try routes(app)
}
