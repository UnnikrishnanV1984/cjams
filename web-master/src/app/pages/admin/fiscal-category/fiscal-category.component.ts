
import {map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { CommonHttpService, AlertService, AuthService } from '../../../@core/services';
import { AdminUrlConfig } from '../admin-url.config';
import { PaginationRequest, PaginationInfo, DropdownModel } from '../../../@core/entities/common.entities';
// tslint:disable-next-line: import-blacklist
import { Observable } from 'rxjs';
import { ActivatedRoute } from '@angular/router';

declare let $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'fiscal-category',
    templateUrl: './fiscal-category.component.html',
    styleUrls: ['./fiscal-category.component.scss'],
    standalone: false
})
export class FiscalCategoryComponent implements OnInit {
  paginationInfo: PaginationInfo = new PaginationInfo();
  getFiscalCodeList: any[] = [];
  fiscalForm!: FormGroup;
  editFiscalForm!: FormGroup;
  totalcount!: number;
  editIndex!: number;
  fiscalList: any;
  paymentTypes: any;
  eligibilityCheck: any;
  eligibilityCheck$!: Observable<DropdownModel[]>;
  paymentTypes$!: Observable<DropdownModel[]>;
  selectedAccount: any;
  disabled: any;
  ancillary!: string;
  fiscaldelete: any;

  constructor(private _commonService: CommonHttpService, private formBuilder: FormBuilder,
    private _commonHttpService: CommonHttpService, private route: ActivatedRoute, private _alertService: AlertService, private _authService: AuthService) { }

  ngOnInit() {
    this.initAccountForm();
    this.editIndex = -1;
    this.initEditAccountForm();
    this.loadPayment();
    this.loadEligibilityCheck();
    this.getFiscalList();
  }

  initAccountForm() {
    this.fiscalForm = this.formBuilder.group({
      fiscal_category_cd: [''],
      start_dt: [null],
      end_dt: [null],
      fiscal_category_desc: [''],
      eligibility_cd: [''],
      ancillary_maintenance_sw: [''],
      payment_type_cd: '',
      totalcount: [null]
    });
  }

  initEditAccountForm() {
    this.editFiscalForm = this.formBuilder.group({
      fiscal_category_id: [''],
      fiscal_category_cd: [''],
      start_dt: [''],
      end_dt: [''],
      fiscal_category_desc: [''],
      eligibility_cd: [''],
      ancillary_maintenance_sw: [''],
      payment_type_cd: '',
      totalcount: [null]
    });
    this.editFiscalForm.get('fiscal_category_cd')?.disable();
  }

  getFiscalList() {
    this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: this.paginationInfo.pageNumber,
          limit: this.paginationInfo.pageSize,
          where: {
            'fiscal_category_id': null,
            sortcolumn: 'fiscal_category_desc',
            sortorder: 'ase'
          },
            method: 'get'
        }),
        AdminUrlConfig.EndPoint.finance.fiscalCodeListUrl + '?filter'
        ).subscribe((res: any) => {
            this.getFiscalCodeList = res.data;
            this.totalcount = res.count;
      });
  }

  pageChanged(pageNumber: number) {
    this.paginationInfo.pageNumber = pageNumber;
    this.getFiscalList();
  }

  loadPayment() {
    this.paymentTypes$ = this._commonService.getArrayList({
      where: {picklist_type_id : '1'},
      nolimit: true,
      method: 'get'
    }, AdminUrlConfig.EndPoint.finance.AddFiscalPickList + '?filter'
    ).pipe( map((result) => {
      return result.map(
          (res) =>
              new DropdownModel({
                  text: res.value_tx,
                  value: res.picklist_value_cd
              })
      );
    }));
  }

  loadEligibilityCheck() {
    this.eligibilityCheck$ = this._commonService.getArrayList({
      where: {picklist_type_id : '446'},
      nolimit: true,
      method: 'get'
    }, AdminUrlConfig.EndPoint.finance.AddFiscalPickList + '?filter'
    ).pipe( map((result) => {
      return result.map(
          (res) =>
              new DropdownModel({
                  text: res.value_tx,
                  value: res.description_tx
              })
      );
    }));
  }

  addFiscal() {
    if (this.fiscalForm.valid) {
      const data = this.fiscalForm.getRawValue();
      if (this.fiscalForm.get('eligibility_cd')?.value === 'Yes') {
        this.eligibilityCheck = '3951';
      } else if (this.fiscalForm.get('eligibility_cd')?.value === 'No') {
        this.eligibilityCheck = '3952';
      } else if (this.fiscalForm.get('eligibility_cd')?.value === 'N/A') {
        this.eligibilityCheck = '3950';
      }
      this._commonService.create({
        fiscal_category_cd: data.fiscal_category_cd,
        start_dt: data.start_dt,
        end_dt: data.end_dt,
        fiscal_category_desc: data.fiscal_category_desc,
        eligibility_cd: this.eligibilityCheck,
        ancillary_maintenance_sw: data.ancillary_maintenance_sw,
        payment_type_cd: data.payment_type_cd
      },
      AdminUrlConfig.EndPoint.finance.AddFiscalCode).subscribe(result => {
        if (!result.insertstatus) {
          if (result.value === 'false') {
            this._alertService.warn('Fiscal Category Code Already exists');
          } else {
              this._alertService.success('Fiscal Category Code Added');
              $('#add-fiscal').modal('hide');
              this.fiscalForm.reset();
              this.getFiscalList();
          }
        }
      });
  } else {
    this._alertService.warn('Please fill the mandatory details.');
  }
  }

  updateFiscal() {
    if (this.editFiscalForm.valid) {
      const data = this.editFiscalForm.getRawValue();
      if (this.editFiscalForm.get('eligibility_cd')?.value === 'Yes') {
        this.eligibilityCheck = '3951';
      } else if (this.editFiscalForm.get('eligibility_cd')?.value === 'No'){
        this.eligibilityCheck = '3952';
      } else if (this.editFiscalForm.get('eligibility_cd')?.value === 'N/A') {
        this.eligibilityCheck = '3950';
      }
      this._commonService.create({
        fiscal_category_id: data.fiscal_category_id,
        fiscal_category_cd: data.fiscal_category_cd,
        start_dt: data.start_dt,
        end_dt: data.end_dt,
        fiscal_category_desc: data.fiscal_category_desc,
        eligibility_cd: this.eligibilityCheck,
        ancillary_maintenance_sw: data.ancillary_maintenance_sw,
        payment_type_cd: data.payment_type_cd
      },
      AdminUrlConfig.EndPoint.finance.UpdateFiscalCode).subscribe(result => {
        if (!result.insertstatus) {
          this._alertService.success('Fiscal Category Code Updated Successfully');
          $('#update-fiscal').modal('hide');
          this.getFiscalList();
        }
      });
  } else {
    this._alertService.warn('Please fill the mandatory details.');
  }
  }

  editAccount(fiscal: any) {
    this.selectedAccount = fiscal;
    this.editFiscalForm.patchValue({
      fiscal_category_id: fiscal.fiscal_category_id,
      fiscal_category_cd: fiscal.fiscal_category_cd,
      start_dt: fiscal.start_dt,
      end_dt: fiscal.end_dt,
      fiscal_category_desc: fiscal.fiscal_category_desc,
      eligibility_cd: fiscal.eligibilitytype,
      payment_type_cd: fiscal.payment_type_cd,
      ancillary_maintenance_sw: fiscal.ancillary_maintenance_sw
    });
  }

  confirmDelete(fiscal: any) {
    this.fiscaldelete = fiscal.fiscal_category_id;
    $('#delete-popup').modal('show');
  }

  deleteAccount() {
    this._commonService.create({fiscal_category_id: this.fiscaldelete}, AdminUrlConfig.EndPoint.finance.DeleteFiscalCode).subscribe(
      (response) => {
        $('#delete-popup').modal('hide');
        this._alertService.success('Fiscal Category Deleted Successfully');
        this.getFiscalList();
      });
  }

  viewAccount(fiscal: any) {
    this.selectedAccount = fiscal;
      if(fiscal.ancillary_maintenance_sw === 'A') {
        this.ancillary = 'Ancillary';
      } else {
        this.ancillary = 'Maintenance';
      }
    this.closeModal();
  }
 
  closeModal() {
    $('#view-fiscal').modal('hide');
  }

  clearItem() {
    this.fiscalForm.reset();
  }
}
