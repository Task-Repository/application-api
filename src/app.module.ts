import { MiddlewareConsumer, Module, RequestMethod } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { CheckUserMiddleware } from './check-user/check-user.middleware';
import { KeycloakModule } from './keycloak/keycloak.module';
import { UsersModule } from './users/users.module';
import { PrismaModule } from './prisma/prisma.module';


@Module({
  imports: [KeycloakModule, UsersModule, PrismaModule],
  controllers: [AppController],
  providers: [AppService],

})
export class AppModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(CheckUserMiddleware).forRoutes({ path: '*', method: RequestMethod.ALL})
  }
}
