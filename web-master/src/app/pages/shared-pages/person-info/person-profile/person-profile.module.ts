import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonProfileRoutingModule } from './person-profile-routing.module';
import { PersonProfileComponent } from './person-profile.component';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { ProfileImageUploadComponent } from './profile-image-upload/profile-image-upload.component';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { PersonProfileService } from './person-profile.service';
import { MatTooltipModule } from '@angular/material/tooltip';
import { PersonAlsoKnownAsComponent } from './person-also-known-as/person-also-known-as.component';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { PopoverModule } from 'ngx-bootstrap/popover';
import { PdfViewerModule } from 'ng2-pdf-viewer';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { GlobalPopupModule } from '../../../../shared/shared-components/global-popup/global-popup.module';
import { MatTreeModule } from '@angular/material/tree';
import { ShareFeaturesModule } from '../../../shared-pages/person-info/share-features/share-features.module';
// import { SharedComponentsModule } from '../../../../shared/shared-components/shared-components.module';


@NgModule({
  imports: [
    CommonModule,
    PersonProfileRoutingModule,
    FormMaterialModule,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    MatFormFieldModule,
    MatInputModule,
    MatTooltipModule,
    SharedPipesModule,
    SharedDirectivesModule,
    PopoverModule,
    PdfViewerModule,
    // SharedComponentsModule,
    NgxMaskDirective,
    NgxMaskPipe,
    GlobalPopupModule,
    MatTreeModule,
    ShareFeaturesModule
  ],
  declarations: [PersonProfileComponent, ProfileImageUploadComponent, PersonAlsoKnownAsComponent],
  providers: [PersonProfileService,provideNgxMask(),provideHttpClient(withInterceptorsFromDi())]
})
export class PersonProfileModule { }
