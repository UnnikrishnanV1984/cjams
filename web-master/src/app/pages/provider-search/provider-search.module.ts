import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ProviderSearchRoutingModule } from './provider-search-routing.module';
import { ProviderSearchComponent } from './provider-search.component';
import { FormMaterialModule } from '../../@core/form-material.module';
import { ServiceCasePlacementsService } from '../case-worker/dsds-action/service-case-placements/service-case-placements.service';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { FinanceService } from '../finance/finance.service';
import { ProviderInfoPopupModule } from '../finance/provider-info-popup/provider-info-popup.module';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { SharedPipesModule } from '../../@core/pipes/shared-pipes.module';

@NgModule({
  imports: [
    CommonModule,
    ProviderSearchRoutingModule,
    FormMaterialModule,
    PaginationModule,
    ProviderInfoPopupModule,
    NgxMaskDirective,
    NgxMaskPipe,
    SharedPipesModule
      ],
  declarations: [ProviderSearchComponent],
  providers: [ServiceCasePlacementsService, FinanceService,provideNgxMask()]
})
export class ProviderSearchModule { }
