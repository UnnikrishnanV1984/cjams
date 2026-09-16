import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";
import { ViewTicketsComponent } from "./view-tickets/view-tickets.component";
import { NgSelectModule } from '@ng-select/ng-select';

const routes: Routes = [
    {
      path: '',
      component: ViewTicketsComponent,
    //   resolve: {
    //     result: PlacementValidationsResolverService
    //     },
      children: [
        
        // {
        //   path: 'approved',
        //   component: ApprovedPlacementComponent
        // },
        {
          path: '**',
          redirectTo: 'view-tickets'
        }
      ]
    }
  ];
  
  @NgModule({
    imports: [RouterModule.forChild(routes),NgSelectModule],
    exports: [RouterModule]
  })
  export class PContactlogReleasenotesRoutingModule { }
  