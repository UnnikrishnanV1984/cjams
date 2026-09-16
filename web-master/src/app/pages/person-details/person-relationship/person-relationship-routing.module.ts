import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonRelationshipComponent } from './person-relationship.component';
import { SearchRelationshipComponent } from './search-relationship/search-relationship.component';
import { RoleGuard } from '../../../@core/guard';
import { RelationshipService } from './relationship.service';
import { RelationshipResolverService } from './relationship-resolver.service';
import { RelativePersonGridComponent } from './relative-person-grid/relative-person-grid.component';


const routes: Routes = [
  {
    path: '',
    component: PersonRelationshipComponent,
    children: [
      { path: 'persons',
      component: RelativePersonGridComponent,
      resolve: {
        relations: RelationshipResolverService
      } },
      {
        path: 'search',
        component: SearchRelationshipComponent,
      },
      { path: '**', redirectTo: 'persons' }
    ],
    canActivate: [RoleGuard],
    data: {
      screen: { modules: ['pages', 'menus'], skip: false }
    }
  }
];


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
  providers: [RelationshipService, RelationshipResolverService]
})
export class PersonRelationshipRoutingModule { }
