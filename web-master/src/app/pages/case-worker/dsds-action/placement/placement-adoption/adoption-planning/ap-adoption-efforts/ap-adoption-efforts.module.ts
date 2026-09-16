import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
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

import { QuillModule } from 'ngx-quill';

// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { ApAdoptionEffortsRoutingModule } from './ap-adoption-efforts-routing.module';
import { ApAdoptionEffortsComponent } from './ap-adoption-efforts.component';
import { SharedDirectivesModule } from '../../../../../../../@core/directives/shared-directives.module';

@NgModule({
    imports: [
        CommonModule,
        ApAdoptionEffortsRoutingModule,
        MatCardModule,
        MatCheckboxModule,
        MatDatepickerModule,
        MatExpansionModule,
        MatFormFieldModule,
        MatInputModule,
        MatListModule,
        MatNativeDateModule,
        MatRadioModule,
        MatSelectModule,
        MatTableModule,
        MatTabsModule,
        // A2Edatetimepicker,
        QuillModule.forRoot(),
        ReactiveFormsModule,
        SharedDirectivesModule
    ],
    declarations: [ApAdoptionEffortsComponent]
})
export class ApAdoptionEffortsModule {}
