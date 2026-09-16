import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

import { UserSecurityProfileRoutingModule } from './user-security-profile-routing.module';
import { UserSecurityProfileComponent } from './user-security-profile.component';


@NgModule({
    imports: [CommonModule, UserSecurityProfileRoutingModule],
    declarations: [UserSecurityProfileComponent]
})
export class UserSecurityProfileModule {}
