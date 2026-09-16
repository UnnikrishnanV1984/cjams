import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { HelpComponent } from './help.component';

const routes: Routes = [
    {
        path: '',
        component: HelpComponent,
        children: [{ path: 'api-refferance', loadChildren: () => import( './api-refferance/api-refferance.module').then(m => m.ApiRefferanceModule) }],
        data: {
            title: ['MDTHINK Help'],
            desc: 'MDTHINK'
        }
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class HelpRoutingModule {}
