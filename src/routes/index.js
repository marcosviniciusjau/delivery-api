const { Router } = require("express") 
const deliveryRouter = require("./delivery.routes") 
const sessionRouter = require("./session-routes") 
const routes = Router() 
routes.use("/delivery",deliveryRouter) 
routes.use("/sessions",sessionRouter) 

module.exports = routes 