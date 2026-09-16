import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PagesRoutingModule } from './pages-routing.module';
import { PagesComponent } from './pages.component';
import { PageHeaderModule } from '../shared/modules';
import { AlertModule } from '../shared/modules/alert/alert.module';
import { StaffReadonlyPageComponent } from './shared-pages/staff-readonly-page/staff-readonly-page.component';
import { CommonControlsModule } from '../shared/modules/common-controls/common-controls.module';
import { FormsModule } from '@angular/forms';
// import { SharedComponentsModule} from '../shared/shared-components/shared-components.module';

@NgModule({
    imports: [CommonModule, PagesRoutingModule, PageHeaderModule, AlertModule, FormsModule, CommonControlsModule
        // , SharedComponentsModule
    ],
    declarations: [PagesComponent, StaffReadonlyPageComponent],
    exports: []
})
export class PagesModule { }
