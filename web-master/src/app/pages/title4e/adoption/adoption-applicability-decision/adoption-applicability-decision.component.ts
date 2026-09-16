import { Component, OnInit, Input, Injector } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlertService, AuthService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../../@core/services';
import { Title4eService } from '../../services/title4e.service';
import { AppConstants } from '../../../../@core/common/constants';
import { CASE_STORE_CONSTANTS } from '../../../case-worker/_entities/caseworker.data.constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'adoption-applicability-decision',
    templateUrl: './adoption-applicability-decision.component.html',
    styleUrls: ['./adoption-applicability-decision.component.scss'],
    standalone: false
})
export class AdoptionApplicabilityDecisionComponent implements OnInit {
  id!: string;
  @Input() adoptionData: any;
  client_id: any;
  removalid: any;
  sendforcaseworker = true;
  isSupervisor = false;
  isSpecialist = false;
  transactionid: any;
  userInfo: any;
  approvalusername: any;
  adoptionApplicabilityDecisionForm!: FormGroup;
  getUsersList: any[]=[];
  activeModule: any = null;
  selectedPerson: any;
  incompletespecalistsignature: any;
  decisionsubmissionspecalistsignature: any;
  decisionresubmissionspecalistsignature: any;
  submitForApprovalRemark: string='';
  approvalid: any;
  assessmentDecisionData: any;
  rolename: string='';
  isreadonly = false;
  displayValidationMessages: boolean = false;

  private readonly defaultAssessmentDecisionData = {
    adoptionapplicable: null,
    adoptionnonapplicable: null,
    applicableandnonapplicable: null,
    neitheranappnornonappchildfortitleivepurposes: null
  };

  private _alertService: AlertService;
  public _authService: AuthService;
  private _formBuilder: FormBuilder;
  private _commonHttpService: CommonHttpService;
  private _dataStoreService: DataStoreService;
  private titleIVeService: Title4eService;
  private _sessionStorage: SessionStorageService;

  constructor(private injector: Injector) {
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this.titleIVeService = this.injector.get<Title4eService>(Title4eService);
    this._sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
  }

  ngOnInit() {
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.client_id = this._dataStoreService.getData('adoption_clientid');
    this.removalid = this._dataStoreService.getData('adoption_removalid');
    this.userInfo = this._authService.getCurrentUser();
    this.rolename = this.userInfo.role.key ? this.userInfo.role.key : this.userInfo.user.userprofile.teammemberassignment.teammember.teammemberroletype.roletypekey;
    this._dataStoreService.currentStore.subscribe((item) => {
      if (item['isivereadonly']) {
        this.isreadonly = item['isivereadonly'];
      }
    });
    this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.IVE_SUPERVISOR) || this._authService.selectedRoleIs('IV-E Eligibility Quality Assurance') || this._authService.selectedRoleIs('IV-E Eligibility Administrator');
    this.isSpecialist = this._authService.selectedRoleIs(AppConstants.ROLES.IVE_SPECIALIST) || this._authService.selectedRoleIs('IV-E Eligibility Analyst');
    if (this.userInfo && this.userInfo.user) {
          this.approvalusername = this.userInfo.user.userprofile.firstname + ' ' + this.userInfo.user.userprofile.lastname;
    }
    this.initializeForm();
    if (this.removalid) {
        this.getAdoptionApplicabilityDecision();
    }
    this.isTabSwitched();
    this._authService.readonlyPage('read_only_access','',
    [this.adoptionApplicabilityDecisionForm
    ]);
  }

  isTabSwitched() {
    $('.intake-tabs a').on('shown.bs.tab', (event) => {
      var x = $(event.target).text();
      if (x.includes("DECISION")) {
        this.getAdoptionApplicabilityDecision();
      }
    });
  }

  initializeForm() {
    this.adoptionApplicabilityDecisionForm = this._formBuilder.group({
      appchildmeetchildstatuscriteriaofsectionia12or3: [{ value: '', disabled: true }],
      appplacementormedicalcriteriaofsectionib12or3: [{ value: '', disabled: true }],
      appthespecialneedscriteriainsecic12aorband3aorb: [{ value: '', disabled: true }],
      haschildbeenassessedtonotbeanappchild: [{ value: '', disabled: true }],
      nonappplacementormedicalcriteriaofsecib12or3: [{ value: '', disabled: true }],
      nonapplsplneedscriteriainsecic12aorband3aorb: [{ value: '', disabled: true }],
      nonappltitleivestandardsofsecid1prioradptionaorbor2ivefcorssiao: [{ value: '', disabled: true }],
      applicableandnonapplicable: [{ value: '', disabled: true }],
      adoptiondataincomplete: [{ value: '', disabled: true }],
      adoptionacasubmitted: [null, [Validators.required]],
      adoptionapplicable: [{ value: '', disabled: true }],
      adoptionnonapplicable: [{ value: '', disabled: true }],
      neitheranappnornonappchildfortitleivepurposes: [{ value: '', disabled: true }],
      incompletespecalistname: [{ value: '', disabled: true }],
      incompletedate: [{ value: '', disabled: true }],
      incompletespecalistsignature: null,
      decisionsubmissionspecalistname: [{ value: '', disabled: true }],
      decisionsubmissiondate: [{ value: '', disabled: true }],
      decisionsubmissionspecalistsignature: [null],
      decisionresubmissionspecalistname: [{ value: '', disabled: true }],
      decisionresubmissiondate: [{ value: '', disabled: true }],
      decisionresubmissionspecalistsignature: [null],
      approvalid:null,
      approvalstatus:null
    });
  }

  getAdoptionApplicabilityDecision() {
    this._commonHttpService.getAll(
      'iveadoption/adoption/adoption-applicability-decision/' + this.client_id + '/' + this.removalid
    ).subscribe((response: any) => {
      this.getAdoptionApplicabilityDecisionResponse(response);
      
      if (!this.sendforcaseworker) {
        this.sendforcaseworkerIsFalse();
      }
    });
  }

  private getAdoptionApplicabilityDecisionResponse(response: any) {
    if (response?.adoptionApplicabilityauditInfo?.length > 0) {
      this.getAdoptionApplicabeDecisionResponse(response);
    } else {
      this.assessmentDecisionData = this.defaultAssessmentDecisionData;
    }
    this.patchIncompletespecalistData();
  }

  private patchIncompletespecalistData() {
    if (this.sendforcaseworker && this.isSpecialist && !(this.adoptionApplicabilityDecisionForm.getRawValue().incompletespecalistname)) {
      this.adoptionApplicabilityDecisionForm.patchValue({
        incompletespecalistname: this.userInfo.user.userprofile.firstname + ' ' + this.userInfo.user.userprofile.lastname,
        incompletedate: new Date(),
        incompletespecalistsignature: null
      });
    }
  }

  private getAdoptionApplicabeDecisionResponse(response: any) {
    this.transactionid = response.adoptionApplicabilityauditInfo[0].transactionid;
    this.adoptionDataPatchFn(response);

    this.assessmentDecisionData = this.returnAssessmentDecisionDataFn(response);

    this.adoptionacasubmittedPatch(response);

    if (response.adoptionApplicabilityauditInfo[0].approvalstatus === "APPROVED" || this.isSupervisor) {
      this.adoptionApplicabilityDecisionForm.controls.adoptionacasubmitted.disable();
    }
  }

  private adoptionacasubmittedPatch(response: any) {
    if (response.adoptionApplicabilityauditInfo[0].approvalstatus !== null) {
      this.adoptionApplicabilityDecisionForm.patchValue({
        adoptionacasubmitted: (response.adoptionApplicabilityauditInfo[0].adoptionacasubmitted) ? response.adoptionApplicabilityauditInfo[0].adoptionacasubmitted : false,
      });
    }
  }

  private adoptionDataPatchFn(response: any) {
    this.adoptionApplicabilityDecisionForm.patchValue(response.adoptionApplicabilityauditInfo[0]);
    this.adoptionApplicabilityDecisionForm.patchValue(this.adoptionTrueFalsePatchFn(response));
    this.sendforcaseworker = response.adoptionApplicabilityauditInfo[0].adoptiondataincomplete === 'YES' ? true : false;
    this.incompletespecalistsignature = response.adoptionApplicabilityauditInfo[0].incompletespecalistsignature;
    this.decisionsubmissionspecalistsignature = response.adoptionApplicabilityauditInfo[0].decisionsubmissionspecalistsignature;
    this.decisionresubmissionspecalistsignature = response.adoptionApplicabilityauditInfo[0].decisionresubmissionspecalistsignature;
    if (response.adoptionApplicabilityauditInfo[0].adoptionapplicable === 'YES' || response.adoptionApplicabilityauditInfo[0].adoptionnonapplicable === 'YES' ||
      response.adoptionApplicabilityauditInfo[0].applicableandnonapplicable === 'YES' || response.adoptionApplicabilityauditInfo[0].neitheranappnornonappchildfortitleivepurposes === 'YES') {
      this.sendforcaseworker = false;
    }
  }

  private adoptionTrueFalsePatchFn(response: any): { [key: string]: any; } {
    return {
      applicableandnonapplicable: response.adoptionApplicabilityauditInfo[0].applicableandnonapplicable === 'YES' ? true : false,
      adoptiondataincomplete: response.adoptionApplicabilityauditInfo[0].adoptiondataincomplete === 'YES' ? true : false,
      adoptionapplicable: response.adoptionApplicabilityauditInfo[0].adoptionapplicable === 'YES' && response.adoptionApplicabilityauditInfo[0].applicableandnonapplicable !== 'YES' ?
        true : false,
      adoptionnonapplicable: response.adoptionApplicabilityauditInfo[0].adoptionnonapplicable === 'YES' && response.adoptionApplicabilityauditInfo[0].applicableandnonapplicable !== 'YES' ?
        true : false,
      neitheranappnornonappchildfortitleivepurposes: response.adoptionApplicabilityauditInfo[0].neitheranappnornonappchildfortitleivepurposes === 'YES' ? true : false
    };
  }

  private returnAssessmentDecisionDataFn(response: any): any {
    return {
      adoptionapplicable: (response.adoptionApplicabilityauditInfo[0].adoptionapplicable === 'YES' && response.adoptionApplicabilityauditInfo[0].applicableandnonapplicable !== 'YES') ? true : false,
      adoptionnonapplicable: (response.adoptionApplicabilityauditInfo[0].adoptionnonapplicable === 'YES' && response.adoptionApplicabilityauditInfo[0].applicableandnonapplicable !== 'YES') ? true : false,
      applicableandnonapplicable: (response.adoptionApplicabilityauditInfo[0].applicableandnonapplicable === 'YES') ? true : false,
      neitheranappnornonappchildfortitleivepurposes: (response.adoptionApplicabilityauditInfo[0].neitheranappnornonappchildfortitleivepurposes === 'YES') ? true : false
    };
  }

  private sendforcaseworkerIsFalse() {
    if (this.isSpecialist && !(this.adoptionApplicabilityDecisionForm.getRawValue().decisionsubmissionspecalistname)) {
      this.adoptionApplicabilityDecisionForm.patchValue(this.returnDecisionSubmissionData());
    }
    if (this.isSupervisor && !(this.adoptionApplicabilityDecisionForm.getRawValue().decisionresubmissionspecalistname)) {
      this.adoptionApplicabilityDecisionForm.patchValue(this.returnDecisionReSubmissionData());
    }
    if (this.isSupervisor) {
      this.adoptionApplicabilityDecisionForm.controls['decisionresubmissiondate'].enable();
    }
    if (this.isSpecialist) {
      this.adoptionApplicabilityDecisionForm.controls['decisionsubmissiondate'].enable();
    }
  }

  private returnDecisionReSubmissionData(): { [key: string]: any; } {
    return {
      decisionresubmissionspecalistname: this.userInfo.user.userprofile.firstname + ' ' + this.userInfo.user.userprofile.lastname,
      decisionresubmissiondate: new Date(),
      decisionresubmissionspecalistsignature: null
    };
  }

  private returnDecisionSubmissionData(): { [key: string]: any; } {
    return {
      decisionsubmissionspecalistname: this.userInfo.user.userprofile.firstname + ' ' + this.userInfo.user.userprofile.lastname,
      decisionsubmissiondate: new Date(),
      decisionsubmissionspecalistsignature: null
    };
  }

  showSupervisorList() {
    if (this.adoptionApplicabilityDecisionForm.invalid) {
      this.displayValidationMessages =true;
      this.adoptionApplicabilityDecisionForm.markAllAsTouched();
    }
    this.submitForApprovalRemark = '';
    this.titleIVeService.getUsersList().subscribe(result => {
      if(this.rolename ==  AppConstants.ROLES.TITLE_IVE_ANALYST){
        this.getUsersList = result.data.filter(user => (user.rolecode === AppConstants.ROLES.TITLE_IVE_Quality_Assurance || user.rolecode === AppConstants.ROLES.TITLE_IVE_ADMINISTRATOR));
      } else {
          this.getUsersList = result.data.filter(user => user.rolecode === AppConstants.ROLES.TITLE_IVE_SUPERVISOR);
      }
    });
    if (this.adoptionApplicabilityDecisionForm.value.decisionsubmissionspecalistsignature) {
        (<any>$('#assign')).modal('show');
    } else {
        this._alertService.error('Please add Signature to proceed.');
    }
  }

  sendToCaseWorker() {
    this._commonHttpService.create({
      ivestatus: 'PENDING',
      clientId: this.client_id,
      removalId: this.removalid
    },
      'iveadoption/updatestatus'
    ).subscribe(res => {
      this._alertService.success('Sent To Case Worker');
      this.updateSpecalistAndSupervisor();
    });
  }

  selectPerson(item:any) {
    this.selectedPerson = item;
  }

  sendToSupervisor() {
    if (this.selectedPerson) {
      this._commonHttpService.create(
        {
          'where': {
            'clientid': this.client_id,
            'removalid': this.removalid,
            'status': '{68}',
            'eventType': 'Adoptionapplicability'
          },
          'page': 1,
          'limit': 10
        },
        'titleive/ive/approval-status'
      ).subscribe(response => {
        if (response && response.data && response.data.length > 0) {
          const params = {
            'assignedtoid': this.selectedPerson.userid,
            'eventcode': 'ABLR',
            'status': 'SplReview',
            'notifymsg': 'Adoption Applicability Decision for ' + this.client_id + ' was sent for review',
            'routeddescription': 'route',
            'comments': 'Request for Review - ' + this.submitForApprovalRemark,
            'adoptionbreakthelinkid': response.data[0].sp_ive_status_approval,
            'signText': 'Signed',
            'servicecaseid': this.id,
            'touserrole': this.selectedPerson ? this.selectedPerson.rolecode : null,
            'userprofilerole': this.rolename,
          }

          this.routingUpdate(params, 'Review');
        }
      },
        (error) => {
          this._alertService.error('Unable to process');
          return false;
        }
      );
    } else {
      this._alertService.error('Select a Supervisor');
    }
    this.updateSpecalistAndSupervisor();
    this._alertService.success('Sent To Supervisor');
    (<any>$('#assign')).modal('hide');
  }

  RejectDetermination(){
    (<any>$('#comments')).modal('show');
  }

  updateSpecalistAndSupervisor() {
    const payload :any = {};
    payload['incompletespecalistname'] = this.adoptionApplicabilityDecisionForm.getRawValue().incompletespecalistname;
    payload['incompletedate'] = this.adoptionApplicabilityDecisionForm.getRawValue().incompletedate;
    payload['incompletespecalistsignature'] = this.adoptionApplicabilityDecisionForm.getRawValue().incompletespecalistsignature;
    payload['decisionsubmissionspecalistname'] = this.adoptionApplicabilityDecisionForm.getRawValue().decisionsubmissionspecalistname;
    payload['decisionsubmissiondate'] = this.adoptionApplicabilityDecisionForm.getRawValue().decisionsubmissiondate;
    payload['decisionsubmissionspecalistsignature'] = this.adoptionApplicabilityDecisionForm.getRawValue().decisionsubmissionspecalistsignature;
    payload['decisionresubmissionspecalistname'] = this.adoptionApplicabilityDecisionForm.getRawValue().decisionresubmissionspecalistname;
    payload['decisionresubmissiondate'] = this.adoptionApplicabilityDecisionForm.getRawValue().decisionresubmissiondate;
    payload['decisionresubmissionspecalistsignature'] = this.adoptionApplicabilityDecisionForm.getRawValue().decisionresubmissionspecalistsignature;
    payload['resubmissioncount'] = this.adoptionApplicabilityDecisionForm.getRawValue().resubmissioncount;
    payload['adoptionacasubmitted'] = this.adoptionApplicabilityDecisionForm.getRawValue().adoptionacasubmitted;
    payload['adoptionapplicable'] = (this.adoptionApplicabilityDecisionForm.getRawValue().adoptionapplicable === true) ? 'YES' : null;
    payload['applicableandnonapplicable'] = (this.adoptionApplicabilityDecisionForm.getRawValue().applicableandnonapplicable) ? 'YES' : null;
    payload['adoptionnonapplicable'] = (this.adoptionApplicabilityDecisionForm.getRawValue().adoptionnonapplicable) ? 'YES' : null;
    payload['neitheranappnornonappchildfortitleivepurposes'] = (this.adoptionApplicabilityDecisionForm.getRawValue().neitheranappnornonappchildfortitleivepurposes) ? 'YES' : null;

    if (this.transactionid) {
      this._commonHttpService.patch(
        this.transactionid,
        payload,
        'tb_ive_adoption_audit'
      ).subscribe(
        response => {
          // No content to add or call
        },
        error => {
          this._alertService.error('Error!');
        }
      );
    }
  }

  ApproveReject(status:any) {
    if (this.adoptionApplicabilityDecisionForm.invalid) {
      this.displayValidationMessages =true;
      this.adoptionApplicabilityDecisionForm.markAllAsTouched();
    }
      let approvalRejectComments = '';
      let approvalRejectStatus = '';
      if (status === 'APPROVED') {
          approvalRejectComments = '';
          approvalRejectStatus = 'SpvApproved';
      } else if (status === 'REJECTED') {
          approvalRejectComments = 'Rejected for : ' + this.submitForApprovalRemark;
          approvalRejectStatus = 'SpvRejected';
      }
    (<any>$('#comments')).modal('hide');
    this.approvalid = this.adoptionApplicabilityDecisionForm.getRawValue().approvalid;
    if (status === 'APPROVED' && (this.adoptionApplicabilityDecisionForm.value.decisionresubmissionspecalistsignature === '' || this.adoptionApplicabilityDecisionForm.value.decisionresubmissionspecalistsignature === null)) {
          this._alertService.error('Please add Signature to proceed.');
    } else {
        this._commonHttpService.create(
            {
                'where': {
                    'approval_id': this.approvalid,
                    'approval_status': status,
                    'placement_type': 'Adoptionapplicability',
                    'approveduser': this.approvalusername ? this.approvalusername : null
                },
                'page': 1,
                'limit': 10
            },
            'titleive/ive/ivespv-approval'
        ).subscribe(response => {
                if (response && response.data && response.data.length > 0) {
                    const params = {
                        'eventcode': 'ABLR',
                        'status': approvalRejectStatus,
                        'notifymsg': 'Adoption Applicability Decision for ' + this.client_id + ' was ' + status,
                        'routeddescription': 'route',
                        'comments': approvalRejectComments,
                        'adoptionbreakthelinkid': this.approvalid,
                        'signText': 'Signed',
                        'userprofilerole': this.rolename,
                    }
                    this.routingUpdate(params, status);
                    this.approvalid = null;
                    this.submitForApprovalRemark = '';
                }
            },
            (error) => {
                this._alertService.error('Unable to process');
                return false;
            }
        );
    }
    this.updateSpecalistAndSupervisor();
  }

  routingUpdate(params:any, status:any) {
    this._commonHttpService.create(
      {
        'where': params
      },
      'titleive/ive/routingUpdate'
    ).subscribe(response => {
      (<any>$('#assign')).modal('hide');
      if(status === 'Review'){
        this._alertService.success('Sent For Approval');
      }
      else
      {
        this._alertService.success('Determination is ' + status);
      }
    },
      (error) => {
        this._alertService.error('Unable To Process');
        return false;
      }
    );
  }

  changeAdoptionSubmission(item:any) {
    if(item.value) {
      this.adoptionApplicabilityDecisionForm.patchValue({
        adoptionapplicable: false,
        adoptionnonapplicable: false,
        applicableandnonapplicable: false,
        neitheranappnornonappchildfortitleivepurposes: true
      })
    } else {
      this.adoptionApplicabilityDecisionForm.patchValue(this.assessmentDecisionData);
    }
  }

  getErrorsMessage(ControlName:any, displayName:any){
    if(this.adoptionApplicabilityDecisionForm.controls[ControlName].status =='INVALID' ){
    return 'Please enter valid ' + displayName
    }
  }

}