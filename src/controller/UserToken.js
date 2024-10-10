const GenerateRefreshToken = require("../providers/GenerateRefreshToken") 
const GenerateToken = require("../providers/GenerateToken") 
const dayjs = require("dayjs") 
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

class UserRefreshToken {
  async create(request, response) {
    const { refresh_token } = request.body 

    if (!refresh_token) {
      throw new Error("Informe o token de autenticação.", 401) 
    }
    const refreshToken = await prisma.session.findFirst({
      where: {
        refresh_token
      }
    })

    if (!refreshToken) {
      throw new Error("Refresh token não encontrado para este usuário.", 401) 
    }

    const generateTokenProvider = new GenerateToken() 
    const token = await generateTokenProvider.execute(refreshToken.user_id) 

    const refreshTokenExpired = dayjs().isAfter(dayjs.unix(refreshToken.expires_in)) 

    if (refreshTokenExpired) {
      await prisma.session.delete({
        where: {
          user_id: refreshToken.user_id
        }
      })
     
      const generateRefreshToken = new GenerateRefreshToken() 
      const newRefreshToken = await generateRefreshToken.execute(refreshToken.user_id, refresh_token) 

      return response.json({ token, refresh_token: newRefreshToken }) 
    }

    return response.json({ token, refresh_token }) 
  }
}

module.exports = UserRefreshToken 