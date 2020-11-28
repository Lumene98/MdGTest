import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';

import { Taco } from '../taco/taco';

@Injectable({
  providedIn: 'root'
})
export class TacoService {
  private tacoUrl = 'http://taco-randomizer.herokuapp.com/random/';

  constructor(private http: HttpClient) { }

  getTaco(): Observable<Taco> {
   return this.http.get<Taco>(this.tacoUrl,)
      .pipe(
        tap(_ => console.log('Got a taco!'))
      );
  }
  
}

  