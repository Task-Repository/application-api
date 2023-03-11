import { Injectable } from '@nestjs/common';
import { CreateUserDto } from 'src/users/dtos/CreateUser.dto';
import { PrismaService } from 'src/prisma/prisma.service';
@Injectable()
export class UsersService {
    constructor(private prisma: PrismaService) {}
    async upsertUser(user: CreateUserDto) {
        
    }

    async fetchUsers() {
        console.log("*****************The fetch users function is being called.*****************")
        return await this.prisma.client.user.findMany();
    }
}
