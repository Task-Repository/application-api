import { Global, Module } from '@nestjs/common';
import { APP_GUARD } from '@nestjs/core';
import {
    KeycloakConnectModule,
    ResourceGuard,
    RoleGuard,
    AuthGuard
  } from 'nest-keycloak-connect'
import { AppService } from 'src/app.service';
import { KeycloakController } from './controllers/keycloak.controller';

@Global()
@Module({
    imports: [
        KeycloakConnectModule.register({
            authServerUrl: 'http://localhost:8085/auth',
            realm: 'task-repository-testing',
            clientId: 'api',
            secret: 'etOqKiu1h2F3clSmk6kQ9spf1jTOr9Py',
        })
    ],
    controllers: [KeycloakController],
    providers: [
        AppService,
        {
            provide: APP_GUARD,
            useClass: AuthGuard,
        },
        {
            provide: APP_GUARD,
            useClass: ResourceGuard
        },
        {
            provide: APP_GUARD,
            useClass: RoleGuard
        }
    ],
})
export class KeycloakModule {}
