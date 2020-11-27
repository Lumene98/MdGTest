import { Component, OnInit } from '@angular/core';

import { Taco } from '../models/taco.model'

import { TacoService } from '../services/taco.service';

@Component({
  selector: 'app-taco',
  templateUrl: './taco.component.html',
  styleUrls: ['./taco.component.css']
})
export class TacoComponent implements OnInit {
  taco: Taco;

  constructor(private service: TacoService) { }

  ngOnInit(): void {
    this.getTaco();
  }

  getTaco(): void {
    this.service.getTaco()
    .subscribe( taco => this.taco = taco);
  }

}
