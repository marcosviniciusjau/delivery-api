const { Router } = require("express") 

const ensureAuthenticate = require("../middleware/ensureAuthenticate")
const DeliveryController = require("../controller/DeliveryController") 

const deliveryRoutes = Router() 

const deliveryController = new DeliveryController() 

deliveryRoutes.get("/:userId",(req,res) =>  deliveryController.main(req,res))
deliveryRoutes.get("/:userId/:id",(req,res) =>  deliveryController.getById(req,res))
deliveryRoutes.post("/init",(req,res) =>  deliveryController.init(req,res))
deliveryRoutes.post("/finish/:deliveryId",(req,res) =>  deliveryController.finish(req,res))
module.exports = deliveryRoutes 