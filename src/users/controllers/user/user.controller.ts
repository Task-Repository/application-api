import { Controller, Get, Post, UseGuards } from '@nestjs/common';
import { AuthenticatedUser, Roles, Unprotected } from 'nest-keycloak-connect';
import { UsersService } from 'src/users/services/users/users.service';

@Controller('user')
export class UserController {
    
    constructor(private userService: UsersService) {

    }

    @Post("/check_user")
    @Unprotected()
    checkUser(
        @AuthenticatedUser() user: any
    ) {
        
    }
    
    
    @Get("/profile")
    @Roles({'roles': ['realm:admin']})
    // @Unprotected()
    getProfile(
        @AuthenticatedUser() user: any
    ) {
        // console.log(user)
        console.log(this.userService.fetchUsers())
        return {"msg": "This is the profile of the user."}
    }
}
