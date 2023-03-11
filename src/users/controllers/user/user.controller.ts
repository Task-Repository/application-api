import { Controller, Get, UseGuards } from '@nestjs/common';
import { Roles, Unprotected } from 'nest-keycloak-connect';

@Controller('user')
export class UserController {
    @Get("/profile")
    @Roles({'roles': ['realm:admin']})
    // @Unprotected()
    getProfile() {
        return {"msg": "This is the profile of the user."}
    }
}
