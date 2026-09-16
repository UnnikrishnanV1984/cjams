import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { QuickPersonHistoryComponent } from './quick-person-history.component';


const routes: Routes = [{
  path: '',
  component: QuickPersonHistoryComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class QuickPersonHistoryRoutingModule { }
