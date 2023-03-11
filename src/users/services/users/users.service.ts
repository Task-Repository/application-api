import { Injectable } from '@nestjs/common';
import { CreateUserDto } from 'src/users/dtos/CreateUser.dto';
import { PrismaService } from 'src/prisma/prisma.service';
@Injectable()
export class UsersService {
    constructor(private prisma: PrismaService) {}
    upsertUser(user: CreateUserDto) {
        
    }

    fetchUsers() {
        return this.prisma.client.user.findMany();
    }
}
