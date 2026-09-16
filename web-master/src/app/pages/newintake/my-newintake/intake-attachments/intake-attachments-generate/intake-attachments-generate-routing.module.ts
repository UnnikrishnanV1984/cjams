import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IntakeAttachmentsGenerateComponent } from './intake-attachments-generate.component';

const routes: Routes = [
  {
    path: '',
    component: IntakeAttachmentsGenerateComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class IntakeAttachmentsGenerateRoutingModule { }
