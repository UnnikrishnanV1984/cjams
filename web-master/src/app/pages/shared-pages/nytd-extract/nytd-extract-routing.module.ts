import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { NytdExtractComponent } from './nytd-extract.component';
import { MatSortModule } from '@angular/material/sort';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { NytdExtractResolverService } from './nytd-extract-resolver.service';
const routes: Routes = [
  {
  path: '',
  component: NytdExtractComponent,
  resolve: {
    config: NytdExtractResolverService
  },
  children: []
 }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule,
    MatTableModule,
    MatSortModule,
    MatPaginatorModule]
})
export class NytdExtractRoutingModule { }
