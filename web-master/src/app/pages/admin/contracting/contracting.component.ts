
import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable } from 'rxjs';

import { DropdownModel, PaginationInfo } from '../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { GenericService } from '../../../@core/services/generic.service';
import { AdminUrlConfig } from '../admin-url.config';
import { ContractSearchModel } from '../contracting/_entities/contracting-model';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'contracting',
    templateUrl: './contracting.component.html',
    styleUrls: ['./contracting.component.scss'],
    standalone: false
})
export class ContractingComponent implements OnInit {
  contractingForm: FormGroup;
  actionTypeList$!: Observable<DropdownModel[]>;
  paTypeList$!: Observable<DropdownModel[]>;
  serchContract$!: Observable<any>;
  paginationInfo: PaginationInfo = new PaginationInfo();

  constructor(private formBulider: FormBuilder,
    private _dropDownService: CommonHttpService,
    private _service: GenericService<ContractSearchModel>) {
    this.contractingForm = this.formBulider.group({
      intakeservreqtypekey: ['', Validators.required],
      name: [''],
      federaltaxid: [''],
      agency_name: ['', Validators.required],
      ssbg_: ['', Validators.required],
      fiscal_year: [''],
      next_year: [''],
      servicerequestsubtype: ['', Validators.required]
    });
  }

  ngOnInit() {
    this.actionTypeDropdown();
    this.paTypeDropdown();
  }
  actionTypeDropdown() {
    this.actionTypeList$ = this._dropDownService.getArrayList({}, AdminUrlConfig.EndPoint.Contracting.ActionTypeUrl).pipe(map(result => {
       return result.map(res => new DropdownModel({ text: res.description, value: res.intakeservreqtypekey }));
    }));
  }
  paTypeDropdown() {
    this.paTypeList$ = this._dropDownService.getArrayList({}, AdminUrlConfig.EndPoint.Contracting.PaTypeListUrl).pipe(map(result => {
     return result.map(res => new DropdownModel({ text: res.description, value: res.servicerequestsubtype}));
    }));
  }

  searchItem() {
    this._service.endpointUrl = AdminUrlConfig.EndPoint.Contracting.SearchContractingTypeUrl;
    const source = this._service.getPagedArrayList({
      limit: 10,
      page: 1,
      where: {
        agency_name: '',
        type_key: '',
        ssbg_: '',
        fiscal_year: 2012,
      },
      method: 'post',
    }).pipe(
      map(result => {
        return { data: result, count: result.count };
      }),share(),);
    this.serchContract$ = source.pipe(pluck('data'));
  }

  get intakeservreqtypekeyControl(): FormControl { 
    return this.contractingForm.get('intakeservreqtypekey') as FormControl; 
  }

  get agencynameControl(): FormControl { 
    return this.contractingForm.get('agency_name') as FormControl; 
  }

  get ssbgControl(): FormControl { 
    return this.contractingForm.get('ssbg_') as FormControl; 
  }

  get servicerequestsubtypeControl(): FormControl { 
    return this.contractingForm.get('servicerequestsubtype') as FormControl; 
  }
}
