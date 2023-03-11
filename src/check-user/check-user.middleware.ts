import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response } from 'express';



@Injectable()
export class CheckUserMiddleware implements NestMiddleware {
  async use(req: Request, res: Response, next: () => void) {
    
    // req['user'] = user 
    next();
  }
}
