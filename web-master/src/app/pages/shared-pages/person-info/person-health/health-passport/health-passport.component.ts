import { Component, OnInit, Injector } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AlertService, DataStoreService, CommonHttpService, AuthService, GenericService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { PersonInfoService } from '../../person-info.service';
import { CASE_STORE_CONSTANTS } from '../../../../case-worker/_entities/caseworker.data.constants';
import moment from 'moment';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { ActivatedRoute } from '@angular/router';

@Component({
    selector: 'health-passport',
    templateUrl: './health-passport.component.html',
    styleUrls: ['./health-passport.component.scss'],
    standalone: false
})

export class HealthPassportComponent implements OnInit {
  HealthPassportInfoForm!: FormGroup;
  placementList: any[] = [];
  personPlacement: any[] = [];
  healthPassport: any;
  reportMode!: string;
  editMode!: boolean;
  isAddEdit = false;
  personId!: string;
  selected: any[] = [];
  isClosed = false;
  placementDetails: any;
  healthPassportId: any;
  maxDate: any;
  childList: any[] = []
  removaldate: any;
  deletepopupid = '#delete-popup';
  providerplacement = 'Provider Placement';
  livingarrangement = 'Living Arrangement';

  private formbuilder: FormBuilder;
  private _alertService: AlertService;
  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  private _authService: AuthService;
  private _service: GenericService<any>;
  private _personInfoService: PersonInfoService;
  private route: ActivatedRoute;

  constructor(private injector:Injector){
    this.formbuilder =this.injector.get<FormBuilder>(FormBuilder);
    this._alertService =this.injector.get<AlertService>(AlertService);
    this._dataStoreService =this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService =this.injector.get<CommonHttpService>(CommonHttpService);
    this._authService =this.injector.get<AuthService>(AuthService);
    this._service =this.injector.get<GenericService<any>>(GenericService);
    this._personInfoService =this.injector.get<PersonInfoService>(PersonInfoService);
    this.route =this.injector.get<ActivatedRoute>(ActivatedRoute);
}

  ngOnInit() {
    this.personId =  this._personInfoService.getPersonId();
    this.getChildRemoval();
    this.maxDate = new Date();
    this.reportMode = 'add';
     this.HealthPassportInfoForm = this.formbuilder.group({
      personhealthpassportid: null,
      personid: this.personId,
      placementid: ['', Validators.required],
      effectivedate: null,
      haspassportprovidedtocaregiver: null
    });

    this.isClosed = this._authService.iscaseclosed('personhealth') || !this._authService.isPersonSubTabViewable('person','person.Health.healthpassportadd');
    this.route.queryParams.subscribe(params => {
      const status = params['healthPassport'];
      if (status) {
        const healthPassport = JSON.parse(this._dataStoreService.getData('healthPassport-health-summary'));
        healthPassport.haspassportprovidedtocaregiver = healthPassport.haspassportprovidedtocaregiver.toLowerCase();
        this.placementList = this._dataStoreService.getData('healthpassport-placementList');
        this.view(healthPassport);
      }
    });
  }


getChildRemoval() {
   this._commonHttpService
    .getSingle(
      {
        where: { objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID), 'objecttypekey': 'servicecase' },
        method: 'get'
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
        .GetChildRemovalList + '?filter'
    ).subscribe((result: any) => {
                  if (result && result.length) {
                      this.childList =result;
                      const activeremoval = this.childList .filter(item=>item.exitdate === null);
                      if (activeremoval.length > 0) {
                        this.removaldate = activeremoval.reduce((latest, item) => {
                            return item.removaldate < latest ? item.removaldate : latest;
                        }, activeremoval[0].removaldate);
                    }
                  } 
                  this.getPlacementRecordList();
              });
            }


  getPlacementRecordList(){
    this._commonHttpService
    .getPagedArrayList(
      new PaginationRequest({
        page: 1,
        limit: 10,
        method: 'get',
        where: { servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID)},
      }),
      'placement/getplacementbyservicecase?filter'
    ).subscribe(result => {
        const personPlacement = result.data.filter(item => item.personid === this.personId);
      this.personPlacement = personPlacement[0]?.placements || [];
      if (this.personPlacement.length > 0) {
        const validPlacementList: any[] = [];
        this.personPlacementResultFn(personPlacement, validPlacementList);
      } else {
          this.placementList = [];
          this.listHealthPassport();
        }
    });
  }

  private personPlacementResultFn(personPlacement: any[], validPlacementList: any[]) {
    this.placementsMapFn(personPlacement, validPlacementList);

    // Living Arrangement
    this.LAPlacementListFn(validPlacementList);

    //Provide Placement 
    this.providerPlacementListFn(validPlacementList);

    this.listHealthPassport();
  }

  private LAPlacementListFn(validPlacementList: any[]) {
    const LAPlacementListWithoutEndDate = validPlacementList.filter(item => item.enddate === null && item.placementtype === this.livingarrangement).sort(item => item.enddate);
    if (LAPlacementListWithoutEndDate.length > 0) {
      LAPlacementListWithoutEndDate.forEach((element) => {
        if (element.startdate >= this.removaldate) {
          this.placementList.push(element);
        }
      });
    }

    const LAPlacementListWithEndDate = validPlacementList.filter(item => item.enddate !== null && item.placementtype === this.livingarrangement);
    LAPlacementListWithEndDate.sort((a, b) => {
      const c = new Date(a.enddate);
      const d = new Date(b.enddate);
      return c <= d ? 1 : -1;
    });

    if (LAPlacementListWithEndDate.length > 0) {
      if (LAPlacementListWithEndDate[0].startdate >= this.removaldate) {
        this.placementList.push(LAPlacementListWithEndDate[0]);
      }
    }
  }

  private providerPlacementListFn(validPlacementList: any[]) {
    const providerPlacementListWithOutEndDate = validPlacementList.filter(item => item.enddate === null && item.placementtype === this.providerplacement).sort(item => item.enddate);
    if (providerPlacementListWithOutEndDate.length > 0) {
      providerPlacementListWithOutEndDate.forEach((item) => {
        if (item.startdate >= this.removaldate) {
          this.placementList.push(item);
        }
      });
    }

    const providerPlacementListWithEndDate = validPlacementList.filter(item => item.enddate !== null && item.placementtype === this.providerplacement).sort(item => item.enddate);
    providerPlacementListWithEndDate.sort((e, f) => {
      const a = new Date(e.enddate);
      const b = new Date(f.enddate);
      return a <= b ? 1 : -1;
    });

    if (providerPlacementListWithEndDate.length > 0) {
      if (providerPlacementListWithEndDate[0].startdate >= this.removaldate) {
        this.placementList.push(providerPlacementListWithEndDate[0]);
      }
    }
  }

  private placementsMapFn(personPlacement: any[], validPlacementList: any[]) {
    personPlacement[0].placements.map((element: any) => {
      if (element.placementtypekey === 'PRPL') {
        this.ifPRPLFn(element);
      } else {
        element.placementtype = this.livingarrangement;
        element.placementname = element.primarycaregiver ? element.primarycaregiver : element.livingarrangementtype;
      }
      if (element.placementname !== null && (element.isvoided === 0 || element.isvoided == null) && (element.routingstatus === 'Approved' || (element.routingstatus === 'Review' && element.revisionupdate && element.revisionupdate.enddate))) {
        validPlacementList.push(element);
      }
    });
  }

  private ifPRPLFn(element: any) {
    element.placementtype = this.providerplacement;
    if (element.cpahomerevision.length > 0) {
      element.placementname = element.cpahomerevision[0].providername;
    } else {
      element.placementname = (element.providerdetails) ? element.providerdetails.providername : null;
    }
  }

  resetForm() {
    this.HealthPassportInfoForm.reset();
    this.editMode = false;
    this.reportMode = 'add';
    this.HealthPassportInfoForm.enable();
    this.selected =  [];
  }

  view(modal: any) {
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.editMode = false;    
    this.HealthPassportInfoForm.patchValue(modal);
    this.fillPlacementInfo(modal.placementid);
    this.HealthPassportInfoForm.disable();
  }

  edit(modal: any) {
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.editMode = true;
    this.HealthPassportInfoForm.patchValue(modal);
    this.fillPlacementInfo(modal.placementid);
    this.HealthPassportInfoForm.enable();
  }

  confirmDelete(modal: any) {
    this.healthPassportId = modal.personhealthpassportid;
    (<any>$(this.deletepopupid)).modal('show');
  }

  delete() {
    this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.HealthPassportDelete;
    this._service.remove(this.healthPassportId).subscribe(
        (response) => {
            if (response) {
                this._alertService.success('Health Passport Deleted Successfully');
                this.listHealthPassport();
                (<any>$(this.deletepopupid)).modal('hide');
            }
        },
        (error) => {
            (<any>$(this.deletepopupid)).modal('hide');
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
    );
  }

  cancel() {
    this.resetForm();
    if(this.isClosed) {
      window.scrollTo(0,0);
      this.isAddEdit = false;
    }
  }

  addUpdate() {
    if (this.HealthPassportInfoForm.invalid) {
      this.HealthPassportInfoForm.markAllAsTouched();
      return;
    }
    const formData = this.HealthPassportInfoForm.getRawValue();
    formData.personid = this.personId
    if(formData.haspassportprovidedtocaregiver === 'yes' && formData.effectivedate === null) {
        this._alertService.warn('Please enter atleast one child information');
        return false;
    }

    formData.haspassportprovidedtocaregiver = (formData.haspassportprovidedtocaregiver === 'yes') ? true : false; 
    
    this._service.create(formData, CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.HealthPassportAddUpdate).subscribe(
        (response: any) => {
            if (response) {
              const msg = (formData.personhealthpassportid) ? 'Updated' : 'Added' 
              this._alertService.success(`Health Passport ${msg} Successfully`);
              this.isAddEdit = false;  
              this.resetForm();
              this.listHealthPassport();
            } else {
              this._alertService.warn('Please try again later');
            }
        },
        (error: any) => {
            this._alertService.warn('Please try again later');
        }
    );
  }

  private listHealthPassport() {

    this._commonHttpService
        .getPagedArrayList(
            new PaginationRequest({
                page: 1,
                limit: 100,
                where: { personid: this.personId },
                method: 'post'
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.HealthPassportList
        )
        .subscribe((result) => {
            this.healthPassport = result.data;
            this.healthPassport.map((element: { placementid: any; healthpassportname: any; haspassportprovidedtocaregiver: string; }) => {
                const placementInfo = this.placementList.find(item => item.placementid === element.placementid);
                element.healthpassportname = (placementInfo) ? placementInfo.placementname : null;
                element.haspassportprovidedtocaregiver = (element.haspassportprovidedtocaregiver) ? 'yes' : 'no'; 
            })
        });

  }

  enableHealthPassport() {
    if(this.placementList.length > 0 || this.childList.filter(x=> x.approvalstatus === 'Approved' && x.exitdate !== null).length) {
      this.isAddEdit = true;
    } else {
      this._alertService.warn('Unable to add Health Passport as there is no placement for the Client');
    }
  }

  fillPlacementInfo(value: any) {
      const placementInfo = this.placementList.find(item => item.placementid === value) ? this.placementList.find(item => item.placementid === value) : this.personPlacement.find(item => item.placementid === value); //CIDM-9934
      if(placementInfo){
        const placementInfoValue = placementInfo.livingarrangementtype ? placementInfo.livingarrangementtype : placementInfo.placementtype;
        const type = (placementInfo.placementstructuredesc) ? placementInfo.placementstructuredesc : placementInfoValue; 
        this.placementDetails = {
           placementtypename : type,
           placementname: placementInfo.placementname,
           startdate: placementInfo.starttime, //CIDM-10275 - health passport not displaying correct time
           enddate: placementInfo.endtime, //CIDM-10275
           startdatetomidnight : placementInfo.startdate,
           enddatetomidnight: placementInfo.enddate
        }
      }
  }

  getFormattedStartDate(item: any) {
    const d = new Date(item.starttime);
    const startdatespilt = moment(item.startdate).format("YYYY-MM-DD");
    const stDate = moment(startdatespilt).add(d.getHours()?d.getHours():0,'h').add(d.getMinutes()?d.getMinutes():0,'m').toDate();
    return this.settimein12hr(stDate);
  }

  getFormattedExitDate(item: any) {
    const d = new Date(item.exittime);
    const exitdatespilt = moment(item.exitdate).format("YYYY-MM-DD");
    const stDate = moment(exitdatespilt).add(d.getHours()?d.getHours():0,'h').add(d.getMinutes()?d.getMinutes():0,'m').toDate();
    return this.settimein12hr(stDate);
    
  }

  settimein12hr(strtime: any) {
    if (strtime && moment(new Date(strtime), 'HH:mm', true).isValid()) {
      return moment(new Date(strtime), 'HH:mm', true).toDate();
    }
    else if (strtime && moment(strtime, 'HH:mm', true).isValid()) {
      return moment(strtime, 'HH:mm', true).toDate();
    }
    else if (strtime && moment(strtime, 'HH:mm:ss', true).isValid()) {
      return moment(strtime, 'HH:mm:ss', true).toDate();
    }
  }

  declineDelete() {
    (<any>$(this.deletepopupid)).modal('hide');
  }

}