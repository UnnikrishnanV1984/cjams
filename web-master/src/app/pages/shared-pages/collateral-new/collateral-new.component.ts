import { Component, OnInit, Injector } from '@angular/core';
import { Observable } from 'rxjs';
import { CommonHttpService, DataStoreService, AuthService, SessionStorageService, CommonDropdownsService, AlertService, ValidationService } from '../../../@core/services';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CASE_STORE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { IntakeStoreConstants } from '../../newintake/my-newintake/my-newintake.constants';
import { IntakeConfigService } from '../../newintake/my-newintake/intake-config.service';
import { TransferHistoryApprovedService } from '../../../shared/services/transfer-history-approved.service';

@Component({
    selector: 'collateral-new',
    templateUrl: './collateral-new.component.html',
    styleUrls: ['./collateral-new.component.scss'],
    standalone: false
})
export class CollateralNewComponent implements OnInit {
  listCollateral: any;
  actionMode!: string;
  collateralForm!: FormGroup;
  prefixDropdownItems$!: Observable<any[]>;
  suffixDropdownItems$!: Observable<any[]>;
  racetypeDropdownItems$!: Observable<any[]>;
  collateralroleDropdownItems$!:  Observable<any[]>;
  address = { disable: false, address1: null, address2: null, city: null, state: null, zipcode: null, county: null };
  isClosed = false;
  isSsnHidden = true;
  ssnEye = 'fa-eye';
  showSsnMask = true;
  selectedPerson: any;
  maxDate = new Date();
  isReadonly = true;

  private _commonHttpService: CommonHttpService;
  private _dataStoreService: DataStoreService;
  private formBuilder: FormBuilder;
  private _authService: AuthService;
  private _sessionStorage: SessionStorageService;
  private _commonDropdownService: CommonDropdownsService;
  private _alertService: AlertService;
  private readonly _transferHistoryApprovedService: TransferHistoryApprovedService;
  private _configService: IntakeConfigService;


  constructor(private injector: Injector){
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
    this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._transferHistoryApprovedService = this.injector.get<TransferHistoryApprovedService>(TransferHistoryApprovedService);
    this._configService = this.injector.get<IntakeConfigService>(IntakeConfigService);
     }


  ngOnInit() {
    this.initAll();
    this.initForm();
    const activeModuleRole = this._sessionStorage.getItem('activeModuleRole');
    if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
    this.isReadonly =  this._authService.readonlyButton('read_only_access','add-edit-collateral');}
    this.prefixDropdownItems$ = this._commonDropdownService.getPickListByName('prefix');
    this.suffixDropdownItems$ = this._commonDropdownService.getPickListByName('suffix');
    this.racetypeDropdownItems$ = this._commonDropdownService.getPickListByName('race');
    this.collateralroleDropdownItems$ = this._commonDropdownService.getPickListByName('collateralroles');
    const dsdsobject = this._sessionStorage.getItem('da_status');
    const currentStatus = this._dataStoreService.getData(IntakeStoreConstants.INTAKE_STATUS);
    if (dsdsobject || currentStatus) {
      if (dsdsobject === 'Closed' || dsdsobject === 'Completed' || currentStatus === 'Closed' || currentStatus === 'Completed') {
        this.isClosed = true;
      } else {
        this.isClosed = false;
      }
    }
    
    if(this.isIntakeMode() && this._transferHistoryApprovedService.getTrasferHistory()) {
      this.isClosed = true;
    }
  }
  initAll() {
    this.getcollateral();
  }
  getcollateral() {
    const data = this.getRequestParam();
    const request = {
      objectid: data.caseid ? data.caseid : data.intakenumber,
      objecttype: data.caseid ? 'case' : 'intake'
    };
    this._commonHttpService.getArrayList(
      {
        where: request,
        method: 'get',
        nolimit: true
      },
      'collateral/list?filter'
    ).subscribe(collateralData => {
      if (collateralData && collateralData.length && collateralData[0].getcollateraldetails && collateralData[0].getcollateraldetails.length) {
        this.listCollateral = collateralData[0].getcollateraldetails;        
      } else {
        this.listCollateral = [];
      }
      this._configService.colletarlCount$.next(this.listCollateral.length);
    });
  }

  getCaseUuid() {
    const caseID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    if (caseID) {
      return caseID;
    }
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    let caseUUID = null;
    if (caseInfo) {
      caseUUID = caseInfo.intakeserviceid;
    }
    return caseUUID;
  }

  isServiceCaseData() {
    return this._sessionStorage.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
}

isIntakeMode() {
    return this.getIntakeNumber() ? true : false;
}

getIntakeNumber() {
    const intakeStore = this._dataStoreService.getObj('intake');
    if (intakeStore && intakeStore.number) {
        return intakeStore.number;
    } else {
        return null;
    }
}

toggleSsn = () => {
  this.isSsnHidden = !this.isSsnHidden;
  if (this.isSsnHidden) {
    this.ssnEye = 'fa-eye';
    this.showSsnMask = true;
  } else {
    this.ssnEye = 'fa-eye-slash';
    this.showSsnMask = false;
  }
}

get getCollateralForm(){
  return this.collateralForm.controls;
}
getRequestParam() {
  let inputRequest;
  const caseID = this.getCaseUuid();
  if (this.isServiceCaseData()) {
      inputRequest = {
          caseid: caseID,
          objecttype: 'servicecase',
          intakenumber: null,
      };
  } else if (this.isIntakeMode()) {
      inputRequest = {
          intakenumber: this.getIntakeNumber(),
          objecttype: 'intake',
          caseid: null
      };

  } else {
      inputRequest = {
        caseid: caseID,
        objecttype: 'case',
        intakenumber: null,
      };
  }

  return inputRequest;
}

  initForm() {
    this.collateralForm = this.formBuilder.group({
      collateralid: [null],
      comments: [null],
      caseid: [null],
      intakenumber: [null],
      referralid: [null],
      clientmergeid: [null],
      agencyname: [null],
      title: [null],
      legalclientid: [1], // hardocoded for now
      clientnotes: [null],
      dob: [null],
      email: [null,[ValidationService.mailFormat]],
      familyknowledge: [null],
      fax: [null],
      firstname: [null],
      lastname: [null],
      middlename: [null],
      mobile: [null],
      prefixtypekey: [null],
      primaryracetypekey: [null],
      ssn: [null],
      suffixtypekey: [null],
      workextn: [null],
      workphone: [null],
      homephone: [null],
      collateralroles: [null, [Validators.required]]

    });
  }

  openCollateral(mode: string) {
    this.actionMode = mode;
    (<any>$('#add-edit-collateral')).modal('show');

  }

  cancel() {
    this.collateralForm.reset();
    this.resetAddress();
  }

  saveCollateral() {
    if (this.collateralForm.valid) {

      const colleteralFormData = this.collateralForm.getRawValue();
      if (!colleteralFormData.agencyname && (!colleteralFormData.firstname || !colleteralFormData.lastname)) {
        this._alertService.error('Please fill First Name and Last Name or Organization');
        return false;
      }

      const addressData = {
        address1: this.address.address1,
        address2: this.address.address2,
        cityname: this.address.city,
        countytypekey: this.address.county,
        statetypekey: this.address.state,
        zip5no: this.address.zipcode ? this.address.zipcode : null
      };
      colleteralFormData.collateraladdress = [addressData];
      const source = this.getRequestParam();
      colleteralFormData.caseid = source.caseid;
      colleteralFormData.intakenumber = source.intakenumber;
      colleteralFormData.objecttype = source.objecttype;
      colleteralFormData.collateralroleconfig = colleteralFormData.collateralroles.map((item: any) =>  { return {'actortypekey' : item }  });
      this._commonHttpService.create(colleteralFormData, 'collateral/addupdate').subscribe(response => {
        this._alertService.success('Collateral saved successfully');
        (<any>$('#add-edit-collateral')).modal('hide');
        this.getcollateral();
        this.collateralForm.reset();
        this.resetAddress();
      });
    } else {
      this._alertService.error('Please fill required feilds');
    }
  }

  maskSSN(value: any): string {
		if (value != null || value === '') {
			value = String(value).replace(/-/g, '');
		}
		if (this.showSsnMask === true) {
			if (String(value).startsWith('*') && String(value).length < 9) {
				return '';
			}
			if (String(value).match('^[0-9]{9}$')) {
				return '***-**-' + String(value).substr(String(value).length - 4);
			}
		} else {
			if (String(value).startsWith('*')) {
				return '';
			}
			if (String(value).match('^[0-9]{9}$')) {
				return (String(value).substring(0, 3) + '-' + String(value).substring(3, 5) + '-' + String(value).substring(5, 9));
			} else { return ''; }
		}
		return value;
  }
  
  editCollateral(person: any) {
    if (person.collateralroleconfig) {
      person.collateralroles = person.collateralroleconfig.map((item: { actortypekey: any; }) => item.actortypekey);
    } else {
      person.collateralroles = [];
    }
    
    this.collateralForm.patchValue(person);
    if (Array.isArray(person.collateraladdress) && person.collateraladdress.length) {
      const collateralAddress = person.collateraladdress[0];
      this.address.address1 = collateralAddress.address1;
      this.address.address2 = collateralAddress.address2;
      this.address.city = collateralAddress.cityname;
      this.address.county = collateralAddress.countytypekey;
      this.address.state = collateralAddress.statetypekey;
      this.address.zipcode = collateralAddress.zip5no;
    } else {
      this.resetAddress();
    }
   
    this.openCollateral('edit');
  }

  confirmDelete(person: any) {
    (<any>$('#delete-popup')).modal('show');
    this.selectedPerson = person;
  }

  cancelDelete() {
    this.selectedPerson = null;
  }

  deletePerson() {
    this._commonHttpService.remove(this.selectedPerson.collateralid, {}, 'collateral/deletecollateral').subscribe(response => {
      this._alertService.success('Collateral deleted successfully');
      (<any>$('#delete-popup')).modal('hide');
      this.getcollateral();
      this.collateralForm.reset();
      this.resetAddress();
    });
  }

  formatPhoneNumber(number:string) {
    return this._commonDropdownService.formatPhoneNumber(number);
  }

  resetAddress() {
    this.address = { disable: false, address1: null, address2: null, city: null, state: null, zipcode: null, county: null };
  }






}

