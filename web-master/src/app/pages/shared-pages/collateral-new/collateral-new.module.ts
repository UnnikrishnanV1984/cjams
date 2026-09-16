import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { RelationshipNewService } from './collateral.new.service';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { MatCardModule } from '@angular/material/card';
import { MatGridListModule } from '@angular/material/grid-list';
import { NgSelectModule } from '@ng-select/ng-select';
import { CollateralNewRoutingModule } from './collateral-new-routing.module';
import { CollateralNewComponent } from './collateral-new.component';
import { ShareFeaturesModule } from '../person-info/share-features/share-features.module';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
@NgModule({
  imports: [
    CommonModule,
    SharedPipesModule,
    CollateralNewRoutingModule,
    FormMaterialModule,
    MatCardModule,
    MatGridListModule,
    NgSelectModule,
    ShareFeaturesModule,
    NgxMaskDirective,
    NgxMaskPipe
   
  ],
  exports: [CollateralNewComponent],
  declarations: [CollateralNewComponent],
  providers: [RelationshipNewService,provideNgxMask()]
})
export class CollateralNewModule { }
