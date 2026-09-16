import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';

import { ModalButtonComponent } from './components/modal/button/modalButton.component';
import { ModalComponent } from './components/modal/modal/modal.component';

@NgModule({
    imports: [
        CommonModule
    ],
    declarations: [
        ModalButtonComponent,
        ModalComponent
    ],
    exports: [
        ModalButtonComponent,
        ModalComponent
    ]
})

export class UIModule { }