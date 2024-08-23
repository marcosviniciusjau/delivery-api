const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

class DeliveryController {
async main(req,res) {
  const allUsers = await prisma.deliveries.findMany()
  return res.json(allUsers)
}
}

module.exports = DeliveryController 