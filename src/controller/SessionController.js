const { compare } = require("bcryptjs") 
const GenerateRefreshToken = require("../providers/GenerateRefreshToken") 
const GenerateToken = require("../providers/GenerateToken") 
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

class SessionController {
  async create(request, response) {
    try {
      const { username, password } = request.body 
      const user = await prisma.users.findFirst({
          where: {
            username
          }
        })
  
      if (!user) {
        throw new Error("Não existe uma conta nesse e-mail", 404) 
      }
  
      const passwordMatched = await compare(password, user.password) 
  
      if (!passwordMatched) {
        throw new Error("E-mail e/ou senha incorreta.", 404) 
      }
  
      const generateTokenProvider = new GenerateToken() 
      const token = await generateTokenProvider.execute(user.id) 
  
      const generateRefreshToken = new GenerateRefreshToken() 
      const refresh_token = await generateRefreshToken.execute(user.id) 
  
      delete user.password 
  
      response.status(201).json({ user, token, refresh_token }) 
    } catch (error) {
      console.error(error)
    }
   
  }
}

module.exports = SessionController 