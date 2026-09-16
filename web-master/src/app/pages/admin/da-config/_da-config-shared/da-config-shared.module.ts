import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';

import { MappingCatelogueComponent } from './mapping-catelogue/mapping-catelogue.component';
import { ReviewCatelogueComponent } from './review-catelogue/review-catelogue.component';

@NgModule({
    imports: [CommonModule, RouterModule, FormsModule],
    declarations: [MappingCatelogueComponent, ReviewCatelogueComponent],
    exports: [MappingCatelogueComponent],
})
export class DaConfigSharedModule {
}
