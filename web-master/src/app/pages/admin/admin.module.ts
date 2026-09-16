import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
// import { A2Edatetimepicker} from 'ng2-eonasdan-datetimepicker';
import { AdminRoutingModule } from './admin-routing.module';
import { AdminComponent } from './admin.component';


@NgModule({
    imports: [
        CommonModule,
        AdminRoutingModule,
        // A2Edatetimepicker
    ],
    declarations: [AdminComponent]
})
export class AdminModule {}
