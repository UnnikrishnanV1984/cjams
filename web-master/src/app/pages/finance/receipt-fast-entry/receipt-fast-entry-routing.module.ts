import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ReceiptFastEntryComponent } from './receipt-fast-entry.component';

const routes: Routes = [
  {
    path: '',
    component: ReceiptFastEntryComponent,
    children: []
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ReceiptFastEntryRoutingModule { }
