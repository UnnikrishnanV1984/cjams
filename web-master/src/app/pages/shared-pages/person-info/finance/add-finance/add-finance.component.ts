
import {of as observableOf,  Observable } from 'rxjs';

import {map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { PersonInfoService } from '../../person-info.service';
import { CommonDropdownsService, AlertService, AuthService } from '../../../../../@core/services';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { DropdownModel, ListDataItem, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { InvolvedPersonsService } from '../../../involved-persons/involved-persons.service';
import { NewUrlConfig } from '../../../../newintake/newintake-url.config';
import { AppUser } from '../../../../../@core/entities/authDataModel';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'add-finance',
    templateUrl: './add-finance.component.html',
    styleUrls: ['./add-finance.component.scss'],
    standalone: false
})
export class AddFinanceComponent implements OnInit {
  personid= '';
  assetInfo:any=[];
  incomeInfo:any=[];
  supportInfo:any=[];
  csesInfo:any= {supportorder: {}};
  showcsesDetails:boolean = false;
  secondarySchool:any= [];
  vocational:any= [];
  activity:any= [];
  employer:any= [];
  personDisabilities:any= [];
  selectedmainTab: any;
  suggestedAddress$!: Observable<any[]>;
  stateDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems$!: Observable<DropdownModel[]>;
  typeofAssetDropDownItem$!: Observable<DropdownModel[]>;
  AssetVerificationDropDownItem$!: Observable<DropdownModel[]>;
  AssestDisregardDropDownItem$!: Observable<DropdownModel[]>;
  IncomeDisregardDropDownItem$!: Observable<DropdownModel[]>;
  IncomeVerificationDropDownItem$!: Observable<DropdownModel[]>;
  IncomeFrequencyDropDownItem$!: Observable<DropdownModel[]>;
  IncomeSourceDropDownItem$!: Observable<DropdownModel[]>;
  SupportOrderStatusDownItem$!: Observable<DropdownModel[]>;
  SupportPaymentFrequencyDropDownItem$!: Observable<DropdownModel[]>;
  SupportOrderStateDropDownItem$!: Observable<DropdownModel[]>;
  incomeDetailsFormGroup!: FormGroup;
  deemedparentFormGroup!: FormGroup;
  childcareexpensesFormGroup!: FormGroup;
  supportorderFormGroup!: FormGroup;
  assetFormGroup!: FormGroup;
  selectedTab = '';
  caseId :any= '';
  income_result:any=[];
  asset_result:any=[];
  support_order_result:any=[];
  cses_result :any=[];
  addIncomeDetails= false;
  assetenteredby: any=[];
  incomeenteredby: any=[];
  addAssetDetails:boolean= false;
  addSupportDetails= false;
  involvedPersonList: any[]=[];
  involvedPerson: any;
  caseNumber
  dob: any;
  userProfile: AppUser;
  currentDate;
  personincomehasvalue!: boolean;
  showpersonassestsvalue!: boolean;
  deleteItem: any;
  deleteScreen: any;
  beaconreviewuser: boolean= false;
  deletepopupid = '#delete-popup';
  constructor(
    private _formBuilder: FormBuilder,
    public _personInfoService: PersonInfoService,
    private _alertSevice: AlertService,
    private _commonDropdownService: CommonDropdownsService,
    private _commonHttpService: CommonHttpService,
    private _service: InvolvedPersonsService,
    private _authService: AuthService
  ) {
    this.userProfile = this._authService.getCurrentUser();
    this.caseId = this._personInfoService?.getCaseId();
    this.caseNumber= this._personInfoService.getCaseNumber();
    this.currentDate = new Date();
    if (this._personInfoService.personInfo && this._personInfoService.personInfo.personbasicdetails) {
      this.personid = this._personInfoService.personInfo.personbasicdetails.personid;
      this.dob = this._personInfoService.personInfo.personbasicdetails.dob;
      this.loadIncomeDetails(this._personInfoService.personInfo.personbasicdetails.personid);
      this.loadAssetDetails(this._personInfoService.personInfo.personbasicdetails.personid);
      this.loadSupportOrderDetails(this._personInfoService.personInfo.personbasicdetails.personid);
      this.loadInvolvedPersons();
    }
    this.initiateFormGroup();
    const _self = this;
    this._personInfoService.personInfoListener$.subscribe(personInfo => {
      if (!_self.personid || _self.personid === '') {
      this.personid = personInfo.personbasicdetails.personid;
      this.loadIncomeDetails(personInfo.personbasicdetails.personid);
      this.loadAssetDetails(personInfo.personbasicdetails.personid);
      this.loadSupportOrderDetails(personInfo.personbasicdetails.personid);
      this.loadInvolvedPersons();
      }
    });
  }
  changePerson() {
    this.loadCsesDetails(this.involvedPerson);
  }
  loadInvolvedPersons() {
    this._personInfoService.getInvolvedPersons().subscribe(response  => {
      if (response && response.data) {

        this.involvedPersonList = response.data;

      }
    });
  }
  getInvolvedPersons() {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          'where': {'intakeserviceid': this.caseId}
        }),
        'People/getpersondetail?filter'
      );
  }
  ngOnInit() {
    this.loadDropDown();
    this.getIncomeSource();
    if(this.userProfile?.resources?.some(resource => resource.name === 'BEACON_DOL_ALLOW_ACCESS')){
      this.selectedmainTab=5;
      this.beaconreviewuser=true;
  }else{
    this.selectedmainTab=1;
    this.beaconreviewuser=false;
  }
  }
  private initiateFormGroup() {
    this.incomeDetailsFormGroup = this._formBuilder.group({
      datasourcetypekey: 'CJAMS',
      startdate: null,
      enddate: null,
      incomesourcetypekey: null,
      incomefrequencytypekey:  null,
      amount:  '0.00',
      verificationtypekey:  null,
      notes:  null,
      monthlyamount:  '0.00',
      incomeid: null,
      incomedisregardflag: null

    });
    this.deemedparentFormGroup = this._formBuilder.group({
      'caseid': this.caseId ,
      'assistance_unit_no': null,
      'notin_assistance_unit_no': null,
      'schedule_h_col_iii_no': null,
      'monthly_gross_earnings_no': null,
      'unearned_income_no': null,
      'court_ordered_support_no': null,
      'earning_disregard_no': null,
      'total_deemed_income_no': null,
      'verifiedparentpersonid': null,
      'deemed_income_stepparent_id': null
    });
    this.childcareexpensesFormGroup = this._formBuilder.group({
      'employmenttypecode': null,
      'amountearned': null,
      'childrenunder2': null,
      'childrenover2': null,
      'child_care_expense_id': null
    });
    this.assetFormGroup = this._formBuilder.group({
      'personassetid': null,
      'purchasedate': null,
      'disposaldate': null,
      'assettypekey': null,
      'disregardflag': null,
      'accountno': null,
      'beneficiaryname': null,
      'verificationtypekey': null,
      'notes': null,
      'marketvaluetypekey': '0.00',
      'facevalue': '0.00',
      'amountowed': '0.00',
      'locationname': null,
      'cityname': null,
      'statetypekey': null,
      'zip5no': null,
      'countytypekey': null,
      'addressline1': null,
      'addressline2': null
    });
    this.supportorderFormGroup = this._formBuilder.group({
      'csesclientsupportorderid': null,
      'socounty': null,
      'socityname': null,
      'sostate': null,
      'sonumber': null,
      'sodate': null,
      'sostatusdate': null,
      'sostatustypekey': null,
      'sopaymentamount': null,
      'sopaymentfreqtypekey': null,
      'sodatasource': 'CJAMS'
    });
    if (this._personInfoService.getClosed()) {
      this.incomeDetailsFormGroup.disable();
      this.deemedparentFormGroup.disable();
      this.childcareexpensesFormGroup.disable();
      this.assetFormGroup.disable();
      this.supportorderFormGroup.disable();
    }
    this.incomeDetailsFormGroup.controls['incomefrequencytypekey'].valueChanges.subscribe(value => {
      this.prefillIncome(parseFloat(this.incomeDetailsFormGroup.value.amount), value);
    });
    this.incomeDetailsFormGroup.controls['amount'].valueChanges.subscribe(value => {
      this.prefillIncome(parseFloat(value), this.incomeDetailsFormGroup.value.incomefrequencytypekey);
    });
  }
  roundToTwo(num: number) {
    return Math.round(num * 100) / 100;
  }
  prefillIncome(amount: number, incometype: string) {
    const calculationArray :any= {
      'ANN': function(a: number) {return a / 12; },
      'DAI': function(a: number) {return a * 30.5; },
      'ETW': function(a: number) {return a * 2.167; },
      'MON': function(a: number) {return a * 1; },
      'QRTY': function(a: number) {return a / 4; },
      'TM': function(a: number) {return a * 2; },
      'TY': function(a: number) {return a / 6; },
      'WKLY': function(a: number) {return a * 4.33; }
    };


      if (incometype && incometype !== 'OT' && amount &&  amount > 0) {
          const value = calculationArray[incometype](amount);
          this.incomeDetailsFormGroup.patchValue({
            monthlyamount: this.roundToTwo(value)
        });
      }
      else {
        this.incomeDetailsFormGroup.patchValue({
            monthlyamount: 0
        });
       }
  }


  private loadDropDown() {
    this.stateDropdownItems$ = this._commonDropdownService.getPickListByName('state');
    this.countyDropDownItems$ = this._commonDropdownService.getPickListByName('county');
    this.typeofAssetDropDownItem$ = this._commonDropdownService.getPickListByName('assettype');
    this.AssetVerificationDropDownItem$ = this._commonDropdownService.getPickListByName('assetverification');
    this.AssestDisregardDropDownItem$ = this._commonDropdownService.getPickListByName('yesno');
    this.IncomeDisregardDropDownItem$ = this._commonDropdownService.getPickListByName('yesno');
    this. IncomeVerificationDropDownItem$ = this._commonDropdownService.getPickListByName('earnedincomeverification');
    this. IncomeFrequencyDropDownItem$ = this._commonDropdownService.getPickListByName('frequencyofincomereceipt');
    this. SupportOrderStatusDownItem$ = this._commonDropdownService.getPickListByName('statuscodes');
    this. SupportPaymentFrequencyDropDownItem$ = this._commonDropdownService.getPickListByName('wagefrequency');
    this. SupportOrderStateDropDownItem$ = this._commonDropdownService.getPickListByName('state');
  }

  loadCounty(state: any) {
    const stateValue = state ? state : null; 
    const mdmcode = (state && state.ref_key) ? state.ref_key : stateValue;
    if (mdmcode) {
      this._commonDropdownService.getPickListByMdmcode(mdmcode).subscribe(countyList => {
        this.countyDropDownItems$ = observableOf(countyList);
      });
    } else {
      this.countyDropDownItems$ = observableOf([]);
    }
  }
  submitIncome() {
    if (this.incomeDetailsFormGroup.invalid) {
      this.incomeDetailsFormGroup.markAllAsTouched();
      return;
    }
    const incomeDetails = this.incomeDetailsFormGroup.getRawValue();
    const deemedparent = this.deemedparentFormGroup.getRawValue();
    const childcareexpenses = this.childcareexpensesFormGroup.getRawValue();
    deemedparent.caseid = this._personInfoService.getCaseId();
    incomeDetails.deemedparent = deemedparent;
    incomeDetails.childcareexpenses = childcareexpenses;
    const details = {'addupdatefinanceincome': incomeDetails};
    this._personInfoService.savePersonIncomeDetails(details).subscribe(response => {
      this._alertSevice.success('Income details added successfully!');
      this.loadIncomeDetails(this.personid);
      this.resetForm();
    },
      error => {
        // No data or function to call
      }
    );
  }
  submitAsset() {
    if (this.assetFormGroup.invalid) {
      this.assetFormGroup.markAllAsTouched();
      return;
    }
    const asset = this.assetFormGroup.getRawValue();
    const details = {'where': asset};
    this._personInfoService.saveAssetDetails(details).subscribe(response => {
      this._alertSevice.success('Asset details added successfully!');
      this.loadAssetDetails(this.personid);
    },
      error => {
        // No data or function to call
      }
    );
  }
  submitSupportOrder() {
    if (this.supportorderFormGroup.invalid) {
      this.supportorderFormGroup.markAllAsTouched();
      return;
    }
    const supportorder = this.supportorderFormGroup.getRawValue();
    const details = {'addupdatefinancesupportorder': supportorder};
    this._personInfoService.saveSupportOrderDetails(details).subscribe(response => {
      this._alertSevice.success('Supprt Order details added successfully!');
      this.resetSupportOrder();
      this.loadSupportOrderDetails(this.personid);
    },
      error => {
        // No data or function to call
      }
    );
  }
  getSuggestedAddress() {
    if (this.assetFormGroup.value.addressline1 &&
        this.assetFormGroup.value.addressline1.length >= 3 ) {
         this.suggestAddress();
     }
 }
 suggestAddress() {
  this._commonHttpService
      .getArrayListWithNullCheck(
          {
              method: 'post',
              where: {
                  prefix: this.assetFormGroup.value.addressline1,
                  cityFilter: '',
                  stateFilter: '',
                  geolocate: '',
                  geolocate_precision: '',
                  prefer_ratio: 0.66,
                  suggestions: 25,
                  prefer: 'MD'
              }
          },
          NewUrlConfig.EndPoint.Intake.SuggestAddressUrl
      ).subscribe(
       (result: any) => {
         if (result.length > 0) {
          this.suggestedAddress$ = observableOf(result);
        } else {
          this.suggestedAddress$ = observableOf([]);
        }
       }
     );
  }
  selectedAddress(model: { streetLine: any; city: any; state: any; }) {
    this.assetFormGroup.patchValue({
      addressline1: model.streetLine ? model.streetLine : '',
      cityname: model.city ? model.city : '',
      statetypekey: model.state ? model.state : ''
   });
    const addressInput = {
      street: model.streetLine ? model.streetLine : '',
      street2: '',
      city: model.city ? model.city : '',
      state: model.state ? model.state : '',
      zipcode: '',
      match: 'invalid'
    };
    this._commonHttpService
      .getSingle(
          {
              method: 'post',
              where: addressInput
          },
          NewUrlConfig.EndPoint.Intake.ValidateAddressUrl
      )
      .subscribe(
          (result) => {
              if (result[0].analysis) {
                  this.assetFormGroup.patchValue({
                      zip5no: result[0].components.zipcode ? result[0].components.zipcode : ''
                  });
                  if (result[0].metadata.countyName) {
                    this._commonHttpService.getArrayList(
                      {
                        nolimit: true,
                        where: { referencetypeid: 306,  mdmcode:{"like":  this.assetFormGroup.value.statetypekey + "~%25","options":"i" }, description: result[0].metadata.countyName}, method: 'get'
                      },
                      'referencevalues?filter'
                  ) .subscribe(
                    (resultresp) => {
                      this.assetFormGroup.patchValue({
                        countytypekey: resultresp[0].ref_key
                    });

                    }
                  );
                }
               }
              } ,
              (error) => {
                  // No data or function to call
              }
      );
   }
  resetForm() {
    this.addIncomeDetails = false;
    this.initiateFormGroup();
  }
  resetAsset() {
    this.addAssetDetails = false;
    this.assetFormGroup.reset();
  }
  resetSupportOrder() {
    this.addSupportDetails = false;
    this.supportorderFormGroup.reset();
  }
  activatemainTab(type: number) {
    this.selectedmainTab = type;
    this.resetAsset();
    this.resetSupportOrder();
  }
  activateTab(type: any) {
    if (this.selectedTab === type) {
      this.selectedTab = '';
    } else {
      this.selectedTab = type;
    }
  }
  loadAssetDetails(personid: string) {
    this.getAssetDetails(personid).subscribe(assetdetails => {
      this.asset_result = assetdetails;
      if (this.asset_result && this.asset_result[0] && this.asset_result[0].getfinanceassets) {
        this.assetInfo = this.asset_result[0].getfinanceassets;
        this.showpersonassestsvalue = true;
      } else {
        this.showpersonassestsvalue = false;
      }
    });
  }
  loadSupportOrderDetails(personid: string) {
    this.getSupportOrder(personid).subscribe(supportorderdetails  => {
      this.support_order_result = supportorderdetails;
      if (this.support_order_result  && this.support_order_result.getfinancesupportorder) {
        this.supportInfo = this.support_order_result.getfinancesupportorder;
      } else {
        this.supportInfo = [];
      }
    });
  }
  loadCsesDetails(personid: string) {
    this.showcsesDetails = false;
    this.getCsesDetails(personid).subscribe(supportorderdetails  => {
      this.showcsesDetails = true;
      this.cses_result = supportorderdetails;
      if (this.cses_result  && this.cses_result.getfinancecses) {
        this.csesInfo = this.cses_result.getfinancecses;
        if (!this.csesInfo['supportorder']) {
          this.csesInfo['supportorder'] = {};
        }
      }
    });
  }
  getCsesDetails(personid: string) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          where: { personid: personid }
        }),
        'People/financecseslist?filter'
      );
  }
  getSupportOrder(personid: string) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          where: { personid: personid }
        }),
        'People/financesupportorderlist?filter'
      );
  }
   loadIncomeDetails(personid: string) {
    this.getIncomeDetails(personid).subscribe(incomedetails => {
      this.income_result = incomedetails;
      if (this.income_result && this.income_result.getfinanceincome) {
        this.incomeInfo = this.income_result.getfinanceincome;
          this.personincomehasvalue = true;
      } else {
          this.personincomehasvalue = false;
      }
    });
  }
  confirmIncomeDelete(persondetails: any) {
    this.deleteIncomedetails(persondetails).subscribe(incomedetails => {
      this.loadIncomeDetails(persondetails.personid);
    });
  }
  deleteIncomedetails(persondetails: { personid: any; incomeid: any; }) {
    return this._commonHttpService
      .getPagedArrayList(
        {
          method: 'post',
          financeincomedelete: {
            personid: persondetails.personid,
            incomeid: persondetails.incomeid
          }
        },
        'People/financeincomedelete?filter'
      );
  }
  confirmAssetDelete(assetdetails: any) {
    this.deleteAssetdetails(assetdetails).subscribe(incomedetails => {
      this.loadAssetDetails(this.personid);
    });
  }
  deleteAssetdetails(assetdetails: { personassetid: any; }) {
    return this._commonHttpService
      .getPagedArrayList(
        {
          method: 'post',
          where: {
            personassetid: assetdetails.personassetid,
          }
        },
        'People/deletefinanceasset?filter'
      );
  }
  confirmSupportDelete(assetdetails: any) {
    this.deleteSupportdetails(assetdetails).subscribe(incomedetails => {
      this.loadSupportOrderDetails(this.personid);
    });
  }
  deleteSupportdetails(assetdetails: { personid: any; csesclientsupportorderid: any; }) {
    return this._commonHttpService
      .getPagedArrayList(
        {
          method: 'post',
          financeincomedelete: {
            personid: assetdetails.personid,
            csesclientsupportorderid: assetdetails.csesclientsupportorderid
          }
        },
        'People/financesupportorderdelete?filter'
      );
  }
  getIncomeDetails(personid: any) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          where: { personid: personid }
        }),
        'People/financeincomelist?filter'
      );
  }
  getAssetDetails(personid: string) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'post',
          where: { personid: personid }
        }),
        'People/getfinanceasset?filter'
      );
  }
  enableIncomeForm() {
    this.addIncomeDetails = true;

  }
  enableAssetForm() {
    this.addAssetDetails = true;
  }
  enableSupportForm() {
    this.addSupportDetails = true;
  }
  editIncomeDetails(incomeInfo: { [x: string]: any; personid?: any; enteredby?: any; deemedparent?: any; childcareexpenses?: any; incomesourcetypekey?: any; incomedisregardflag?: any; }) {
    if (incomeInfo && incomeInfo.personid) {
        this.addIncomeDetails = true;
        this.incomeenteredby = incomeInfo.enteredby;
        this.incomeDetailsFormGroup.patchValue(incomeInfo);
        this.deemedparentFormGroup.patchValue(incomeInfo.deemedparent);
        this.childcareexpensesFormGroup.patchValue(incomeInfo.childcareexpenses);
        this.incomesourcedefault(incomeInfo.incomesourcetypekey);
        if (incomeInfo.incomedisregardflag === 1) {
            this.incomeDetailsFormGroup.patchValue({incomedisregardflag:  'Y' });
        } else if (incomeInfo.incomedisregardflag === 0) {
            this.incomeDetailsFormGroup.patchValue({incomedisregardflag:  'N' });
        }
    }
  }
  editAssetDetails(assetdetails: { [x: string]: any; personassetid?: any; insertedby?: any; disregardflag?: any; }) {
    if (assetdetails && assetdetails.personassetid) {
      this.assetenteredby = assetdetails.insertedby;
      this.addAssetDetails = true;
      assetdetails.disregardflag = this.returnFlagValueFn(assetdetails);
      this.assetFormGroup.patchValue(assetdetails);
    }
  }
  // Assosiated with editAssetDetails method
  private returnFlagValueFn(assetdetails: any) {
    return assetdetails.disregardflag === 1 ? 'Y' : this.returnFlagValueIfNoFn(assetdetails);
  }
  // Assosiated with editAssetDetails method
  private returnFlagValueIfNoFn(assetdetails: any) {
    return assetdetails.disregardflag === 0 ? 'N' : '';
  }

  editSupportOrderDetails(supportdetails: { [x: string]: any; csesclientsupportorderid?: any; }) {
    if (supportdetails && supportdetails.csesclientsupportorderid) {
      this.addSupportDetails = true;
      this.supportorderFormGroup.patchValue(supportdetails);
    }
  }

  getIncomeSource() {
    this.IncomeSourceDropDownItem$ = this._commonHttpService.getArrayList({
    }, 'Picklistvalues/incomepicklistvalues').pipe(map((result:any) => {
      if (result && result['UserToken'].length > 0) {
        const incomeSource = result['UserToken'];
        return incomeSource.map(
          (res: { value_tx: any; picklist_value_cd: any; }) =>
              new DropdownModel({
                  text: res.value_tx,
                  value: res.picklist_value_cd
              })
      );
      }
  }));
}

    incomesourcedefault(event: string) {
        if (event === '18' || event === '19' || event === '20' || event === '21' || event === '24' || event === '25') {
            this.incomeDetailsFormGroup.controls['incomedisregardflag'].setValue('Y');
            this.incomeDetailsFormGroup.controls['incomedisregardflag'].disable();
        } else {
            this.incomeDetailsFormGroup.controls['incomedisregardflag'].setValue('N');
            this.incomeDetailsFormGroup.controls['incomedisregardflag'].enable();
        }
    }

    declineDelete() {
      this.deleteScreen = null;
      this.deleteItem = null;
     (<any>$(this. deletepopupid)).modal('hide');
   }
   
   confirmDeletePopup(persondetails: any, type: any) {
     this.deleteItem = persondetails;
     this.deleteScreen = type;
     (<any>$(this. deletepopupid)).modal('show');
   }
   confirmDelete() {
     if(this.deleteScreen === 'INCOME') {
       this.confirmIncomeDelete(this.deleteItem);
       this.deleteItem = null;
     } else if(this.deleteScreen === 'ASSET') {
       this.confirmAssetDelete(this.deleteItem);
       this.deleteItem = null;
     } else if(this.deleteScreen === 'CS') {
       this.confirmSupportDelete(this.deleteItem);
       this.deleteItem = null;
     }
     this._alertSevice.success('Deleted successfully');
     (<any>$(this. deletepopupid)).modal('hide');
   }
}





