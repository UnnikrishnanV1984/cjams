import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';

import { CommonHttpService } from './../../@core/services/common-http.service';
import { DetailsTableComponent } from './components/detailsTable/detailsTable.component';
import { NytdComponent } from './components/nytd.component';
import { NytdRoutingModule } from './nytd-routing.module';
import { NytdService } from './nytd.service';
import { SelectTableComponent } from './components/selectTable/selectTable.component';
import { SurveyModule } from './components/survey/survey.module';
import { UIModule } from '../ui/ui.module';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
@NgModule({
    imports: [
        CommonModule,
        FormsModule,
        MatButtonModule,
        MatCheckboxModule,
        MatDatepickerModule,
        MatIconModule,
        MatInputModule,
        MatListModule,
        MatProgressSpinnerModule,
        MatRadioModule,
        MatSelectModule,
        MatTableModule,
        MatTabsModule,
        NytdRoutingModule,
        SurveyModule,
        UIModule
    ],
    declarations: [
        DetailsTableComponent,
        NytdComponent,
        SelectTableComponent
    ],
    providers: [
        NytdService,
        CommonHttpService
    ]
})

export class NytdModule { }
