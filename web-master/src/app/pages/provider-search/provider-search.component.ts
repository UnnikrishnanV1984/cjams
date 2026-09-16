import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { CommonHttpService, AlertService, DataStoreService, AuthService } from '../../@core/services';
import { PaginationRequest, PaginationInfo } from '../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../case-worker/case-worker-url.config';
import moment from 'moment';
import { AppUser } from '../../@core/entities/authDataModel';
import { ServiceCasePlacementsService } from '../case-worker/dsds-action/service-case-placements/service-case-placements.service';
import { FinanceService } from '../finance/finance.service';
@Component({
    selector: 'provider-search',
    templateUrl: './provider-search.component.html',
    styleUrls: ['./provider-search.component.scss'],
    standalone: false
})
export class ProviderSearchComponent implements OnInit {
  providerSearchForm!: FormGroup;
  childCharacteristics!: any[];
  otherLocalDeptmntType!: any[];
  placementStrType!: any[];
  bundledPlcmntServicesType!: any[];
  genderDropdownItems!: any[];
  paginationInfo: PaginationInfo = new PaginationInfo();
  reportedChildDob: any;
  fcProviderSearch: any[]=[];
  fcTotal!: number;
  currProcess!: string;
  selectedProvider: any;
  selectedViewProvider: any;
  userInfo!: AppUser;
  county: any;
  totalRecords: any;
  totalPage: number[] = new Array(10).fill(0);
  placementid: any;
  placementproviderid: any;
  placementindex: any;
  placementList:any[]= [];
  isAuthorized :any; //for fortify issues 
  pageInfo: PaginationInfo[] = new Array(10).fill(new PaginationInfo());
  showSsnMask = true;
  showSubDetail: number | null = null;

  constructor(
    private formBuilder: FormBuilder,
    private _commonService: CommonHttpService,
    private _authService: AuthService,
    private _alertService: AlertService,
    private _dataStoreService: DataStoreService,
    private _ServiceCasePlacementsService: ServiceCasePlacementsService,
    private _providerpopup: FinanceService
  ) { }

  ngOnInit() {
    this.isAuthorized= this._dataStoreService.isAuthorized(); //for fortify issues 
    this.userInfo = this._authService.getCurrentUser();
    this.initProviderSearchForm();
    this.getChildCharacteristics();
    this.getOtherLocalDeptmntType();
    this.getPlacementStrType(null);
    this.getBundledPlcmntServicesType();
    this.loadGenderDropdownItems();
  }

  initProviderSearchForm() {
    this.providerSearchForm = this.formBuilder.group({
      childcharacteristics: [null],
      bundledplacementservices: [null],
      otherLocalDeptmntTypeId: [null],
      placementstructures: [null],
      zipcode: null,
      isLocalDpt: [true],
      firstname: null,
      providername: null,
      middlename: null,
      lastname: null,
      isgender: [null],
      isAge: [null],
      providerid: null,
      taxId: null,
      agemin: null,
      agemax: null,
      gender: null
    });
  }

  getRangeArray(n: number): any[] {
    return Array(n);
  }

  getChildCharacteristics() {
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'picklist_type_id': '43'
      },
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.childCharacteristicsUrl).subscribe(result => {
      this.childCharacteristics = result;
    });
  }

  getOtherLocalDeptmntType() {
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'picklist_type_id': '104'
      },
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.otherLocalDeptmntTypeUrl).subscribe(result => {
      this.otherLocalDeptmntType = result;
      this.county = this.userInfo.user.userprofile.primarycountycd.trim();
      this.providerSearchForm.controls['otherLocalDeptmntTypeId'].setValue([this.county]);
    });
  }

  getPlacementStrType(providerId:any) {
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'structure_service_cd': 'P',
        'provider_id': providerId
      },
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.placementStrTypeUrl).subscribe(result => {
      this.placementStrType = result;
    });
  }

  getBundledPlcmntServicesType() {
    this._commonService.getArrayList(new PaginationRequest({
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.bundledPlcmntServicesTypeUrl).subscribe(result => {
      this.bundledPlcmntServicesType = result;
    });
  }

  loadGenderDropdownItems() {
      this.genderDropdownItems = [{
        key:null,description:''
      },{
        key:1281,description:'Female'
      },{
        key:1282,description:'Male'
      },{
        key:1283,description:'Unknown'
      },{
        key:3297,description:'Either'
      }];
  }

  getFcProviderSearch() {
    document?.getElementById('search-list')?.scrollIntoView();
    if (this.providerSearchForm.invalid) {
      this._alertService.error('Please fill required fields');
      return false;
    }



    const formValues = this.providerSearchForm?.getRawValue();
    if (formValues.isgender && !formValues.gender) {
      this._alertService.error('Please select gender');
      return false;
    }

    formValues.gender = formValues.gender ? formValues.gender : null;

    Object.keys(this.providerSearchForm.controls).forEach(key => {
      formValues[key] = this.CheckFormControlValue(formValues[key]);
    });
    const body = this.formatBodyDataFn(formValues);

    const dob = moment(this.reportedChildDob);
    const age16 = dob.clone().add(16, 'years');
    const age21 = dob.clone().add(21, 'years');
    const isAgeBtwn16And18 = moment().isBetween(age16, age21, null, '[]');
    if (isAgeBtwn16And18 && formValues.placementStrTypeId === '1') {// Independent Living Residential Program
      this._alertService.error('A child between the age of 16 and 21 years cannot be placed in \'Independent Living Residential Program\' Placement Structure.');
      return false;
    }
    this.fcProviderSearchApiFn(body);
  }

  private formatBodyDataFn(formValues: any) {
    const body :{[key:string]:any}= {};
    Object.assign(body, formValues);
    body['isLocalDpt'] = formValues.isLocalDpt ? formValues.isLocalDpt : false;
    body['localdepartmenthomecaregiver'] = formValues.isLocalDpt ? formValues.isLocalDpt : false;
    body['childcharacteristics'] = formValues.childcharacteristics ? formValues.childcharacteristics.join() : null;
    body['otherLocalDeptmntTypeId'] = formValues.otherLocalDeptmntTypeId && formValues.otherLocalDeptmntTypeId.length ? formValues.otherLocalDeptmntTypeId.join() : null;
    body['placementstructures'] = formValues.placementstructures && formValues.placementstructures.length ? formValues.placementstructures.join() : null;
    body['bundledplacementservices'] = formValues.bundledplacementservices && formValues.bundledplacementservices.length ? formValues.bundledplacementservices.join() : null;
    body['global'] = true;
    return body;
  }

  private fcProviderSearchApiFn(body: {}) {
    this._commonService.getPagedArrayList(new PaginationRequest({
      where: body,
      page: this.paginationInfo.pageNumber,
      limit: 10,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fcProviderSearchUrl).subscribe(result => {
      this.fcProviderSearch = result.data;
      this.fcTotal = result.count;
      (<any>$('#fc_list')).click();
      this.currProcess = 'select';
    });
  }

  CheckFormControlValue(formControl:any) {
    return (formControl && formControl !== '') ? formControl : null;
  }

  backToSearch() {
    this.currProcess = 'search';
    this.selectedProvider = null;
  }

  localdptSelected(event:any) {

    if (event.value) {

      this.providerSearchForm?.get('firstname')?.enable();
      this.providerSearchForm?.get('middlename')?.enable();
      this.providerSearchForm?.get('lastname')?.enable();
      this.providerSearchForm?.get('providername')?.reset();
    } else {
      this.providerSearchForm?.get('firstname')?.reset();
      this.providerSearchForm?.get('middlename')?.reset();
      this.providerSearchForm?.get('lastname')?.reset();
      this.providerSearchForm?.get('providername')?.enable();
    }
  }

  resetproviderSearchForm() {
    this.providerSearchForm.reset();
    this.fcProviderSearch = [];
    this.fcTotal = 0;
  }

  fcPageChanged(pageEvent:any) {
    this.paginationInfo.pageNumber = pageEvent.page;
    this.getFcProviderSearch();
  }

  selectedViewProv(provId:any) {
    this.selectedViewProvider = provId;
  }

  formatPhoneNumber(phoneNumberString:string) {

    const cleaned = ('' + phoneNumberString).replace(/\D/g, '');
    const match = cleaned.match(/^(\d{3})(\d{3})(\d{4})$/);
    if (match) {
      return '(' + match[1] + ') ' + match[2] + '-' + match[3];
    }
    return null;

  }
  getLicenseCoordinatorName(obj:any) {
    let name = '';
    if (obj && obj.length > 0) {
      obj.forEach((namObj:any, index:number) => {
        name = name + namObj.license_cordinator;
        name = ((index + 1) < obj.length) ? name + ',' : name;
      });
      return name;
    } else {
      return name;
    }
  }
  showProviderPopup(providerID:any) {
    this._dataStoreService.setData('ProviderInfoID', providerID);
    (<any>$('#provider-info-popup')).modal('show');
    this._providerpopup.getProviderDetails(providerID);
    this._providerpopup.page = 'Both';
  }
  checkAccordionRow(id: string, value: any): boolean {
    return id.includes(value);
  }
  toggleTable(id:any, providerid:any, index:number, mode:string) {
    this.placementList = [];
    this.placementid = id;
    this.placementproviderid = providerid;
    this.placementindex = index;
    this.openOrCloseSubTabFn(id, index);
    if (mode === 'search') {
      this.pageInfo[index].pageNumber = 1;
      (<any>$('.collapse.in')).collapse('hide');
      (<any>$('#' + id)).collapse('toggle');
    }
    (<any>$('.provider-details tr')).removeClass('selected-bg');
    (<any>$(`#provider-details-${index}`)).addClass('selected-bg');
     this._commonService.getPagedArrayList(new PaginationRequest({
      where: {providerid: providerid, pagenumber: this.pageInfo[index].pageNumber,
        pagesize: 10
      },
      method: 'post'
    }), 'tb_provider/getplacementlist').subscribe((result: any) => {
      if (result) {
      this.placementList = result.data;
      this.totalPage[index] = (this.placementList && this.placementList.length > 0) ? this.placementList[0]?.totalcount : 0;
    }
    });
  }
  private openOrCloseSubTabFn(id: any, index: number) {
    if (this.checkAccordionRow(id, 'accordion-tables')) {
      if (this.showSubDetail === index) {
        this.showSubDetail = null;
      } else {
        this.showSubDetail = index;
      }
    }
  }

  pageChanged(pageno:number, index:number) {
    this.pageInfo[index].pageNumber = pageno;
    this.toggleTable(this.placementid, this.placementproviderid, this.placementindex, 'pagination');
  }

}
