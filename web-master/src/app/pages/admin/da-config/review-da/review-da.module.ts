import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ReviewDaRoutingModule } from './review-da-routing.module';
import { ReviewDaComponent } from './review-da.component';

@NgModule({
  imports: [
    CommonModule,
    ReviewDaRoutingModule , ReactiveFormsModule, FormsModule
  ],
  declarations: [ReviewDaComponent]
})
export class ReviewDaModule { }
