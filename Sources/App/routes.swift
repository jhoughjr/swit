import Vapor
import SwiftShell

func routes(_ app: Application) throws {
    app.get { req async in
        "SWift gIT 1.0"
    }

    app.post { req async -> Response in
        req.logger.info("\(req.body)")
        
        let command = runAsync("swift", "build").onCompletion { command in
            // be notified when the command is finished.
            req.logger.info("\(command.stdout)")
        }
        command.stdout.onOutput { stdout in
            // be notified when the command produces output (only on macOS).
            req.logger.info("\(stdout.read())")
        }

        return .init(status:.ok)
    }
    
}
