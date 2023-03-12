import { Global, Module } from '@nestjs/common';
import { APP_GUARD } from '@nestjs/core';
import * as dotenv  from 'dotenv';

dotenv.config();

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
            secret: `${process.env.KEYCLOAK_API_TOKEN}`,
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
