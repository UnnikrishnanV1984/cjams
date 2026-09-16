import { PageHeaderModule } from '../../../shared';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { FindRegulationLibraryRoutingModule } from './find-regulation-library-routing.module';
import { FindRegulationLibraryComponent } from './find-regulation-library.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { RegulationLibrarySearchComponent } from './regulation-library-search/regulation-library-search.component';
import { RegulationLibraryResultComponent } from './regulation-library-result/regulation-library-result.component';
import { RegulationLibraryViewComponent } from './regulation-library-view/regulation-library-view.component';

@NgModule({
  imports: [
    CommonModule,
    PageHeaderModule,
    FindRegulationLibraryRoutingModule,
    FormsModule,
    PaginationModule,
    ReactiveFormsModule,
    NgSelectModule,
    SharedPipesModule
  ],
  declarations: [FindRegulationLibraryComponent, RegulationLibrarySearchComponent, RegulationLibraryResultComponent, RegulationLibraryViewComponent]
})
export class FindRegulationLibraryModule { }
