import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CpsDocLetterComponent } from './cps-doc-letter/cps-doc-letter.component';

const routes: Routes = [
    {
        path: 'cps-doc',
        component: CpsDocLetterComponent
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class IntakeDocumentCreatorRoutingModule {}
