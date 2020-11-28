import { Component, OnInit } from '@angular/core';
import { MarkdownService } from 'ngx-markdown';

import { Taco } from './taco'

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
     this.service.getTaco().subscribe(taco => this.taco = taco);
  }
}
