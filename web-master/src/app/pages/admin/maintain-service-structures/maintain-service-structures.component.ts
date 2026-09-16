
import {map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { PaginationRequest, PaginationInfo, DropdownModel } from '../../../@core/entities/common.entities';
import { AdminUrlConfig } from '../admin-url.config';
import { CommonHttpService, AlertService } from '../../../@core/services';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { FormBuilder, FormGroup } from '@angular/forms';
import { FinanceUrlConfig } from '../../finance/finance.url.config';
import { Observable } from 'rxjs';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'maintain-service-structures',
    templateUrl: './maintain-service-structures.component.html',
    styleUrls: ['./maintain-service-structures.component.scss'],
    standalone: false
})
export class MaintainServiceStructuresComponent implements OnInit {
  paginationInfo: PaginationInfo = new PaginationInfo();
  getPlacementStructureList: any[] = [];
  totalcount!: number;
  placementForm!: FormGroup;
  associateFiscalForm!: FormGroup;
  agencyProvideList$!: Observable<DropdownModel[]>;
  serviceCategoryList$!: Observable<DropdownModel[]>;
  categoryList$!: Observable<DropdownModel[]>;
  nonCategoryList$!: Observable<DropdownModel[]>;
  nonCategoryList!: any[];
  categoryList!: any[];
  placementCategory!: boolean;
  serviceid: any;
  categoryCode!: any[];
  categoryID: any;
  nonCategoryID: any;
  placementDetails: any;

  constructor(
    private _commonService: CommonHttpService,
    private formBuilder: FormBuilder,
    private _alertService: AlertService) { }

  ngOnInit() {
    this.getPlacementList();
    this.initPlacementForm();
    this.getAgencyList();
    this.getServiceCategory();
    this.clearPlacementForm();
    this.getAssociateCategoryList();
    this.getAssociateCategoryListNonIV();
  }

  initPlacementForm() {
    this.placementForm = this.formBuilder.group({
      service_id: '',
      structure_service_cd: [''],
      service_nm: [''],
      servicecategorydesc: [''],
      child_account_sw: [false],
      activePlacement: [true],
      paid_non_paid_cd: [null],
      iv_e_allowable_sw: [false],
      state_ldss_cd: [null],
      county_cd: [''],
      // start_dt: [''],
      // end_dt: [''],
      // fiscal_category_desc: [''],
      // eligibility_cd: [''],
      // ancillary_maintenance_sw: [''],
      create_ts: [null]
    });
    this.associateFiscalForm = this.formBuilder.group({
      category: [null],
      nonCategory: [null]
    });
    this.placementForm.patchValue({
      structure_service_cd: 'S'
    });
    if (this.placementForm.get('child_account_sw')?.value === false) {
      this.placementForm.patchValue({
        child_account_sw: 'N'
      });
    }
    if (this.placementForm.get('iv_e_allowable_sw')?.value === false) {
      this.placementForm.patchValue({
        iv_e_allowable_sw: 'N'
      });
    }
  }

  getPlacementList() {
    this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: this.paginationInfo.pageNumber,
          limit: this.paginationInfo.pageSize,
          where: {
            'service_id': null
          },
            method: 'get'
        }),
        AdminUrlConfig.EndPoint.placement.GetPlacementList + '?filter'
        ).subscribe((res: any) => {
            this.getPlacementStructureList = res.data;
            this.totalcount = res.count;
      });
  }

  pageChanged(pageNumber: number) {
    this.paginationInfo.pageNumber = pageNumber;
    this.getPlacementList();
  }
  addService() {
    this.placementCategory = false;
    this.placementForm.reset();
    this.placementForm.patchValue({
      structure_service_cd: 'S'
    });
  }

  editPlacement(placement: any) {
    this.placementDetails = placement;
    this.placementCategory = true;
    this.serviceid = placement.service_id;
    this.placementForm.patchValue(placement);
    setTimeout(() => {
      this.placementForm.patchValue({
        paid_non_paid_cd: placement.paid_non_paid_cd
      });
  }, 100);
}

viewPlacement(placement: any) {
  this.placementDetails = placement;
}

  addPlacementService(placementForm: any) {
    placementForm.create_ts = new Date();
    this._commonService.endpointUrl = 'tb_services/addupdate';
    this._commonService.create(placementForm).subscribe(
      (response) => {
        this._alertService.success('Placement Service Added Successfully');
        this.getPlacementList();
        (<any>$('#placement-popup')).modal('hide');
        this.clearPlacementForm();
      },
      (error) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

  clearItem() { 
    (<any>$('#placement-popup')).modal('hide');
  }

  closeModal() {
    (<any>$('#view-placement')).modal('hide');
  }

  categoryChange(value: any) {
    this.categoryID = value;
    if (this.nonCategoryID) {
      this.categoryCode = [];
      this.categoryCode.push(this.categoryID, this.nonCategoryID);
    } else {
      this.categoryCode = [].concat(this.categoryID);
    }
  }

  nonCategoryChange(value: any) {
    this.nonCategoryID = value;
    if (this.categoryID) {
      this.categoryCode = [];
      this.categoryCode.push(this.categoryID, this.nonCategoryID);
    } else {
      this.categoryCode = [].concat(this.nonCategoryID);
    }
  }

  addPlacementCategory() {
    this._commonService.endpointUrl = 'tb_placement_stru_category_link/addupdate';
    const modal = {
      service_id: this.serviceid,
      fiscal_category_id: this.categoryCode
    };
    this._commonService.create(modal).subscribe(
      (response) => {
        this._alertService.success('Associate category added successfully');
        (<any>$('#associate-fiscal')).modal('hide');
        this.getPlacementList();
    },
    (error) => {
      this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  clearPlacementForm() {
    this.placementForm.reset();
    this.placementForm.patchValue({
      activePlacement: true
    });
 }
  getAgencyList() {
    this.agencyProvideList$ = this._commonService.getArrayList({
      where: {picklist_type_id : '333'},
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
    ).pipe( map((result) => {
      return this.returnResultMapFn(result);
  }));
  }

  getServiceCategory() {
    this.serviceCategoryList$ = this._commonService.getArrayList({
      where: {picklist_type_id : '333'},
      nolimit: true,
      method: 'get'
    }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
    ).pipe( map((resultt) => {
      return this.returnResultMapFn(resultt);
  }));
  }

  private returnResultMapFn(resultt: any[]): DropdownModel[] {
    return resultt.map(
      (res) => new DropdownModel({
        text: res.description_tx,
        value: res.picklist_value_cd
      })
    );
  }

  allowableSWCheck(event: any) {
    if (event) {
      this.placementForm.patchValue({
        iv_e_allowable_sw: 'Y'
      });
    } else {
      this.placementForm.patchValue({
        iv_e_allowable_sw: 'N'
      });
    }
  }

  childAccountCheck(event: any) {
    if (event) {
      this.placementForm.patchValue({
        child_account_sw: 'Y'
      });
    } else {
      this.placementForm.patchValue({
        child_account_sw: 'N'
      });
    }
  }

  getAssociateCategoryList() {
    this._commonService.getArrayList({
      where: {eligibilitycd: '3951'},
      method: 'get'
    }, 'tb_fiscal_category_master/listplacementstructures?filter'
    ).subscribe((response) => {
      this.categoryList = response;
    });
  }

  getAssociateCategoryListNonIV() {
    this._commonService.getArrayList({
      where: {eligibilitycd: '3952'},
      method: 'get'
    }, 'tb_fiscal_category_master/listplacementstructures?filter'
    ).subscribe((response) => {
      this.nonCategoryList = response;
    });
  }
}
