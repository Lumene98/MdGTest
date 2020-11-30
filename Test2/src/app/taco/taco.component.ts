import { Component, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';

import { Taco } from './taco';

import { TacoService } from '../services/taco.service';

@Component({
  selector: 'app-taco',
  templateUrl: './taco.component.html',
  styleUrls: ['./taco.component.css'],
})
export class TacoComponent implements OnInit {
  taco: Taco;
  subscription: Subscription;

  constructor(private tacoService: TacoService) { }

  ngOnInit(): void {
     this.subscription = this.tacoService.getTaco().subscribe({
        next: taco => this.taco = taco,
      });
  }

  fetchNew(): void{
     this.tacoService.getTaco().subscribe({
        next: taco => this.taco = taco,
      });
  }
}
