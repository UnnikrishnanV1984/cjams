import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';

import { SharedPipesModule } from '../../../../../@core/pipes/shared-pipes.module';
import { AllegationConfigurationRoutingModule } from './allegation-configuration-routing.module';
import { AllegationConfigurationComponent } from './allegation-configuration.component';

@NgModule({
    imports: [CommonModule, AllegationConfigurationRoutingModule, ReactiveFormsModule, SharedPipesModule],
    declarations: [AllegationConfigurationComponent]
})
export class AllegationConfigurationModule {}
