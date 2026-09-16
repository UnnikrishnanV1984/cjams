import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormMaterialModule } from '../../../../@core/form-material.module';

import { LivingArrangementDetailsRoutingModule } from './living-arrangement-details-routing.module';
import { LivingArrangementDetailsComponent } from './living-arrangement-details.component';
import { AddLivingArrangementComponent} from './add-living-arrangement/add-living-arrangement.component';
import { ListlivingArrangementComponent } from './list-living-arrangement/list-living-arrangement.component';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { LivingArrangementDetailsService } from './living-arrangement-details.service';
import { ShareFeaturesModule } from '../share-features/share-features.module';

@NgModule({ declarations: [LivingArrangementDetailsComponent, AddLivingArrangementComponent, ListlivingArrangementComponent], imports: [CommonModule,
        LivingArrangementDetailsRoutingModule,
        FormMaterialModule,
        ShareFeaturesModule], providers: [LivingArrangementDetailsService, provideHttpClient(withInterceptorsFromDi())] })
export class LivingArrangementModule { }
