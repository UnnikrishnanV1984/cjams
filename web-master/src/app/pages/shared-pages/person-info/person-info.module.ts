import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonInfoRoutingModule } from './person-info-routing.module';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { PersonInfoComponent } from './person-info.component';
import { ImageCropperComponent  } from 'ngx-image-cropper';
import { ShareFeaturesModule } from './share-features/share-features.module';
import { PersonHealthInfoModule } from './person-health/person-health-info.module';


@NgModule({
  imports: [
    CommonModule,
    PersonInfoRoutingModule,
    FormMaterialModule,
    ImageCropperComponent ,
    PersonHealthInfoModule,
    ShareFeaturesModule    
  ],
  declarations: [PersonInfoComponent]
 
})
export class PersonInfoModule { }
