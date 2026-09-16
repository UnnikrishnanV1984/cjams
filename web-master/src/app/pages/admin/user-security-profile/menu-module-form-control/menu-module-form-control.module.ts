import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

import { MenuModuleFormControlRoutingModule } from './menu-module-form-control-routing.module';
import { MenuModuleFormControlComponent } from './menu-module-form-control.component';

@NgModule({
    imports: [CommonModule, MenuModuleFormControlRoutingModule],
    declarations: [MenuModuleFormControlComponent],
    exports: [MenuModuleFormControlComponent]
})
export class MenuModuleFormControlModule {}
