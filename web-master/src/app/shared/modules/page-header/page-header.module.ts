import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { HeaderComponent, ClickOutside } from './header.component';
import { ReactiveFormsModule } from '@angular/forms';
// import { A2Edatetimepicker } from 'ng2-eonasdan-datetimepicker';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective } from 'ngxf-uploader';
import { NgxPaginationModule } from 'ngx-pagination';

@NgModule({
    imports: [CommonModule, RouterModule, ReactiveFormsModule, 
        // A2Edatetimepicker, 
        SharedPipesModule, NgxfDropDirective, NgxfParseDirective, NgxfSelectDirective, NgxPaginationModule],
    declarations: [HeaderComponent, ClickOutside],
    exports: [HeaderComponent]
})
export class PageHeaderModule { }
