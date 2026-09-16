import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { GuardianshipComponent } from './titleIVe-guardianship.component';
import { GuardianshipResolverService } from './titleIVe-guardianship-resolver.service';
const routes: Routes = [
    {
        path: '',
        component: GuardianshipComponent,
        resolve: {
            gapData: GuardianshipResolverService
        },
        children: []
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class GuardianshipRoutingModule { }
