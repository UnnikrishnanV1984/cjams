import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CourtComponent } from './court.component';
import { CourtTabComponent } from './court-tab/court-tab.component';
import { NotesComponent } from './notes/notes.component';
import { PetitionDetailComponent } from './petition-detail/petition-detail.component';
import { HearingDetailComponent } from './hearing-detail/hearing-detail.component';
import { CourtActionsComponent } from './court-actions/court-actions.component';
import { CourtOrderComponent } from './court-order/court-order.component';
import { AsCourtProcessingComponent } from './as-court-processing/as-court-processing.component';
import { LegalCustodyComponent } from './legal-custody/legal-custody.component';
import {CourtResolverService} from './court-resolver-service';
import { CourtTprComponent } from './court-tpr/court-tpr.component';

const routes: Routes = [{
    path: '',
    component: CourtComponent,
    // resolve: {
    //     result: CourtResolverService
    //   },
    children: [
        {
            path: 'court-tab',
            component: CourtTabComponent
        },
        {
            path: 'notes',
            component: NotesComponent
        },
        {
            path: 'petition-detail',
            component: PetitionDetailComponent
        },
        {
            path: 'hearing-detail',
            component: HearingDetailComponent
        },
        {
            path: 'court-actions',
            component: CourtActionsComponent
        },
        {
            path: 'court-order',
            component: CourtOrderComponent
        },
        {
            path: 'as-court-processing',
            component: AsCourtProcessingComponent
        },
        {
            path: 'legal-custody',
            component: LegalCustodyComponent
        },
        {
            path: 'court-tpr',
            component: CourtTprComponent
        }
    ]
}];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class CourtRoutingModule { }
