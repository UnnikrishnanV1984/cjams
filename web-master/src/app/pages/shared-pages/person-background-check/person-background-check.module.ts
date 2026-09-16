import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonBackgroundCheckRoutingModule } from './person-background-check-routing.module';
import { PersonBackgroundCheckComponent } from './person-background-check/person-background-check.component';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { ShareFeaturesModule } from '../person-info/share-features/share-features.module';


@NgModule({
  imports: [
    CommonModule,
    PersonBackgroundCheckRoutingModule,
    FormMaterialModule,
    ShareFeaturesModule
  ],
  declarations: [PersonBackgroundCheckComponent]
})
export class PersonBackgroundCheckModule { }
