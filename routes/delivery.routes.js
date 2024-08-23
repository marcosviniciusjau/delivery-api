const { Router } = require("express") 

const DeliveryController = require("../init") 

const deliveryRoutes = Router() 

const deliveryController = new DeliveryController() 


deliveryRoutes.get("/",(req,res) =>  deliveryController.main(req,res))

module.exports = deliveryRoutes 