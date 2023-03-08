import { Controller, Get, UseGuards } from '@nestjs/common';
import { Roles, Unprotected } from 'nest-keycloak-connect';

@Controller('user')
export class UserController {
    @Get("/profile")
    @Roles({roles: ['admin']})
    getProfile() {
        return {"msg": "This is the profile of the user."}
    }
}
