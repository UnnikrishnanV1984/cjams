import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

import { SharedPipesModule } from '../pipes/shared-pipes.module';
import { NumberOnlyDirective } from './number-only.directive';
import { ValidDateDirective } from './valid-date.directive';
import { SafeHtmlDirective } from './safe-html.directive';
import { NoDirtyDirective } from './no-dirty.directive';
import { AppMaskDateDirective } from './app-mask-date.directive';
import { ZipcodeOnlyDirective } from './zipcode-only.directive';
import { StringOnlyDirective } from './string-only.directive';
import { FieldPermissionDirective } from './field-permission.directive';
import { HyphenatedStringOnlyDirective } from './hyphenated-string-only.directive';
import { StringOnlyAllowSpaceDirective } from './string-only-allow-space.directive';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { DisableControlDirective } from './control-permission.directive';
import { DisableControlDirectiveNew } from './control-permission-new.directive';
import { FieldPermissionDirectiveNew } from './field-permission-new.directive';
import { TwoDigitDecimaNumberDirective } from './two-decimal-digit.directive';
import { ButtonHandlerDirective } from './button-handler.directive';
import { CustomeDateFormatsDirective } from './custom-date-formating.directive';

@NgModule({
    imports: [CommonModule, FormsModule, ReactiveFormsModule, SharedPipesModule],
    declarations: [ValidDateDirective, NumberOnlyDirective, StringOnlyDirective, SafeHtmlDirective, NoDirtyDirective, AppMaskDateDirective,
        ZipcodeOnlyDirective, FieldPermissionDirective, HyphenatedStringOnlyDirective, StringOnlyAllowSpaceDirective, DisableControlDirective, 
        DisableControlDirectiveNew, FieldPermissionDirectiveNew,TwoDigitDecimaNumberDirective, ButtonHandlerDirective,CustomeDateFormatsDirective],
    exports: [ValidDateDirective, NumberOnlyDirective, StringOnlyDirective, SafeHtmlDirective, NoDirtyDirective, AppMaskDateDirective,
        ZipcodeOnlyDirective, FieldPermissionDirective, HyphenatedStringOnlyDirective, StringOnlyAllowSpaceDirective, DisableControlDirective,
         DisableControlDirectiveNew, FieldPermissionDirectiveNew,TwoDigitDecimaNumberDirective, ButtonHandlerDirective,CustomeDateFormatsDirective],
    providers: []
})

// declarations: [ValidDateDirective, NumberOnlyDirective, StringOnlyDirective, SafeHtmlDirective, NoDirtyDirective, AppMaskDateDirective, ZipcodeOnlyDirective, FieldPermissionDirective],
//     exports: [ValidDateDirective, NumberOnlyDirective, StringOnlyDirective, SafeHtmlDirective, NoDirtyDirective, AppMaskDateDirective, ZipcodeOnlyDirective, FieldPermissionDirective]

export class SharedDirectivesModule { }
