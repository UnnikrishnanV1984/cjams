import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
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
 

// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { PlacementBreakthelineRoutingModule } from './placement-breaktheline-routing.module';
import { PlacementBreakthelineComponent } from './placement-breaktheline.component';
import { ReactiveFormsModule } from '@angular/forms';
import { SharedPipesModule } from '../../../../../../@core/pipes/shared-pipes.module';
import { SharedDirectivesModule } from '../../../../../../@core/directives/shared-directives.module';

@NgModule({
  imports: [
    CommonModule,
    PlacementBreakthelineRoutingModule,
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
    ReactiveFormsModule,
    SharedPipesModule,
    SharedDirectivesModule
  ],
  declarations: [PlacementBreakthelineComponent]
})
export class PlacementBreakthelineModule { }
