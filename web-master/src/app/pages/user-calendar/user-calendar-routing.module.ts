import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { UserCalendarComponent } from './user-calendar.component';
const routes: Routes = [
    {
        path: '',
        component: UserCalendarComponent
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class UserCalendarRoutingModule {}
