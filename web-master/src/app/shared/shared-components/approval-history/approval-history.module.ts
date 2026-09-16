import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ApprovalHistoryComponent } from './approval-history.component';

@NgModule({
    imports: [CommonModule],
    declarations: [ApprovalHistoryComponent],
    exports: [ApprovalHistoryComponent]
})
export class ApprovalHistoryModule { }
