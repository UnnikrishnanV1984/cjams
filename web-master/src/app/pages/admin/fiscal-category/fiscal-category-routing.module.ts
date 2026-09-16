import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FiscalCategoryComponent } from './fiscal-category.component';

const routes: Routes = [{
  path: '',
  component: FiscalCategoryComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FiscalCategoryRoutingModule { }
