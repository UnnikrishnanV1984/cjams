import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { ControlMessagesModule } from '../../../shared/modules/control-messages/control-messages.module';
import { ProviderAddressRoutingModule } from './provider-address-routing.module';
import { ProviderAddressComponent } from './provider-address.component';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { ProviderAddressService } from './provider-address.service';
import { SharedDirectivesModule } from '../../../@core/directives/shared-directives.module';
import { QuillModule } from 'ngx-quill';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatButtonToggleModule } from '@angular/material/button-toggle';
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
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { MatStepperModule } from '@angular/material/stepper';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
import { MatTooltipModule } from '@angular/material/tooltip';

import { NgxPaginationModule } from 'ngx-pagination';

@NgModule({
    imports: [
        CommonModule,
        ProviderAddressRoutingModule,
         MatDatepickerModule,
        MatNativeDateModule,
        MatFormFieldModule,
        MatInputModule,
        MatCheckboxModule,
        MatTooltipModule,
        MatSelectModule,
        MatRadioModule,
        MatTabsModule,
        MatCardModule,
        MatListModule,
        MatAutocompleteModule,
        MatTableModule,
        MatExpansionModule,
        MatButtonToggleModule,
        MatSlideToggleModule,
        MatStepperModule,
        FormsModule,
        ReactiveFormsModule,
        // A2Edatetimepicker,
        ControlMessagesModule,
        NgSelectModule, SharedPipesModule,
        SharedDirectivesModule,
        NgxPaginationModule,
        QuillModule.forRoot(),
        NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective,
        NgxMaskDirective,
        NgxMaskPipe
        
    ],
    declarations: [
        ProviderAddressComponent
    ],
    exports : [
      ProviderAddressComponent
    ],
    providers: [ProviderAddressService, provideNgxMask()] 
    
    
})
export class ProviderAddressModule {}
