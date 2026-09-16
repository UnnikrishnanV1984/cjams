import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { FormMaterialModule } from '../../../../@core/form-material.module';

import { EmploymentProfileRoutingModule } from './employment-profile-routing.module';
import { EmploymentProfileComponent } from './employment-profile.component';
import { AddEmploymentComponent } from './add-employment/add-employment.component';
import { ListEmploymentComponent } from './list-employment/list-employment.component';
import { EmploymentProfileService } from './employment-profile.service';
import { ShareFeaturesModule } from '../share-features/share-features.module';

@NgModule({ declarations: [EmploymentProfileComponent, AddEmploymentComponent, ListEmploymentComponent], imports: [CommonModule,
        EmploymentProfileRoutingModule,
        FormMaterialModule,
        ShareFeaturesModule], providers: [EmploymentProfileService, provideHttpClient(withInterceptorsFromDi())] })
export class EmploymentProfileModule { }
