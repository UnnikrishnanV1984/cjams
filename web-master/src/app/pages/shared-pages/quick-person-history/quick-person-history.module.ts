import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { QuickPersonHistoryService } from './quick-person-history.service';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { MatCardModule } from '@angular/material/card';
import { MatGridListModule } from '@angular/material/grid-list';
import { NgSelectModule } from '@ng-select/ng-select';
import { QuickPersonHistoryRoutingModule } from './quick-person-history-routing.module';
import { QuickPersonHistoryComponent } from './quick-person-history.component';
import { ShareFeaturesModule } from '../person-info/share-features/share-features.module';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
@NgModule({
  imports: [
    CommonModule,
    SharedPipesModule,
    QuickPersonHistoryRoutingModule,
    FormMaterialModule,
    MatCardModule,
    MatGridListModule,
    NgSelectModule,
    ShareFeaturesModule,
    NgxMaskDirective,
    NgxMaskPipe
    
  ],
  exports: [QuickPersonHistoryComponent],
  declarations: [QuickPersonHistoryComponent],
  providers: [QuickPersonHistoryService,provideNgxMask()]
})
export class QuickPersonHistoryModule { }
