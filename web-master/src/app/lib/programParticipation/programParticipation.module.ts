import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

import { CommonHttpService } from './../../@core/services/common-http.service';
import { ProgramParticipationService } from './programParticipation.service';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTableModule } from '@angular/material/table';
import { ProgramParticipationComponent } from './example/programParticipation.component';
import { TableComponent } from './table/table.component';
import { UIModule } from '../ui/ui.module';

@NgModule({
    imports: [
        CommonModule,
        MatProgressSpinnerModule,
        MatTableModule,
        UIModule
    ],
    declarations: [
    	ProgramParticipationComponent,
        TableComponent,
    ],
    exports: [
        TableComponent
    ],
    providers: [
        CommonHttpService,
        ProgramParticipationService
    ]
})

export class ProgramParticipationModule { }