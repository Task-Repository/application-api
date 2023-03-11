import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma/prisma.module';
import { UserController } from './controllers/user/user.controller';
import { UsersService } from './services/users/users.service';


@Module({
  controllers: [UserController],
  providers: [UsersService],
  imports: [PrismaModule]
})
export class UsersModule {}
