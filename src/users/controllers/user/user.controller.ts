import { Controller, Get, Post, Req, Res, UseGuards } from '@nestjs/common';
import { Response } from 'express';
import { AuthenticatedUser, Roles, Unprotected } from 'nest-keycloak-connect';
import { UsersService } from 'src/users/services/users/users.service';

@Controller('user')
export class UserController {
    
    constructor(private userService: UsersService) {

    }

    @Post("/check_user")
    
    async checkUser(
        @AuthenticatedUser() user: any,
        @Res() res: Response,
    ) {
        let result = await this.userService.upsertUser(user);
        return res.status(200).json({user: result})
    }
    
    
    @Get("/profile")
    @Roles({'roles': ['realm:admin']})
    // @Unprotected()
    async getProfile(
        @AuthenticatedUser() user: any
    ) {
        return {"msg": "This is the profile of the user."}
    }
}
