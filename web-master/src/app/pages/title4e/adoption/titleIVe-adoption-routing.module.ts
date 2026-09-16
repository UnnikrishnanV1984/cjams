import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AdoptionComponent } from './titleIVe-adoption.component';
import { AdoptionResolverService } from './titleIVe-adoption-resolver.service';
const routes: Routes = [
    {
        path: '',
        component: AdoptionComponent,
        resolve: {
            adoptionData: AdoptionResolverService
        },
        children: []
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class AdoptionRoutingModule { }
