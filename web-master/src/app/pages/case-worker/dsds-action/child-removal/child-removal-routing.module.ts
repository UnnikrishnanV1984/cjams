import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ChildRemovalWrapperComponent } from './child-removal-wrapper/child-removal-wrapper.component';
import { ChildRemovalDetailComponent } from './child-removal-detail/child-removal-detail.component';
import { ChildRemovalResolverService } from './child-removal-resolver.service';

const routes: Routes = [{


  path: '',
  component: ChildRemovalWrapperComponent,
  resolve: {
    config: ChildRemovalResolverService
  },
  children: [
    {
      path: 'details',
      component: ChildRemovalDetailComponent,
      children: [
        {
          path: 'disability',
          loadChildren: () => import( '../../../shared-pages/person-disability/person-disability.module').then(m => m.PersonDisabilityModule)
        }
      ]
    },
    { path: 'view', loadChildren: () => import( '../assessment/case-worker-view-assessment/case-worker-view-assessment.module').then(m => m.CaseWorkerViewAssessmentModule) },
  ]
},

{ path: '**', redirectTo: 'details' }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ChildRemovalRoutingModule { }
