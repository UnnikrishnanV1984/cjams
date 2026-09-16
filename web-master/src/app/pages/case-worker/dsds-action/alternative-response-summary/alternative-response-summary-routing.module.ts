import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AlternativeResponseSummaryComponent } from './alternative-response-summary.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SharedDirectivesModule } from '../../../../@core/directives/shared-directives.module';
import { SharedPipesModule } from '../../../../@core/pipes/shared-pipes.module';
import { AlternativeResponseSummaryResolverService } from './alternative-response-summary-resolver-service';

const routes: Routes = [{
  path: '',
  component: AlternativeResponseSummaryComponent,
  // resolve: {
  //   result: AlternativeResponseSummaryResolverService
  // },
}];

@NgModule({
  imports: [RouterModule.forChild(routes), FormsModule,ReactiveFormsModule,  SharedDirectivesModule,  SharedPipesModule,],
  exports: [RouterModule, FormsModule,ReactiveFormsModule,  SharedDirectivesModule,  SharedPipesModule,]
})
export class AlternativeResponseSummaryRoutingModule { }
