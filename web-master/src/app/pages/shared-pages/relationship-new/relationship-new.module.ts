import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RelationshipNewComponent } from './relationship-new.component';
import { RelationshipNewRoutingModule } from './relationship-new-routing.module';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { MatCardModule } from '@angular/material/card';
import { MatGridListModule } from '@angular/material/grid-list';
import { NgSelectModule } from '@ng-select/ng-select';
import { RelationshipResolverService } from './relationship-new-resolver.service';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { TransferHistoryApprovedService } from '../../../shared/services/transfer-history-approved.service';
import { LayoutModule } from '@angular/cdk/layout';

@NgModule({
  imports: [
    CommonModule,
    RelationshipNewRoutingModule,
    FormMaterialModule,
    MatCardModule,
    MatGridListModule,
    NgSelectModule,
    SharedPipesModule,
    LayoutModule
  ],
  exports: [RelationshipNewComponent],
  declarations: [RelationshipNewComponent],
  providers: [RelationshipResolverService, 
    TransferHistoryApprovedService
  ]
})
export class RelationshipNewModule { }
