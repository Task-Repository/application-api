import { Injectable } from '@nestjs/common';
import { CreateUserDto } from 'src/users/dtos/CreateUser.dto';
import { PrismaService } from 'src/prisma/prisma.service';
@Injectable()
export class UsersService {
    constructor(private prisma: PrismaService) {}
    async upsertUser(user: any) {
        let result = await this.prisma.client.user.upsert({
            where: { sub: user.sub },
            update: {
                email: user.email,
                firstName: user.given_name,
                lastName: user.family_name,
                username: user.preferred_username,
                sub: user.sub
            },
            create: {
                email: user.email,
                firstName: user.given_name,
                lastName: user.family_name,
                username: user.preferred_username,
                sub: user.sub
            }
        })
        return result;
    }

    async fetchUsers() {
        return await this.prisma.client.user.findMany();
    }
}
