import { Component, OnInit } from '@angular/core';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'add-edit-doc-types',
    templateUrl: './add-edit-doc-types.component.html',
    standalone: false
})
export class AddEditDocTypesComponent implements OnInit {

  ngOnInit() {
    this.showDocTypeEditor();
  }

  showDocTypeEditor() {
    (<any>$('#add-edit-doc-types')).modal('show'); // NOSONAR
  }

}
