import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormMaterialModule } from '../../../../@core/form-material.module';

import { ContactInfoRoutingModule } from './contact-info-routing.module';
import { ContactInfoComponent } from './contact-info.component';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { AddressDetailsService } from '../address-details/address-details.service';
import { provideNgxMask,NgxMaskDirective,NgxMaskPipe} from 'ngx-mask';
import { PrimaryPhoneNumberDialogComponent } from './primary-phone-number-dialog/primary-phone-number-dialog.component';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { MatDialogModule } from '@angular/material/dialog';

@NgModule({ declarations: [ContactInfoComponent, PrimaryPhoneNumberDialogComponent], imports: [CommonModule,
        SharedPipesModule,
        ContactInfoRoutingModule,
        FormMaterialModule,
        NgxMaskDirective,
        NgxMaskPipe,
        MatDialogModule], providers: [AddressDetailsService, provideNgxMask(), provideHttpClient(withInterceptorsFromDi())] })
export class ContactInfoModule { }
