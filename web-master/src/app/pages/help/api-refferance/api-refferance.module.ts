import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

import { ApiRefferanceRoutingModule } from './api-refferance-routing.module';
import { ApiRefferanceComponent } from './api-refferance.component';

@NgModule({
    imports: [CommonModule, ApiRefferanceRoutingModule],
    declarations: [ApiRefferanceComponent]
})
export class ApiRefferanceModule {}
