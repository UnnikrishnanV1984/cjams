import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RelationshipComponent } from './relationship.component';
import { Routes, RouterModule } from '@angular/router';

import {MatSelectModule} from '@angular/material/select';
import {MatCheckboxModule} from '@angular/material/checkbox';
import { ReactiveFormsModule } from '@angular/forms';

export const encountersModuleRoutes: Routes = [
    {
        path: '',
        component: RelationshipComponent
    }
];
@NgModule({
    imports: [CommonModule, RouterModule.forChild(encountersModuleRoutes), MatSelectModule, MatCheckboxModule,ReactiveFormsModule],
    declarations: [RelationshipComponent]
})
export class RelationshipModule {}
