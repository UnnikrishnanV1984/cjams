import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { IntakeEntitiesComponent } from './intake-entities.component';

const routes: Routes = [
    {
        path: '',
        component: IntakeEntitiesComponent
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class IntakeEntitiesRoutingModule {}
