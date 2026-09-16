import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { NytdSurveyComponent } from './nytd-survey.component';
import { MatSortModule } from '@angular/material/sort';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { NytdSurveyResolverService } from './nytd-survey-resolver.service';
const routes: Routes = [
  {
  path: '',
  component: NytdSurveyComponent,
  resolve: {
    config: NytdSurveyResolverService
  },
  children: []
 }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule,
    MatTableModule,
    MatSortModule,
    MatPaginatorModule]
})
export class NytdSurveyRoutingModule { }
