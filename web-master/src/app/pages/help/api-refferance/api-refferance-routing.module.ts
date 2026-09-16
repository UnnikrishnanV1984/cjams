import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { ApiRefferanceComponent } from './api-refferance.component';

const routes: Routes = [
    {
        path: '',
        component: ApiRefferanceComponent
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class ApiRefferanceRoutingModule {}
