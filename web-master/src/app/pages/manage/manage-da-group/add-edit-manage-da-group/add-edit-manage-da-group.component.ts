import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { FormBuilder, FormGroup } from '@angular/forms';
import { BsDatepickerConfig } from 'ngx-bootstrap/datepicker';
declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'add-edit-manage-da-group',
    templateUrl: './add-edit-manage-da-group.component.html',
    styleUrls: ['./add-edit-manage-da-group.component.scss'],
    standalone: false
})
export class AddEditManageDaGroupComponent implements OnInit {
  titlename: string;
  addEditManageDAGroup: FormGroup;
  minDate = new Date();
  colorTheme = 'theme-blue';
  bsConfig: Partial<BsDatepickerConfig> = new BsDatepickerConfig();

  constructor(private router: Router, private formBuilder: FormBuilder) {
    this.titlename = 'Add DA Group';

    this.addEditManageDAGroup = this.formBuilder.group({
      DANumber: [''],
      DADate: ['']
    });
  }

  ngOnInit() {
    this.bsConfig = Object.assign({}, {containerClass: this.colorTheme});
    this.titlename = 'Add DA Group';
    this.showAddUpdate();
  }
  showAddUpdate() {
    $('#add-edit-da-group').modal('show'); 
  }
  clearItem() {
    this.router.navigate(['/pages/manage/manage-da-group']);
    $('#add-edit-da-group').modal('hide');
  }
}
