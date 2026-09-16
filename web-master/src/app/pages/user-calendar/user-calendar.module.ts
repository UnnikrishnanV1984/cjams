import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormMaterialModule } from '../../@core/form-material.module';
import { UserCalendarRoutingModule } from './user-calendar-routing.module';
import { UserCalendarComponent } from './user-calendar.component';
import { CalendarModule, DateAdapter } from 'angular-calendar';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ControlMessagesModule } from '../../shared/modules/control-messages/control-messages.module';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../@core/pipes/shared-pipes.module';
import { adapterFactory } from 'angular-calendar/date-adapters/date-fns';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatButtonModule } from '@angular/material/button';
import { ShareFeaturesModule } from '../../pages/shared-pages/person-info/share-features/share-features.module';
@NgModule({
  imports: [
    CommonModule,
    UserCalendarRoutingModule,
    CalendarModule.forRoot({ provide: DateAdapter, useFactory: adapterFactory }),
    ReactiveFormsModule,
    FormsModule,
    ControlMessagesModule,
    NgSelectModule,
    SharedPipesModule,
    FormMaterialModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatButtonModule,
    ShareFeaturesModule

    
  ],
  declarations: [UserCalendarComponent]
})
export class UserCalendarModule { }