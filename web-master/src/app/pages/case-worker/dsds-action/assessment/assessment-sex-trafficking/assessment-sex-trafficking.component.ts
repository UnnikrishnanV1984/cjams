import { Component, Injector, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { CommonHttpService, AlertService, DataStoreService, AuthService, CommonDropdownsService, SessionStorageService } from '../../../../../@core/services';
import { AssessmentService } from '../assessment.service';
import { AppUser } from '../../../../../@core/entities/authDataModel';

@Component({
    selector: 'assessment-sex-trafficking',
    templateUrl: './assessment-sex-trafficking.component.html',
    styleUrls: ['./assessment-sex-trafficking.component.scss'],
    standalone: false
})
export class AssessmentSexTraffickingComponent implements OnInit {

  ASSESSMENT_NAME = 'Sex Trafficking(CST) Screening Interview Form'; 
  screeninterviewForm!: FormGroup; 
  removalChildList: any;
  races: any;
  currentAssessmentId!: string;
  currentSubmissionId!: string;
  assessmentStatus!: string; 
  staData: any;
  submissiondata: any;
  isServiceCase: any;
  roleId!: AppUser;
  agency!: string;
  isCW!: boolean;
  caseworkersignature: any;
  supervisorsignature: any;
  id: any;
  daNumber: any;
  routingSupervisors: any[] = [];
  isSupervisor!: boolean;
  viewSTA = false;
  authorizationApproval!: FormGroup;
  programarea: any;
  programname: string = '';
  ethinicityDropdownItems$!: Observable<any[]>;
  private readonly _formBuilder: FormBuilder;
  private readonly route: ActivatedRoute;
  private readonly _router: Router;
  private readonly _commonHttpService: CommonHttpService;
  private readonly _alertService: AlertService;
  private readonly _assessmentService: AssessmentService;
  private readonly _dataStoreService: DataStoreService;
  private readonly _commonDDService: CommonDropdownsService;
  private readonly storage: SessionStorageService;
  private readonly _authService: AuthService;

  constructor(private readonly injector : Injector){
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._router = this.injector.get<Router>(Router);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._assessmentService = this.injector.get<AssessmentService>(AssessmentService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonDDService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    this._authService = this.injector.get<AuthService>(AuthService);

    this.id = this._commonDDService.getStoredCaseUuid();
    this.daNumber = this._commonDDService.getStoredCaseNumber();
  }

  ngOnInit() { 
    this.programarea = this._dataStoreService.getData('programarea');
    if(this.programarea){
      this.programarea.forEach((element: any,index: any) => {
        var sep = ' ';
        if(index !== 0 ) {
          sep = ', ';
        }
        this.programname = this.programname + sep + element.programname;
      });
    }
    this.initScreeninterviewForm();
    this.authorizationApprovalForm();
    this.roleId = this._authService.getCurrentUser();
    this.isSupervisor = (this.roleId && this.roleId.role && this.roleId.role.name === 'apcs') ? true : false;
    this.prefillAuthorizationApprovalInfo();
    this.routingSupervisors = this._dataStoreService.getData('CASEWORKER_SUPERVISORS') ? this._dataStoreService.getData('CASEWORKER_SUPERVISORS') : [];
    this._assessmentService.getservicecase();
    this.removalChildList = this._dataStoreService.getData('REMOVAL_CHILD_LIST');
    this.staData = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');
    this.ethinicityDropdownItems$ = this._commonDDService.getPickListByName('race');
    this.currentAssessmentId = this.staData.assessmentid;
    this.currentSubmissionId = this.staData.submissionid;
    if(this.staData && this.staData.submissionid){
      this.getSubmisionData();
    }
    if (this.authorizationApproval.get('caseworkersign')?.value) {
      this.caseworkersignature = this.authorizationApproval.get('caseworkersign')?.value;
    }
    if (this.authorizationApproval.get('supervisorsign')?.value) {
      this.supervisorsignature = this.authorizationApproval.get('supervisorsign')?.value;
    }
  }  


  prefillAuthorizationApprovalInfo() {
    this.authorizationApproval.patchValue({
      supervisorname: this._dataStoreService.getData('da_assignedby'),
      workername: (this.roleId && this.roleId.user && this.roleId.user.userprofile) ? this.roleId.user.userprofile.fullname : ''
    })
  }


  
  /**
   * Placing init values into the form group.
   */
  initScreeninterviewForm() {
    this.screeninterviewForm = this._formBuilder.group({
      childName: [''],
      nickName: [''] ,
      cjamspid:[''],
      location: this.programname,
      gender: [''],
      dob: [null],
      assessmentInitDate:[null],
      serviceCaseId: this.daNumber,
      age:[''],
      race:[''],
      intDate:[null],
      screening:[''],
      leftHomeOrFosterCare:[''],
      numOfTimes:[''],
      CSTRiskBox1:[''],
      numOfDaysAway:[''],
      CSTRiskBox2:[''],
      reasonsMadeYouLeave:[''],
      takeCareOfYourself:[''],
      thinksDoneDuringStay:[''],
      placeStayedAtNight:[''],
      CSTRiskBox3:[''],
      personsStayedWithYouth:[''],
      checkAnypersonStayedWithYouth:[''],
      infoOfPlaceAndPersonDuringStay:[''],
      reasonsForNotGoingBack:[''],
      specialPersonInYourLife:[''],
      ageOfThePerson:[''],
      howMuchOlder:[''],
      CSTRiskBox4:[''],
      aboutSpecialFriend:[''],
      aboutSpecialThings:[''],
      CSTRiskBox5:[''],
      unComfortableThings:[''],
      CSTRiskBox6:[''],
      anyTattoos:[''],
      whatKindOfTattoo:[''],
      CSTRiskBox7:[''],
      policeContact:[''],
      citiesAndStatesContactOccurIn:[''],
      resultInArrest:[''],
      reasonGorArrest:[''],
      CSTRiskBox8:[''],
      topicsAboutYouth:[''],
      youthMediaProfiles:[''],
      beingTrafficked:[''],
      reportMadeToCPS:[''],
      additionalScreening:[''],
      referralService:[''],
      listOfBelongings:[''],
      attitudeDemeanor:['']
      
    });
  }

  selectChild(child: any) {
    this.screeninterviewForm.patchValue({
      dob: child.value.dob,
      age:child.value.age,
      gender:child.value.gender,
      cjamspid: child.value.cjamspid
    });

    this.getAssignedRoleData(child.value.race);
    this.getNicknameData(child.value.personid)
  }

  
  getNicknameData(personid: string) {
    this._assessmentService.getAliasNames(personid).subscribe(nicknames => {
      let lastname;
      this.screeninterviewForm.patchValue({
        nickName: nicknames.map((item: any) => {
          lastname = item.lastname == null ? '': ' ' + item.lastname.trim();
          return item.akatypetypekey === 'NN' && item.firstname.trim() + lastname;
        }).filter((x: any) => x !== '' && x !== false)
      });
    });
  }

  getAssignedRoleData (race: any[]) {
    if (race) {
      const racetype = [];
       this.ethinicityDropdownItems$.subscribe(data => {
         const raceIds =  race.map(item => item.racetypekey);
         const raceValues: any[] = [];
         raceIds.forEach(item => {
           data.forEach(ele => {
             if(ele.ref_key === item) {
               raceValues.push(ele.value_text);
             }
           })
         })
        this.screeninterviewForm.patchValue({
          race: raceValues.map(item => item)
        });
       });
     }else{
       this.screeninterviewForm.controls['race'].reset();
     }
  }

  getSubmisionData() {
    const url = `admin/assessment/getassessmentform/${this.staData.external_templateid}/submission/${this.staData.submissionid}`;
    this._commonHttpService.getSingle({}, url).subscribe(result => {
      this.submissiondata = result;
      this.patchSTAForm();
    });
  }

  patchSTAForm(){
    this.viewSTA = false;
    if(this.staData && this.staData.submissiondata){
      this.submissiondata = this.staData.submissiondata;
    }
    this._dataStoreService.setData('PRINTDATA', this.submissiondata);
    if (this.staData && (this.staData.mode === 'update' || this.staData.mode === 'submit')) {
      if (this.submissiondata.screeninterviewForm) {
        this.screeninterviewForm.patchValue(this.submissiondata.screeninterviewForm);
        this.checkIfCjamspidFn();
      }

      if (this.submissiondata && this.submissiondata.authorizationApproval) {
        this.handleIfAuthorizationApprovalFn();
      }
    }

    if (this.staData && this.staData.mode === 'submit') {
      this.viewSTA = true;
      this.screeninterviewForm.disable();
      this.authorizationApproval.disable();
    }

  }
  // Assosiated with patchSTAForm method
  private checkIfCjamspidFn() {
    if (this.submissiondata.screeninterviewForm.cjamspid) {
      var selectedChild = this.removalChildList.filter((child: { cjamspid: any; }) => this.submissiondata.screeninterviewForm.cjamspid === child.cjamspid);
      if (selectedChild && selectedChild.length > 0) {
        this.screeninterviewForm.patchValue({
          childName: selectedChild[0]
        });
      }
    }
  }

  // Assosiated with patchSTAForm method
  private handleIfAuthorizationApprovalFn() {
    const approvaldata = this.submissiondata.authorizationApproval;
    this.authorizationApproval.patchValue({
      routingsupervisors: approvaldata.routingsupervisors,
      supervisorname: approvaldata.supervisorname,
      workername: approvaldata.workername,
      caseworkersign: approvaldata.caseworkersign,
      caseworkersigndate: approvaldata.caseworkersigndate,
      caseworkercomments: approvaldata.caseworkercomments,
      supervisorsign: approvaldata.supervisorsign,
      supervisorsigndate: approvaldata.supervisorsigndate,
      supervisorcomments: approvaldata.supervisorcomments,
      assessmentstatus: approvaldata.assessmentstatus
    });
  }

  authorizationApprovalForm() {
    this.authorizationApproval = this._formBuilder.group({
      routingsupervisors: [null],
      supervisorname: [{value: '', disabled: true}],
      workername: [{value: '', disabled: true}],
      caseworkersign: [''],
      caseworkersigndate: [null],
      caseworkercomments: [''],
      supervisorsign: [''],
      supervisorsigndate: [null],
      supervisorcomments: [''],
      assessmentstatus: ['']
    });
  }


  changeSupervisor(userid: any) {
    const user: any = this.routingSupervisors.find((item: any) => item.userid === userid);
    if (user.username) {
      this.authorizationApproval.patchValue({
        supervisorname: user.username
      });
    }
  }


  countCSTRisk(){
    let CSTRiskCount = 0;
    for(let i=1; i<9; i++){
      if(this.screeninterviewForm.get('CSTRiskBox'+i)?.value){
        ++CSTRiskCount;
      }
    }
    return CSTRiskCount;
  }
 
  getSTARequest() {
    return {
      screeninterviewForm :  this.screeninterviewForm.getRawValue(),
      authorizationApproval: this.authorizationApproval.getRawValue(),
      supervisorname: this.authorizationApproval.get('supervisorname')?.value,
      assessmentStaus: this.assessmentStatus,
      currentSubmissionId: this.currentSubmissionId
    };
  }

  saveAssessment(){
    const staAssessmentData = this.getSTARequest();
    this._dataStoreService.setData('PRINTDATA', staAssessmentData);    
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, staAssessmentData )
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
          },
          (error) => {
            this._alertService.error('Unable to save.');
          }
        );
  }

  isReadyForApproval(){
    this.submitForApproval();
  }

  submitForApproval() {
    if (this.isSupervisor) {
     this.assessmentStatus = this.authorizationApproval.get('assessmentstatus')?.value;
    } else {
     this.assessmentStatus = 'Review';
    }
     const submissionData = this.getSTARequest();
     this._dataStoreService.setData('PRINTDATA', submissionData);    
     
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, submissionData)
      .subscribe(
         (response) => {
           this._alertService.success(`${this.assessmentStatus === 'Review' ? 'Approval' : this.assessmentStatus} Submitted Successfully`);
           setTimeout(() => {
             this._router.navigate(['../'], {relativeTo : this.route});
           }, 1000);
         },
         (error) => {
           this._alertService.error('Unable to submit for approval.');
         }
       );
  }

}
