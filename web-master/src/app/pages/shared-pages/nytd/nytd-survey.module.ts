import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NytdSurveyComponent } from './nytd-survey.component';
import { NytdSurveyRoutingModule } from './nytd-survey-routing.module';
import { NytdSurveyService } from './nytd-survey.service';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { MatSortModule } from '@angular/material/sort';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatTableModule } from '@angular/material/table';
import { NytdSurveyResolverService } from './nytd-survey-resolver.service';
@NgModule({
  imports: [
    CommonModule,
    NytdSurveyRoutingModule,
    FormMaterialModule,
    MatTableModule,
    MatSortModule,
    MatPaginatorModule,
    SharedPipesModule
  ],
  declarations: [NytdSurveyComponent],
  providers: [NytdSurveyService, NytdSurveyResolverService]
})
export class NytdSurveyModule { }
