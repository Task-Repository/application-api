import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';
import { AppModule } from './../src/app.module';
import fetch from 'node-fetch'


// Function that accepts a username and password and gets a jwt token from keycloak using fetch
async function getToken(username: string, password: string) {
  const url = 'http://localhost:8085/auth/realms/task-repository-testing/protocol/openid-connect/token';
  
  const response = await fetch(url, {
    method: 'POST',
    body: `username=${username}&password=${password}&grant_type=password&client_id=frontend&client_secret=EyZtPIggqFluh721pUbtbDIWMunmOOHc`,
    headers: { 'Content-Type': 'application/x-www-form-urlencoded', "Accept": "application/json" },
  });

  const json: any = await response.json();
  
  return json.access_token;
}


describe('AppController (e2e)', () => {
  let app: INestApplication;

  beforeEach(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();
  });

  it('/ (GET)', async () => {
    const token = await getToken('joeblogs', 'password');
    return request(app.getHttpServer())
      .get('/user/profile')
      .set('Authorization', `Bearer ${token}`)
      .expect(200)
      //Set Bearer token here
      
      .expect({msg: "This is the profile of the user."});
  });
});
