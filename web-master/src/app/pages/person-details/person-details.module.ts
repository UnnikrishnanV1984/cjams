import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective, NgxfUploaderService } from 'ngxf-uploader';
import { ImageCropperComponent } from 'ngx-image-cropper';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { PersonDetailsRoutingModule } from './person-details-routing.module';
import { PersonDetailsComponent } from './person-details.component';
import { PersonEducationDetailsComponent } from './person-education-details/person-education-details.component';
import { PersonWorksDetailsComponent } from './person-works-details/person-works-details.component';
import { PersonAddressDetailsComponent } from './person-address-details/person-address-details.component';
import { QuillModule } from 'ngx-quill';
import { IntakeUtils } from '../_utils/intake-utils.service';
import { SharedDirectivesModule } from '../../@core/directives/shared-directives.module';

@NgModule({
  imports: [
    CommonModule,
    ImageCropperComponent,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
     MatDatepickerModule,
    MatNativeDateModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatRadioModule,
    MatTabsModule,
    MatCheckboxModule,
    MatListModule,
    MatCardModule,
    MatTableModule,
    MatExpansionModule,
    MatAutocompleteModule,
    FormsModule,
    ReactiveFormsModule,
    PaginationModule,
    QuillModule.forRoot(),
    PersonDetailsRoutingModule,
    SharedDirectivesModule,
    MatSelectModule,
    NgxMaskDirective,
    NgxMaskPipe
  ],
  declarations: [PersonDetailsComponent, PersonEducationDetailsComponent, PersonWorksDetailsComponent, PersonAddressDetailsComponent],
  providers: [NgxfUploaderService, IntakeUtils,provideNgxMask()]
})
export class PersonDetailsModule { }
