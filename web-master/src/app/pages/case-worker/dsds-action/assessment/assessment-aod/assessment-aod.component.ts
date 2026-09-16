import { Component, Injector, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonHttpService, AlertService, DataStoreService, AuthService, CommonDropdownsService, SessionStorageService } from '../../../../../@core/services';
import { AssessmentService } from '../assessment.service';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatRadioModule } from '@angular/material/radio';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { CommonModule } from '@angular/common';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatSortModule } from '@angular/material/sort';
import { SignatureFieldModule } from '../../../../../shared/modules/common-controls/signature-field/signature-field.module';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';

@Component({
    selector: 'assessment-aod',
    templateUrl: './assessment-aod.component.html',
    styleUrls: ['./assessment-aod.component.scss'],
    imports:[MatSortModule,MatFormFieldModule,MatInputModule,MatSelectModule,MatRadioModule,ReactiveFormsModule,MatDatepickerModule,CommonModule,MatCheckboxModule,SignatureFieldModule],
    standalone: true
})
export class AssessmentAodComponent implements OnInit {

  ASSESSMENT_NAME = 'AOD Form';
  submissiondata: any;
  aodidentifyForm!: FormGroup;
  currentAssessmentId!: string;
  preliminaryForm!: FormGroup;
  authorizationForm!: FormGroup;
  preliminaryFormList: any[] = [];
  routingInfo: any;
  isServiceCase: any;
  roleId!: AppUser;
  agency!: string;
  isCW!: boolean;
  id: any;
  daNumber: any;
  isSupervisor!: boolean;
  involvedPerson: any[] = [];
  reportedChild: any[] = [];
  reportedChildOriginal: any[] = [];
  reportedChildName: any[] = [];
  viewAod = false;

  showpreliminary = false;
  preliminaryMode!: number;
  preliminaryindex!: number | undefined;
  routingSupervisors: any[] = [];
  currentSubmissionId: any;
  AodData: any;
  assessmentStatus: any;
  incompleteList: any[] = [];
  drugList: any;
  signature: any;
  iscaseexpunged: any = 0;
  private _formBuilder: FormBuilder; 
  private route: ActivatedRoute;
  private _router: Router;
  private _commonHttpService: CommonHttpService;
  private _alertService: AlertService;
  private _assessmentService: AssessmentService;
  private _dataStoreService: DataStoreService;
  private _commonDDService: CommonDropdownsService;
  private storage: SessionStorageService;
  private _authService: AuthService;

	constructor(private injector : Injector){
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
		this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
	  this._router = this.injector.get<Router>(Router);
    this._assessmentService = this.injector.get<AssessmentService>(AssessmentService);
    this._alertService = this.injector.get<AlertService>(AlertService);
	  this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);	
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonDDService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
	  this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.id = this._commonDDService.getStoredCaseUuid();
    this.daNumber = this._commonDDService.getStoredCaseNumber(); }

  ngOnInit() {
    this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    this.isServiceCase = this.storage.getItem('ISSERVICECASE');
    this.roleId = this._authService.getCurrentUser();
    this.agency = this._authService.getAgencyName();
    this.initAODForm();
    this._assessmentService.getservicecase();
    this.isSupervisor = (this.roleId.role.name === 'apcs') ? true : false;
    if (this.agency === 'CW') {
      this.isCW = true;
    } else {
      this.isCW = false;
    }
    
    
    
    this.authorizationForm.patchValue({
      supervisorname: this._dataStoreService.getData('da_assignedby')
    });
    this.authorizationForm.get('supervisorname')?.disable();
    
    this.routingSupervisors = this._dataStoreService.getData('CASEWORKER_SUPERVISORS') ? this._dataStoreService.getData('CASEWORKER_SUPERVISORS') : [];
    this.getInvolvedPerson();
    this.aodidentifyForm.patchValue({
      supervisorname: this._dataStoreService.getData('da_assignedby'),
      caseworkername: this.roleId.user.userprofile.fullname
    });
    this.aodidentifyForm.get('caseworkername')?.disable();
    this.aodidentifyForm.get('supervisorname')?.disable();
    this.AodData = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');
    this.currentAssessmentId = this.AodData.assessmentid;
    this.currentSubmissionId = this.AodData.submissionid;

    if(this.AodData.mode === 'update' || this.AodData.mode === 'submit') {
      this.getSubmisionData();
    } else {
      this.patchAodForm();
    }
  }

  initAODForm() {
    this.aodidentifyForm = this._formBuilder.group({
      caseworkername: null,
      supervisorname: null,
      caseworkerphone: [''],
      supervisorphone: [''],
    });
    this.preliminaryForm = this._formBuilder.group({
      client: [null],
      dob: [null],
      address: [null],
      contact: [null],
      isinfluencedrugs: [''],
      isphysicalsymptoms: [''],
      isdrugparaphrenalia: [''],
      isevidencealcohol: [''],
      ispositivedrugscreen: [''],
      issubstanceabuseincps: [''],
      ischildrenreportabuse: [''],
      isabusetreatment: [''],
      isuseddrugstwelvemonths: [''],
      isconsequencemisusedrugs: [''],
      istroublelawmisusedrugs: [''],
      isdruguserscontactchild: [''],
      isackcomplications: [''],
      othercomments: [''],
      isclientconsentreferral: [''],
      referralcaseworkername: [null],
      referraldate: [null],
      adoscreening: [null],
      signdha: [null],
      aodassess: [null],
      negativeaod: [null],
      positiveaod: [null],
      substanceaubuse: [null],
      treatment: [null],
      appearaod: [null],
      currentaod: [null],
      addictionname: [null],
      addictiondate: [null],
      addictionphno: [null],
      addictionemail: [null],
      addictioncomments: [null],
      isinfluencedrugscomments: null,
      isphysicalsymptomscomments: null,
      isdrugparaphrenaliacomments: null,
      isevidencealcoholcomments: null,
      ispositivedrugscreencomments: null,
      issubstanceabuseincpscomments: null,
      ischildrenreportabusecomments: null,
      ischildrenreportabusedate: null,
      isabusetreatmentcomments: null,
      isabusetreatmentdate: null,
      isuseddrugstwelvemonthsdrug: null,
      isuseddrugstwelvemonthscomments: null,
      isconsequencemisusedrugscomments: null,
      isconsequencemisusedrugsconseq: null,
      istroublelawmisusedrugscomments: null,
      istroublelawmisusedrugslaw: null,
      isdruguserscontactchildcomments: null,
      isackcomplicationscomments: null,
      signature: null,
      isclientconsentreferraldate: null,
      isclientconsentreferralcomments:null,
      treatmentdate: null,
      treatmentprovidername: null,
      appearaoddate: null,
      currentaodfacility: null,
      currentaodverified: null,
      ispositivedrugscreenchild: [''],
      ispositivedrugscreendrug: [''],
      userrole: [''],
    });

    this.authorizationForm = this._formBuilder.group({
      assessmentstatus: [null],
      routingsupervisors: [null],
      supervisorname: [null]
    });
  }

  getSubmisionData() {
    const url = `admin/assessment/getassessmentform/${this.AodData.external_templateid}/submission/${this.AodData.submissionid}`;
    this._commonHttpService.getSingle({}, url).subscribe(result => {
      this.patchAodForm();
    });
  }

  patchAodForm() {

    if (this.AodData && this.AodData.submissiondata ) {
      this.submissiondata = this.AodData.submissiondata;
    }
    this._dataStoreService.setData('PRINTDATA', this.submissiondata);
    
    if (this.AodData && (this.AodData.mode === 'update' || this.AodData.mode === 'submit')) {
      this.viewAod = false;

      if (this.submissiondata && this.submissiondata.aodidentifyForm) {
        this.aodidentifyForm.patchValue(this.submissiondata.aodidentifyForm);
      }
      if (this.submissiondata && this.submissiondata.preliminaryForm) {
        this.preliminaryFormList = this.submissiondata.preliminaryForm;
      }
      if (this.submissiondata && this.submissiondata.authorizationForm) {
        this.authorizationForm.patchValue(this.submissiondata.authorizationForm);
      }
    } else {
      this.viewAod = false;
    }
    if (this.AodData && this.AodData.mode === 'submit') {
      this.viewAod = true;
      this.aodidentifyForm.disable();
      this.preliminaryForm.disable();
      this.authorizationForm.disable();
    }
  }

  changeSupervisor(userid: any) {
    const user = this.routingSupervisors.find(item => item.userid === userid);
    if (user.username) {
      this.authorizationForm.patchValue({
        supervisorname: user.username
      });
    }
  }

  getInvolvedPerson() {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    let getpersonlistreq = {};
    getpersonlistreq = { intakeserviceid: this.id, isExpungementSuperUser: isExpungementSuperUser,iscaseexpunged: this.iscaseexpunged };        
    if (this.isCW && this.isServiceCase) {
      getpersonlistreq = { objectid: this.id, objecttypekey: 'servicecase' };
    }

    let url = '';
    
    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }
    this._commonHttpService.getPagedArrayList(
      new PaginationRequest({
        page: 1,
        limit: 20,
        method: 'get',
        where: getpersonlistreq
      }),
      url + '?filter'
    ).subscribe(response => {
      if (response && response.data && response.data.length) {
        this.involvedPerson = response.data;
        this.involvedPerson.forEach(item => {
          if (item.roles) {
            const child = item.roles.filter((_roleid: any) => true);
            if (child && child.length) {
              this.reportedChild.push(item);
              this.reportedChildOriginal.push(item);
              this.reportedChildName[item.intakeservicerequestactorid] = item.fullname;
            }
          }
        });
      }
    });
    this.drugList = this._dataStoreService.getData('CASEWORKER_DRUG_LIST_AOD');
  }

  patchClientData(value: any) {
    const data = this.reportedChild.find(ele => ele.intakeservicerequestactorid === value);
    if (data) {
      this.preliminaryForm.patchValue({
        dob: new Date(data.dob),
        address: this.getFormattedAddress(data),
        contact: data.phonenumber
      });
    }
  }

  private getFormattedAddress(data: any) {
    return (data.address ? data.address + ',' : '')
    + (data.address2 ? data.address2  + ',' : '')
  + (data.state ? data.state + ',' : '')
   + (data.city ? data.city + ',' : '')
   + (data.zipcode ? data.zipcode : '');
}

removeAddedChild() {
  if (this.preliminaryFormList && this.preliminaryFormList.length > 0) {
    this.preliminaryFormList.forEach(data => {
      this.reportedChild = this.reportedChild.filter(ele => ele.intakeservicerequestactorid !== data.client);
    });
  } else {
    this.reportedChild = this.reportedChildOriginal;
  }
}

showEditPreliminary(mode: number, model: any, index?: any) {
  if (mode === 2) {
    this.preliminaryFormList.splice(index, 1);
    return true;
  }
  if (mode === 3) {
    this.removeAddedChild();
  }
  this.preliminaryForm.enable();
  this.showpreliminary = true;
  this.preliminaryMode = mode;
  if (model) {
    this.reportedChild = this.reportedChildOriginal;
    this.preliminaryForm.patchValue(model);
    if (model.signature) {
      this.signature = model.signature;
    }
    this.preliminaryindex = index;
    if (mode === 0) {
      this.preliminaryForm.disable();
    }
  } else {
    this.preliminaryForm.reset();
  }
}

cancelPreliminary() {
  this.showpreliminary = false;
}

savePreliminary() {
  const preliminaryForm = this.preliminaryForm.getRawValue();
  preliminaryForm.formStatus = this.preliminaryForm.valid;
  if (this.preliminaryMode && this.preliminaryMode === 1 && this.preliminaryindex) {
    this.preliminaryFormList[this.preliminaryindex] = preliminaryForm;
  } else {
    this.preliminaryFormList.push(preliminaryForm);
  }
  this.showpreliminary = false;
  this.removeAddedChild();
}

getClientPrint(item: any) {
  const data = item;

  data['clientname'] = this.reportedChildName[item['client']];

  if (item['ispositivedrugscreenchild']) {
    data['ispositivedrugscreenchildnames'] = item['ispositivedrugscreenchild'].map((child: any) => this.reportedChildName[child] );
  }
  
  if (item['ispositivedrugscreendrug']) {
    data['ispositivedrugscreendrugnames'] = item['ispositivedrugscreendrug'].map((drug: any) => this.drugList.find((item1: { ref_key: any; }) => item1.ref_key === drug).value_text);
  }

  if (item['isuseddrugstwelvemonthsdrug']) {
    data['isuseddrugstwelvemonthsdrugnames'] = item['isuseddrugstwelvemonthsdrug'].map((drug: any) => this.drugList.find((item2: { ref_key: any; }) => item2.ref_key === drug).value_text);
  }

  

  


  return data;

}

getPreliminaryFormListPrint() {
  const preliminaryFormListPrint: any[] = [];
  this.preliminaryFormList.forEach( (item) => {
    preliminaryFormListPrint.push(this.getClientPrint(item));
  })
  return preliminaryFormListPrint;
}

getAodRequest() {
  return {
    assessmentactor :  this.processActorDetails(),
    aodidentifyForm: this.aodidentifyForm.getRawValue(),
    authorizationForm: this.authorizationForm.getRawValue(),
    preliminaryForm: this.getPreliminaryFormListPrint(),
    supervisorname: this.authorizationForm.get('supervisorname')?.value,
    routingsupervisors: this.routingSupervisors,
    currentSubmissionId: this.currentSubmissionId,
    assessmentStaus: this.assessmentStatus
  };
}

  processActorDetails() {
    const assessmentactorArray: any[] = [];
    this.preliminaryFormList.forEach(child => {
        const assessmentactor = {
          'intakeservicerequestactorid': child.client ? child.client : null,
      };
      assessmentactorArray.push(assessmentactor);
    });
    return assessmentactorArray;
  }
  saveAssessment() {
    this.viewAod = true;
    const aodAssessmentData = this.getAodRequest();
    this._dataStoreService.setData('PRINTDATA', aodAssessmentData);    
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, aodAssessmentData )
        .subscribe(
          (response) => {
            this._alertService.success('Assessment data saved');
            if (response.data) {
              this.currentAssessmentId = response.data.assessmentid;
              this.currentSubmissionId = response.data.submissionid;
            } else {
              this.currentAssessmentId = response.assessmentid;
              this.currentSubmissionId = response.submissionid;
            }
            this.viewAod = false;
          },
          (error) => {
            this.viewAod = false;
            this._alertService.error('Unable to save.');
          }
        );
  }

  submitForApproval() {
    this.viewAod = true;
    if (this.isSupervisor) {
     this.assessmentStatus = this.authorizationForm.get('assessmentstatus')?.value;
    } else {
     this.assessmentStatus = 'Review';
    }
     const submissionData = this.getAodRequest();
     this._dataStoreService.setData('PRINTDATA', submissionData);    
         this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, submissionData)
      .subscribe(
         (response) => {
           this._alertService.success(`${this.assessmentStatus === 'Review' ? 'Approval' : this.assessmentStatus} Submitted Successfully`);
            if (response.data) {
              this.currentAssessmentId = response.data.assessmentid;
              this.currentSubmissionId = response.data.submissionid;
            } else {
              this.currentAssessmentId = response.assessmentid;
              this.currentSubmissionId = response.submissionid;
            }
           this.viewAod = false;
           setTimeout(() => {
             this._router.navigate(['../'], {relativeTo : this.route});
           }, 1000);
         },
         (error) => {
           this.viewAod = false;
           this._alertService.error('Unable to submit for approval.');
         }
       );
 }

 isReadyForApproval() {
  this.incompleteList = [];
  if (!this.aodidentifyForm.valid) {
    this.incompleteList.push('Identifying Information');
  }
  if (this.preliminaryFormList.length > 0) {
    const formStatus = this.preliminaryFormList.filter(data => !data.formStatus);
    if (formStatus && formStatus.length > 0) {
      this.incompleteList.push('Preliminary Alcohol and Other Drugs Sorting');
    }
  } else {
    this.incompleteList.push('Preliminary Alcohol and Other Drugs Sorting');
  }
  if (!this.authorizationForm.valid) {
    this.incompleteList.push('AUTHORIZATION');
  }
  if (this.incompleteList.length === 0) {
    this.submitForApproval();
  } else {
    (<any>$('#incomplete-items')).modal('show');
  }
}

}
