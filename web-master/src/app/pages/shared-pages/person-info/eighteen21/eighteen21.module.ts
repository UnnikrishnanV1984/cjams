import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { Eighteen21RoutingModule } from './eighteen21-routing.module';
import { Eighteen21Component } from './eighteen21.component';

@NgModule({
  imports: [
    CommonModule,
    Eighteen21RoutingModule
  ],
  declarations: [Eighteen21Component]
})
export class Eighteen21Module { }
