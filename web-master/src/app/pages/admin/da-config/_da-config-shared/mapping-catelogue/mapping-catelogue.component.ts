import { Component, EventEmitter, Input, Output } from '@angular/core';

import { MasterCatelogConfig } from '../../../general/_entities/general.data.models';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'mapping-catelogue',
    templateUrl: './mapping-catelogue.component.html',
    standalone: false
})
export class MappingCatelogueComponent {
  @Input() componentConfig!: MasterCatelogConfig;
  @Input() catelogList!: any[];
  @Output() catelogSaved = new EventEmitter<any>();
  catelogData: any;

  editCatelog(catelog: any) {
    this.catelogData = catelog;
  }

  saveCatelog(catelog: any) {
    this.catelogSaved.emit(catelog);
  }
}
