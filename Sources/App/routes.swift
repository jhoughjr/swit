import Vapor
import SwiftShell

func routes(_ app: Application) throws {
    app.get { req async in
        "SWift gIT 1.0"
    }

    app.post { req async in
        req.logger.info("\(req.body)")
        
        let command = runAsync("swift", "build").onCompletion { command in
            // be notified when the command is finished.
        }
        command.stdout.onOutput { stdout in
            // be notified when the command produces output (only on macOS).
            req.logger.info("\(stdout.read())")
        }

        // do something with ‘command’ while it is still running.

        let foo = try? command.finish() // wait for it to finish.
        req.logger.info("\(foo!.stdout.read())")
        return 200
    }
    
}
