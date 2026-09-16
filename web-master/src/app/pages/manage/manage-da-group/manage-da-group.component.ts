import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { GenericService } from '../../../@core/services';
import { ManageDAGroupConfig } from '../_entities/manage.data.models';
import { BsDatepickerConfig } from 'ngx-bootstrap/datepicker';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'manage-da-group',
    templateUrl: './manage-da-group.component.html',
    styleUrls: ['./manage-da-group.component.scss'],
    standalone: false
})
export class ManageDaGroupComponent implements OnInit {
  manageDAGroupForm: FormGroup;
  minDate = new Date();
  bsConfig: Partial<BsDatepickerConfig> = new BsDatepickerConfig();

  constructor(private formBuilder: FormBuilder,
    private _service: GenericService<ManageDAGroupConfig>) {
    this.manageDAGroupForm = this.formBuilder.group({
      groupnumber: ['', Validators.required],
      createdDate: ['', Validators.required]
    });
  }

  ngOnInit() {
    this.bsConfig = Object.assign({}, { containerClass: 'theme-blue' });
  }

}
