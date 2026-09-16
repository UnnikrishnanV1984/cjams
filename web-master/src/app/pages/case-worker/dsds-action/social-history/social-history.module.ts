import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { SocialHistoryComponent } from './social-history.component';
import { SocialHistoryResolverService } from './social-history-resolver.service';
import { SocialHistoryRoutingModule } from './social-history-routing.module';
import { SocialHistoryService } from './social-history.service';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { SocialhistoryRbResolverService } from './socialhistory-resolver.service';
@NgModule({
  imports: [
    CommonModule,
    SocialHistoryRoutingModule,
    FormMaterialModule,
    SharedPipesModule
  ],
  declarations: [SocialHistoryComponent],
  providers: [SocialHistoryResolverService, SocialHistoryService,SocialhistoryRbResolverService]
})
export class SocialHistoryModule { }
