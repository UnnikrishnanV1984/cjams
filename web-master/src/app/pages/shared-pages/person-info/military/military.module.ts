import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MilitaryComponent } from './military.component';
import { AddMilitaryComponent } from './add-military/add-military.component';
import { MilitaryRoutingModule } from './military-routing.module';
import { ShareFeaturesModule } from '../share-features/share-features.module';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { FormMaterialModule } from '../../../../@core/form-material.module';
import { MilitaryService } from './military.service';
import { ListMilitaryComponent } from './list-military/list-military.component';

@NgModule({ declarations: [MilitaryComponent, AddMilitaryComponent, ListMilitaryComponent], imports: [CommonModule,
        MilitaryRoutingModule,
        FormMaterialModule,
        ShareFeaturesModule], providers: [MilitaryService, provideHttpClient(withInterceptorsFromDi())] })
export class MilitaryModule { }
