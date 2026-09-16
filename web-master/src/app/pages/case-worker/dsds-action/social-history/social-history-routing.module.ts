import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SocialHistoryComponent } from './social-history.component';
import { SocialHistoryResolverService } from './social-history-resolver.service';
import { SocialhistoryRbResolverService } from './socialhistory-resolver.service';
const routes: Routes = [
  {
  path: '',
  component: SocialHistoryComponent,
  resolve: {
    config: SocialHistoryResolverService,
    result: SocialhistoryRbResolverService
  },
  children: []
 }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SocialHistoryRoutingModule { }
