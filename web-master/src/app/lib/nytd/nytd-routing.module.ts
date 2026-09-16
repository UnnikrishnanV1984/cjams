
import { NgModule } from '@angular/core';
import { NytdComponent } from './components/nytd.component';
import { Routes, RouterModule } from '@angular/router';

const routes: Routes = [
    {
        path: '', component: NytdComponent
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class NytdRoutingModule {}