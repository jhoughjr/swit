import Vapor
import SwiftShell

func routes(_ app: Application) throws {
    app.get { req async in
        "SWift gIT 1.0"
    }

    app.post { req async -> Response in
        req.logger.info("\(req.body)")
        let foo =  runCommand(cmd: "swift", args: ["build"])
        app.logger.info("\(foo)")
//
//        let command = runAsync("swift", "build")
//            .onCompletion { command in
//            // be notified when the command is finished.
//            app.logger.info(" completed \(command.stdout)")
//        }
//        command.stdout.onOutput { stdout in
//            // be notified when the command produces output (only on macOS).
//            app.logger.info("got \(stdout.read())")
//        }

        return .init(status:.ok)
    }
    
     func runCommand(cmd: String,
                                   args: [String]) -> String {
        let outPipe = Pipe()
        let proc = Process()
        proc.launchPath = cmd
        let foo = args.map{$0.replacingOccurrences(of: "\r", with: "\n")}
        proc.arguments = foo
        proc.standardOutput = outPipe
        proc.launch()
        proc.waitUntilExit()

        let data = outPipe.fileHandleForReading.readDataToEndOfFile()
        let res =  String(data: data, encoding: .utf8) ?? "ERROR"
        //should trim?
        return res
    }
}
