import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'add-edit-non-contracting-providers',
    templateUrl: './add-edit-non-contracting-providers.component.html',
    styleUrls: ['./add-edit-non-contracting-providers.component.scss'],
    standalone: false
})
export class AddEditNonContractingProvidersComponent implements OnInit {

  constructor(private router: Router) { }

  ngOnInit() {
    this.showAddUpdate();
  }
  showAddUpdate() {
    $('#myModal-add-edit-non-contract').modal('show'); 
  }
  clearItem() {
    this.router.navigate(['/pages/manage/non-contracting-providers']);
    $('#myModal-add-edit-non-contract').modal('hide'); 
  }

}
