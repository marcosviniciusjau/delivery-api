const { Router } = require("express") 
const deliveryRouter = require("./delivery.routes") 

const routes = Router() 
routes.use("/delivery",deliveryRouter) 

module.exports = routes 