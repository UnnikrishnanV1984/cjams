import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NytdExtractComponent } from './nytd-extract.component';
import { NytdExtractRoutingModule } from './nytd-extract-routing.module';
import { NytdExtractService } from './nytd-extract.service';
import { FormMaterialModule } from '../../../@core/form-material.module';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { MatSortModule } from '@angular/material/sort';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { NytdExtractResolverService } from './nytd-extract-resolver.service';
@NgModule({
  imports: [
    CommonModule,
    NytdExtractRoutingModule,
    FormMaterialModule,
    MatTableModule,
    MatSortModule,
    MatPaginatorModule,
    SharedPipesModule
  ],
  declarations: [NytdExtractComponent],
  providers: [NytdExtractService, NytdExtractResolverService]
})
export class NytdExtractModule { }
