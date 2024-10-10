const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

class DeliveryController {

async main(req,res) {
  const { userId } = req.params 
  const allDeliveries = await prisma.deliveries.findMany({
    where: {
      user_id: Number(userId)
    },
  });
  return res.json(allDeliveries)
}

async init(req,res){
  try {
    const delivery = await prisma.deliveries.create({
      data: {
        donor_name: req.body.donor,
        initial_address: req.body.currentAddress,
        is_on_delivering: true,
        user_id: req.body.userId,
      },
    })
  
    res.status(201).json({ delivery })
  } catch (error) {
    console.error(error)
  }
  
}
async getById(req,res){
  try {

  const { id,userId } = req.params 
    const delivery = await prisma.deliveries.findUnique({
      where: {
        id: Number(id),
      },
    });
  
    res.status(200).json( delivery )
    if(delivery === null){
      throw new Exception("Entrega não encontrada")
    }
  } catch (error) {
    console.error(error)
  }
  
}
async finish(req,res){
  try {
    
  const { deliveryId } = req.params 
    const delivery = await prisma.deliveries.update({
      where: {
        id: Number(deliveryId),
      },
      data: {
        final_address: req.body.finalAddress,
        is_on_delivering: false,
        ended_at: req.body.endedAt
      },
    });
  
    res.status(201).json({ delivery })
  } catch (error) {
    console.error(error)
  }
  
}
}

module.exports = DeliveryController