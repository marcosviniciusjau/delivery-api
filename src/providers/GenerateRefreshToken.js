const dayjs = require("dayjs") 
const uuid = require('uuid')
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

class GenerateRefreshToken {
  async execute(user_id) {
    await prisma.session.deleteMany({
      where: {
        user_id
      }
    });

    const expires_in = dayjs().add(15, "m").unix();
    const refresh_token = uuid.v4();

    await prisma.session.create({
      data: {
        user_id,
        expires_in: new Date(expires_in * 1000),
        refresh_token,
      },
    });

    return refresh_token;
  }
}
module.exports = GenerateRefreshToken 