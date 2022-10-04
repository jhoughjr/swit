import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "SWift gIT 1.0"
    }

    app.post { req async in
        req.logger.info("\(req.body)")
    }
    
}
