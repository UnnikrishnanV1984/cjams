import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PersonBasicDetailsRoutingModule } from './person-basic-details-routing.module';
import { PersonNamesRelationsComponent } from './person-names-relations/person-names-relations.component';
import { PersonDemographicsComponent } from './person-demographics/person-demographics.component';
import { PersonBasicDetailsService } from './person-basic-details.service';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PersonBasicDetailsComponent } from './person-basic-details.component';

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
import { ImageCropperComponent } from 'ngx-image-cropper';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';

@NgModule({
  imports: [
    CommonModule,
    PersonBasicDetailsRoutingModule,
    FormsModule,
    ReactiveFormsModule,
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
    ImageCropperComponent,
    NgxMaskDirective,
    NgxMaskPipe
    
  ],
  declarations: [PersonBasicDetailsComponent, PersonNamesRelationsComponent, PersonDemographicsComponent],
  providers: [PersonBasicDetailsService,provideNgxMask()]
})
export class PersonBasicDetailsModule { }

