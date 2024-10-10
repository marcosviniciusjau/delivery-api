const { Router } = require("express") 

const SessionController = require("../controller/SessionController") 
const UserToken = require("../controller/UserToken") 

const sessionsController = new SessionController() 
const userToken = new UserToken() 

const sessionsRoutes = Router() 
sessionsRoutes.post("/", sessionsController.create) 
sessionsRoutes.post("/refresh-token", userToken.create) 

module.exports = sessionsRoutes 