import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonSearchRoutingModule } from './person-search-routing.module';
import { PersonSearchComponent } from './person-search.component';
import { SearchComponent } from './search/search.component';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SearchResultComponent } from './search-result/search-result.component';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { SharedPipesModule } from '../../@core/pipes/shared-pipes.module';
import { CwSearchComponent } from './cw-search/cw-search.component';
import { NavigationUtils } from '../_utils/navigation-utils.service';
import { SortTableModule } from '../../shared/modules/sortable-table/sortable-table.module';
import { AuditTrailModule } from '../shared-pages/audit-trail/audit-trail.module';
import { AddressSearchComponent } from './address-search/address-search.component';
import { FormMaterialModule } from '../../@core/form-material.module';
import { ProgramParticipationModule } from '../../lib/programParticipation/programParticipation.module';
import { UIModule } from '../../lib/ui/ui.module';
import { NewYouthTransitionPlanModule } from '../case-worker/dsds-action/service-plan/youth-transition-plan-new/youth-transition-plan.module';
import { HighlightSearchPipe } from '../../@core/pipes/highlight-search.pipe';
import { MatSortModule } from '@angular/material/sort';
import { MultiHighlightPipe } from '../../@core/pipes/multi-highlight.pipe';
import { MatTooltipModule } from '@angular/material/tooltip';
import { ShareFeaturesModule } from '../shared-pages/person-info/share-features/share-features.module';

@NgModule({
  imports: [
    CommonModule,
    FormMaterialModule,
    PaginationModule,
    PersonSearchRoutingModule,
    ProgramParticipationModule,
    SharedPipesModule,
    SortTableModule,
    AuditTrailModule,
    NewYouthTransitionPlanModule,
    UIModule,
    MatSortModule,
    NgxMaskDirective,
    NgxMaskPipe,
    MatTooltipModule,
    ShareFeaturesModule,
    MultiHighlightPipe,
    HighlightSearchPipe
  ],
  declarations: [PersonSearchComponent, SearchComponent, SearchResultComponent, CwSearchComponent, AddressSearchComponent],
  providers: [NavigationUtils, provideNgxMask()],
  exports: [CwSearchComponent]
})
export class PersonSearchModule { }