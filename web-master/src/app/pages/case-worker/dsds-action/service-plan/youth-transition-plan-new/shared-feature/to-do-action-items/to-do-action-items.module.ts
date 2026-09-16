import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ToDoActionItemsComponent } from './to-do-action-items.component';
import { FormMaterialModule } from '../../../../../../../@core/form-material.module';

@NgModule({
  imports: [
    CommonModule,
    FormMaterialModule
  ],
  declarations: [ToDoActionItemsComponent],
  exports: [ToDoActionItemsComponent]
})
export class ToDoActionItemsModule { }
