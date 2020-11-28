import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
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
  loading = false;
  subscription: Subscription;

  constructor(private tacoService: TacoService, private detector: ChangeDetectorRef) { }

  ngOnInit(): void {
     this.loading = true;
     this.subscription = this.tacoService.getTaco().subscribe({
        next: taco => this.taco = taco,
        complete: () => this.stopLoading()
      });
  }

  stopLoading(): void{
    this.loading = false;
    this.detector.detectChanges();
    this.subscription.unsubscribe();
  }

  fetchNew(): void{
     this.tacoService.getTaco().subscribe({
        next: taco => this.taco = taco,
        complete: () => this.stopLoading()
      });
  }
}
