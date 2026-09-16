import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { ImageCropperComponent } from 'ngx-image-cropper';
import { NgxMaskDirective, provideNgxMask,NgxMaskPipe} from 'ngx-mask';

import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { PersonRelationshipRoutingModule } from './person-relationship-routing.module';
import { PersonRelationshipComponent } from './person-relationship.component';
import { SearchRelationshipComponent } from './search-relationship/search-relationship.component';
import { SearchRelationshipResultComponent } from './search-relationship-result/search-relationship-result.component';
import { RelativePersonGridComponent } from './relative-person-grid/relative-person-grid.component';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatCardModule } from '@angular/material/card';
import { FormsModule } from '@angular/forms';
import { MatCheckboxModule } from '@angular/material/checkbox';

@NgModule({
  imports: [
    CommonModule,
    PersonRelationshipRoutingModule,
    ImageCropperComponent,
    NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
    FormMaterialModule,
    PaginationModule,
    FormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatCardModule,
    MatCheckboxModule,
    NgxMaskDirective,
    NgxMaskPipe,
    SharedPipesModule
      ],
  declarations: [PersonRelationshipComponent, SearchRelationshipComponent,
     SearchRelationshipResultComponent, RelativePersonGridComponent],
     providers:[provideNgxMask()]
})
export class PersonRelationshipModule { }
