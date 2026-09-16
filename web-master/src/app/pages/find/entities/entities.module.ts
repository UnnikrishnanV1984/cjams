import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { EntitiesRoutingModule } from './entities-routing.module';
import { EntitiesComponent } from './entities.component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { EntitiesSearchComponent } from './entities-search/entities-search.component';
import { EntitiesResultsComponent } from './entities-results/entities-results.component';
import { EntitiesViewComponent } from './entities-view/entities-view.component';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';

@NgModule({
  imports: [
    CommonModule,
    EntitiesRoutingModule,
    FormsModule,
    PaginationModule,
    ReactiveFormsModule,
    NgSelectModule,
    SharedPipesModule
  ],
  declarations: [EntitiesComponent, EntitiesSearchComponent, EntitiesResultsComponent, EntitiesViewComponent]
})
export class EntitiesModule { }
