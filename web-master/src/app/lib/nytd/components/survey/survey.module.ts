import { CommonModule } from '@angular/common';
import { CUSTOM_ELEMENTS_SCHEMA, NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';

import { SurveyComponent } from './survey.component';
import { RadioQuestionComponent } from './question/radioQuestion/radioQuestion.component';
import { SelectQuestionComponent } from './question/selectQuestion/selectQuestion.component';
import { UIModule } from '../../../ui/ui.module';

@NgModule({
    imports: [
        CommonModule,
        FormsModule,
        MatButtonModule,
        MatCheckboxModule,
        MatDatepickerModule,
        MatInputModule,
        MatListModule,
        MatProgressSpinnerModule,
        MatRadioModule,
        MatSelectModule,
        MatTableModule,
        MatTabsModule,
        UIModule
    ],
    exports: [
        SurveyComponent
    ],
    declarations: [
        SurveyComponent,
        RadioQuestionComponent,
        SelectQuestionComponent,
    ],
    schemas: [CUSTOM_ELEMENTS_SCHEMA]
})

export class SurveyModule {
    //
}
