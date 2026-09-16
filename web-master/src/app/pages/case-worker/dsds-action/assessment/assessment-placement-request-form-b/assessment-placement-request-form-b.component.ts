import { Component, OnInit, Injector } from "@angular/core";
import { FormArray, FormBuilder, FormGroup, Validators } from "@angular/forms";
import moment from "moment";
import { Observable } from 'rxjs';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { AssessmentService } from '../assessment.service';
import { CommonHttpService, DataStoreService, SessionStorageService, AuthService, AlertService, CommonDropdownsService } from '../../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { Router } from "@angular/router";



@Component({
    selector: 'assessment-placementrequest-form-b',
    templateUrl: './assessment-placement-request-form-b.component.html',
    styleUrls: ['./assessment-placement-request-form-b.component.scss'],
    standalone: false
})

export class AssessmentPlacementRequestFormBComponent implements OnInit {
  ASSESSMENT_NAME = 'QUALIFIED INDIVIDUAL (QI) ASSESSMENT - ATTACHMENT B';
  currentAssessmentId: any;
  currentSubmissionId!: string;
  isValue: number = 1;
  isServiceCase: any;
  YouthInformationForm!: FormGroup;
  store: any;
  id = '';
  user!: AppUser;
  agency!: string;
  isCW!: boolean;
  isSupervisor!: boolean;
  personList!: any[];
  spouseorpartnerList: any[] = [];
  spouseorpartnerList1: any[] = [];
  youthList!: any[];
  childList: any[] = [];
  updateprfadata!: boolean;
  viewprfadata!: boolean;

  sibilingList: any[] = [];
  sibilingArraylist: any[] = [];
  sibilingList1: any[]  = [];
  legalGuardian: any[]  = [];
  legalGuardianother: any[]  = [];
  youthListdetails: any[]  = [];
  selectedYouthName = '';
  selectedotherparty = '';
  selectedSibilingName = '';
  selectedrelativename = '';
  prfadata: any;
  placementHistory!: any[];
  currplacement: any;
  primaryCitizenshipDropDownItems$!: Observable<any[]>;
  gradeDropdownItems$!: Observable<any[]>;
  ethinicityDropdownItems$!: Observable<any[]>;
  ethinicityDropdownItems1$!: Observable<any[]>;

  showother: boolean = false;
  livingother: boolean = false;
  showfosterplacement: boolean = false;
  currentliving!: null;
  langother: boolean = false;
  showchheckother: boolean = false;
  showothersc: boolean = false;

  pronouns = ['He/Him/His', 'she/her/hers', 'they/them/theirs', 'Other-Please Specify'];
  Specialconsiderations = [
    {
      value: 'Hearing Impaired',
      label: 'dhoh'
    },
    {
      value: 'LGBTQ',
      label: 'lgbtq'
    },
    {
      value: 'DD/IQ',
      label: 'ddiq'
    },
    {
      value: 'Substance Abuse',
      label: 'subabuse'
    },
    {
      value: 'DV',
      label: 'dv'
    },
    {
      value: 'Trafficking Victim',
      label: 'traffvic'
    },
    {
      value: 'Sexual Abuse Victim',
      label: 'seabvic'
    },
    {
      value: 'Sexual Abuse Offender',
      label: 'seaboff'
    },
    {
      value: 'Pregnant & Parenting',
      label: 'pregandparent'
    },
    {
      value: 'Other issues',
      label: 'otherissues'
    },
  ];

  YouthCurrentlyliving = ['Home of Parent or Legal Guardian', 'Foster Placement, Type', 'Shelter', 'Detention/DOC', 'Psychiatric Hospital', 'Medical Hospital', 'Homeless', 'Friend or Relative', 'Other'];
  legalstatus: any = [];
  preflanguages = ['English', 'Spanish', 'Others'];
  chooseitem!: any[];
  alienlist = ['Asylee', 'Undocumented Alien', 'Parolee', 'Permanent Resident', 'Refugee', 'Resident under color of law', 'Student', 'Temporary Resident - lneilgible']
  // section 2  specific start
  // section 2  specific start
  teamTypeKey!: string;
  placementreqform!: FormGroup;
  placementtypeList!: any[];
  placementtype!: any[];
  maxToDate: any;
  interviewList: any[] = [];
  addedInterviewList: any[] = [];
  interviewArraylist: any[] = [];
  daNumber: any;
  currentDate!: string;
  routingSupervisors: any;
  headofhousehold: any;
  assessmentStatus: any;
  interviewMemberList!: any[];
  relationshipList!: any[];
  selectedPersonId: any;
  selectedactorid: any;
  roleTypeKey!: string | undefined;
  assessmentStatusNew: any;
  qualifiedindividualsignature: any;
  //section 2 end
  notspecified = 'Not Specified';
  placementreqformasubmissiondata: any;
  involvedpersonslist: any;
  updatedby!: string;
  updatedon!: string;
  addperson: boolean = true;
  patchdata: any;
  hasFamilyAccessToCase: boolean = false;
  iscaseexpunged: any = 0;

  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  private _authService: AuthService;
  private _formBuilder: FormBuilder;
  private _router: Router;
  private _assessmentService: AssessmentService;
  private storage: SessionStorageService;
  private _alertService: AlertService;
  private _commonDDService: CommonDropdownsService;
  private _session: SessionStorageService;

  constructor(private injector: Injector) {
    this._dataStoreService = injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = injector.get<CommonHttpService>(CommonHttpService);
    this._authService = injector.get<AuthService>(AuthService);
    this._formBuilder = injector.get<FormBuilder>(FormBuilder);
    this._router = injector.get<Router>(Router);
    this._assessmentService = injector.get<AssessmentService>(AssessmentService);
    this.storage = injector.get<SessionStorageService>(SessionStorageService);
    this._alertService = injector.get<AlertService>(AlertService);
    this._commonDDService = injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._session = injector.get<SessionStorageService>(SessionStorageService);

    this.store = this._dataStoreService.getCurrentStore();
    this.daNumber = this._commonDDService.getStoredCaseNumber();

  }
  ngOnInit(): void {
    this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    this.isServiceCase = this.storage.getItem('ISSERVICECASE');
    this.user = this._authService.getCurrentUser();
    this.getLegalCustodyDropdown();
    this.currentDate = moment(new Date()).format('YYYY-MM-DDTHH:mm');
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.routingSupervisors = this._dataStoreService.getData('CASEWORKER_SUPERVISORS') ? this._dataStoreService.getData('CASEWORKER_SUPERVISORS') : [];
    this.agency = this._authService.getAgencyName();
    this.isSupervisor = (this.user.role.name === 'apcs') ? true : false;
    this.roleTypeKey = this.user?.user?.userprofile?.teammemberassignment?.teammember?.roletypekey;
    this.setRoleTypeKeyFn();
    this._assessmentService.getservicecase();
    if (this.agency === 'CW') {
      this.isCW = true;
    } else {
      this.isCW = false;
    }
    this.initYouthInformation();
    this.initplacementinformation();
    this.getAssignmentsList();

    this.prfadata = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');
    this.assessmentStatusNew = this.prfadata?.submissiondata?.assessmentStaus

    //get details from placement request form A
    this.handlePlacementReqFormAFn();

    if (this.prfadata && (this.prfadata.mode === 'update' || this.prfadata.mode === 'submit')) {
      this.updateprfadata = true;
      this.viewprfadata = false;
    }
    else {
      this.updateprfadata = false;
      this.viewprfadata = false;
    }
    if (this.prfadata && this.prfadata.mode === 'submit') {
      this.updateprfadata = true;
      this.viewprfadata = true;
      this.YouthInformationForm.disable();
      this.placementreqform.disable();
    }

    this.currentAssessmentId = this.prfadata.assessmentid;
    this.currentSubmissionId = this.prfadata.submissionid;
    if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthinformation) {
      this.selectedyouthnamecheck();
    }

    //section 2 start
    this.handleSection2Fn();
    //section 2 end
    const printdata = this.prfadata;
    printdata.submissionData = this.getPRFAdata();
    this._dataStoreService.setData('PRINTDATA', printdata);

  }
  // Assosiated with ngOnInit function
  private handleSection2Fn() {
    if (this.prfadata.submissiondata && this.prfadata.submissiondata.placementinfo) {
      this.placementreqform.patchValue(this.prfadata?.submissiondata?.placementinfo);
      if (this.prfadata && this.prfadata.mode === 'start' && this.prfadata.submissiondata?.placementinfo?.qiassessmenttype === 'R') {
        this.placementreqform.patchValue({
          qiassessmentstartdate: new Date()
        });

      }
      if (this.prfadata.submissiondata?.placementinfo?.interviewarray?.length) {
        this.prfadata.submissiondata?.placementinfo?.interviewarray.forEach((element: any, index: any) => {
          this.addInterview(element);
        });
      }
      this.qualifiedindividualsignature = (this.prfadata.submissiondata.placementinfo?.sinature) ? this.prfadata.submissiondata.placementinfo.sinature : null;
    } else {
      this.userdetails();
    }

    this.patchQualifiedIndivdual();

    if (this.prfadata?.submissiondata?.placementinfo?.listchildarray) {
      this.prfadata.submissiondata.placementinfo.listchildarray.forEach((element: any, index: any) => {
        this.addAnotherListChild(element);
      });
    }

    if (this.prfadata?.submissiondata?.placementinfo?.listservicearray) {
      this.prfadata.submissiondata.placementinfo.listservicearray.forEach((element: any, index: any) => {
        this.addAnotherListService(element);
      });
    }
  }
  // Assosiated with ngOnInit function
  private handlePlacementReqFormAFn() {
    this._commonHttpService.getArrayList(
      {
        page: 1,
        limit: 100,
        method: 'get',
        where: {
          'objectid': this.id,
          'assessmenttemplatename': 'placementreqestform',
        }
      },
      'admin/assessment/getplacementreqformadetails?filter'
    ).subscribe((result) => {
      this.placementreqformasubmissiondata = [];
      result.forEach(item => {
        this.placementreqformasubmissiondata.push(item.submissiondata);

      });

      if (this.placementreqformasubmissiondata) {
        this.getInvolvedPerson(result);

      }
    });
  }

  // Assosiated with ngOnInit function
  private setRoleTypeKeyFn() {
    const activeTab = this.storage.getItem('activeModuleNav');
    if (activeTab === 'Qualified Individual') {
      this.roleTypeKey = 'QUINW';
    } else if (activeTab === 'FTDM/QI Supervisor') {
      this.roleTypeKey = 'FTDMQIS';
    } else if (activeTab === 'FTDM Facilitator') {
      this.roleTypeKey = 'FTDMFW';
    }
  }

  selectedyouthnamecheck() {
    this.selectedYouthName = this.prfadata.submissiondata.youthinformation.YouthName;

    this.YouthInformationForm.patchValue(this.prfadata.submissiondata.youthinformation);
    if (this.prfadata.submissiondata && this.prfadata.submissiondata.youthinformation) {
      if (this.prfadata.submissiondata.youthinformation.Youthpronoun === "3") {
        this.showother = true;
      }
      else {
        this.showother = false;

      }
      if (this.prfadata.submissiondata.youthinformation.Preflang === 'Others') {
        this.langother = true;

      }
      else {
        this.langother = false;
      }
    }
    if (this.prfadata.submissiondata.youthinformation.otherissues) {

      this.showothersc = true;
    }
  }

  userdetails() {
    const userDetails = this._authService.getCurrentUser();

    this.placementreqform.patchValue({
      dateofrequest: new Date(),
      workername: userDetails.user.userprofile.displayname,
      workerphone: (userDetails.user.userprofile.userprofilephonenumber && userDetails.user.userprofile.userprofilephonenumber.length > 0) ? userDetails.user.userprofile.userprofilephonenumber[0].phonenumber : "",
      workeremail: userDetails.user.userprofile.email,
      qiassessmenttype: 'I'
    });

    this._commonHttpService.getSingle(
      {
        where: { securityuserid: this.user.user.securityusersid },
        method: 'get'
      }, 'users/getuserprofilebyid?filter').subscribe(data => {
        if (data && data[0].supprofile && data[0].supprofile.length > 0) {
          const supervisorprofile = data[0].supprofile[0];
          this.placementreqform.patchValue({
            supervisorname: supervisorprofile.displayname,
            supervisoremail: supervisorprofile.email
          });
        }
        if (data && data[0].supervisorphonenumber && data[0].supervisorphonenumber.length > 0) {
          this.placementreqform.patchValue({
            supervisorphone: data[0].supervisorphonenumber[0].phoneNumber
          });
        }
      });
  }

  initplacementinformation() {
    this.placementreqform = this._formBuilder.group({
      qiname: [],
      qiofficelocation: [],
      qiphonenumber: [],
      qiemailid: [],
      qiassessmenttype: [],
      qiassessmentstartdate: [],
      qiassessmentenddate: [],
      comments: [],
      youthreceivedcounseling: [],
      additionalsupports: [],
      discribesupports: [],
      reviewyouthfunctioning: [],
      isseveresubstance: [],
      iscomplexmedical: [],
      iscomplexdevelopmental: [],
      iscomplexmental: [],
      isavailablecommunity: [],
      isother: [],
      isotherdescribebelow: [],
      ischildstrengths: [],
      iscaregiverstrength: [],
      iscommunityresources: [],
      iscareiverresources: [],
      istreatmentfoster: [],
      isothertypeofapproved: [],
      isotherdescribe: [],
      isotherdescribebelows: [],
      cansscoringdiscribe: [],
      cansscoring: [],
      nodocumentdiscrepancies: [],
      describeneededsupports: [],
      changesinlivingsituation: [],
      placementbeingproposed: [],
      willingnessforcontinuing: [],
      involvementwiththeyouth: [],
      currentvisitationplan: [],
      considertheyouthstrengths: [],
      identifyfactors: [],
      ortprecommended: [],
      ortpnotrecommended: [],
      supportthisdecision: [],
      justificationfortherecomendation: [],
      interimplan: [],
      bothwillingtosupport: [],
      ifnoexplain: [],
      explorationofall: [],
      factsthatillustrate: [],
      allohtersuprvision: [],
      recommendationforqrtp: [],
      forreassessment: [],
      thechildcurrent: [],
      childneeds: [],
      sinature: [],
      printedname: [],
      date: [],
      dateofftdm: [],
      facililatorname: [],
      submittedon: []
    });

    this.placementreqform.setControl('listchildarray', this._formBuilder.array([]));
    this.placementreqform.setControl('listservicearray', this._formBuilder.array([]));

    this.placementreqform.setControl('interviewarray', this._formBuilder.array([]));

    this._commonDDService.getListAllByTableID(10008).subscribe(response => {
      this.placementtypeList = response;
    });
    this.maxToDate = new Date();

  }

  patchQualifiedIndivdual() {

    const userDetails = this._authService.getCurrentUser();

    if (this.placementreqform.getRawValue().qiname === null && this.roleTypeKey === "QUINW") {
      this.placementreqform.patchValue({
        qiname: userDetails.user.userprofile.firstname + ' ' + userDetails?.user?.userprofile?.lastname,
        qiofficelocation: userDetails?.user?.userprofile?.teammemberassignment?.teammember?.team?.county?.countyname,
        qiemailid: userDetails?.user?.userprofile?.email,
        qiphonenumber: userDetails?.user?.userprofile?.userprofilephonenumber[0]?.phonenumber,
        printedname: userDetails?.user?.userprofile?.firstname + ' ' + userDetails?.user?.userprofile?.lastname

      })
    }

  }
  addAnotherListChild(modal: any): void {
    const control = <FormArray>this.placementreqform.controls['listchildarray'];
    control.push(this.createListGroup(modal));
  }

  addAnotherListService(modal: any): void {
    const control = <FormArray>this.placementreqform.controls['listservicearray'];
    control.push(this.createListGroup(modal));
  }

  createListGroup(modal: any) {
    return this._formBuilder.group({
      name: modal?.name ? modal.name : null,
    })
  }

  initYouthInformation() {
    this.primaryCitizenshipDropDownItems$ = this.primaryCitizenshipDropDownItems$ = this._commonDDService.getPickListByName('country')
    this.ethinicityDropdownItems$ = this._commonDDService.getPickListByName('race');
    this.ethinicityDropdownItems1$ = this._commonDDService.getPickListByName('ethnicity');

    this.ethinicityDropdownItems1$.subscribe(data => {
      // No content to add or call
    });

    this.YouthInformationForm = this._formBuilder.group({
      YouthName: null,
      YouthCjamspid: null,
      Youthdob: null,
      Youthage: null,
      Youthgender: null,
      Youthpronoun: null,
      Youthsweight: [{ value: null, disabled: true }],
      Youthsheight: [{ value: null, disabled: true }],
      Youthsrace: [{ value: null, disabled: true }],
      Youthsethnicity: [{ value: null, disabled: true }],
      Preflang: null,
      legalstatus: null,
      ifincaregoal: null,
      isacitizen: [{ value: null, disabled: true }],
      primarycitizenof: [{ value: null, disabled: true }],
      secondarycitizen: [{ value: null, disabled: true }],
      nationality: [{ value: null, disabled: true }],
      alienstatus: [{ value: null, disabled: true }],
      alienregistrationno: [{ value: null, disabled: true }],
      icwastatus: [{ value: null, disabled: true }],
      icwaeligibile: [{ value: null, disabled: true }],
      tribalaffiliation: [{ value: null, disabled: true }],
      dhoh: null,
      lgbtq: null,
      ddiq: null,
      subabuse: null,
      dv: null,
      traffvic: null,
      seabvic: null,
      seaboff: null,
      pregandparent: null,
      otherissues: null,
      otherpronoun: null,
      currplacedate: null,
      datefirstentered: null,
      Preflangother: null,
      chkboxother: null,
      youthassessmentaddress: [],
      adultrelationtochild: [],
      adultphonenumber: [],
      adultcontact: []

    })

  }

  getformpayload() {
    var formdata = this.placementreqform.getRawValue();
    return {
      intakeservicerequestactorid: this.user.user.securityusersid,
      assessmentStaus: 'draft',
      assessmentactor: this.user.user.securityusersid,
      sectiontwo: formdata
    };
  }

  saveForm(data: any) {
    if (data !== 'save') {
      this.viewprfadata = true;
      this.placementreqform.patchValue({
        // qiassessmentenddate:moment(this.placementreqform.controls.date.value).format('MM/DD/YYYY hh:mm a')
        qiassessmentenddate: this.placementreqform.controls.date.value
      });
      if (this.YouthInformationForm.invalid || this.placementreqform.invalid) {
        this._alertService.error('Please fill mandatory fields');
        this.viewprfadata = false;
        return
      }
    }

    const userDetails = this._authService.getCurrentUser();
    this.updatedby = userDetails?.user?.userprofile?.firstname + ' ' + userDetails?.user?.userprofile?.lastname;
    this.updatedon = moment(new Date()).format('MM/DD/YYYY hh:mm a');
    if (data !== 'complete' && this.roleTypeKey === 'QUINW') {
      this.placementreqform.patchValue({
        qiname: userDetails?.user?.userprofile?.firstname + ' ' + userDetails?.user?.userprofile?.lastname,
        submittedon: moment(new Date()).format('MM/DD/YYYY hh:mm a')

      })

    }

    this.assessmentStatus = (data === 'complete') ? 'Completed' : this.assessmentStatus;

    const prfaData = this.getPRFAdata();
    prfaData.sendNotification = (data === 'complete' && this.roleTypeKey === 'QUINW') ? true : false;
    this._dataStoreService.setData('PRINTDATA', prfaData);
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, prfaData)
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

  getInvolvedPerson(placementreqformadata: any) {
    let getpersonlistreq = {};
    this.youthList = [];
    if (this.isCW && this.isServiceCase) {
      getpersonlistreq = { objectid: this.id, objecttypekey: 'servicecase' };
    } else {
      getpersonlistreq = { intakeserviceid: this.id };
    }

    const payload = {
      method: 'get',
      count: -1,
      page: 1,
      limit: 20,
      where: getpersonlistreq
    };
    this._commonHttpService.getPagedArrayList(payload, 'People/getpersondetail?filter').subscribe(
      response => {
        this.involvedpersonslist = response.data;
        this.legalGuardian = [];
        if (response && response.data && response.data.length) {
          this.handleGetpersondetailFilterFn(response);
        }
        if (this.selectedYouthName) {
          this.selectYouth(this.selectedYouthName);
          const printdata = this.getPRFAdata();
          this._dataStoreService.setData('PRINTDATA', printdata);
        }
      });

    placementreqformadata.forEach((item: any) => {
      if (this.youthList.length == 0) {
        this.youthList.push(item.submissiondata.youthinformation.YouthName);
      }
      else {

        if (!this.youthList?.includes(item.submissiondata.youthinformation.YouthName)) {
          this.youthList.push(item.submissiondata.youthinformation.YouthName);
        }
      }
    })
  }

  // Assosiated with getInvolvedPerson function
  private handleGetpersondetailFilterFn(response: any) {
    this.personList = response.data;
    this.interviewMemberList = this.personList;
    this.getcollateral();
    this.personList.forEach(list => {
      if (list.isheadofhousehold === true) {
        this.headofhousehold = list;
      }
      if (list.roles) {
        const child = list.roles.filter((roleid: { intakeservicerequestpersontypekey: string; }) => roleid.intakeservicerequestpersontypekey === 'CHILD');
        if (child && child.length > 0) {
          this.childList.push(list);
        }
      }
    });

    this.personList.forEach(list1 => {
      if (list1.roles) {
        const lg = list1.roles.filter((role: { intakeservicerequestpersontypekey: string; }) => role.intakeservicerequestpersontypekey === 'LG');
        if (lg && lg.length > 0) {
          this.legalGuardian.push(list1);
        }
      }
    });
  }

  checkyouthage(item: any) {
    const dob = moment(item.dob);
    const age = moment().diff(dob, 'years', true);
    if (age <= 21) {
      this.youthList.push(item);
    }
  }

  selectYouthValue(eventname: any) {
    this.YouthInformationForm.controls['adultrelationtochild'].reset();
    this.selectYouth(eventname);
  }

  selectYouth(eventname: any) {
    this.currplacement = '';
    this.showother = false;
    this.selectedYouthName = eventname;
    let event;
    if (this.prfadata?.submissiondata?.youthinformation) {
      event = this.prfadata?.submissiondata?.youthinformation;
      this.patchqiassessmentform(event);
    } else {
      const index = this.placementreqformasubmissiondata.find((data: { youthinformation: { YouthName: string; }; }) => data.youthinformation.YouthName === this.selectedYouthName)
      this.patchdata = index.youthinformation;

      const persondetails = this.involvedpersonslist.find((item: { cjamspid: any; }) => item.cjamspid === this.patchdata.YouthCjamspid);
      this.selectedPersonId = persondetails?.personid;
      const prevdata = [];
      this.prfadata?.intakassessment?.forEach((item: any) => {
        if (item.activeplacement && item.submissiondata?.personid == this.selectedPersonId && item.submissiondata.assessmentStaus === "Completed") {
          prevdata.push(item.submissiondata)
        }
      })
      if (prevdata?.length > 0) {
        (<any>$('#newassessmentwarning-popup')).modal('show');

      } else {
        this.patchqiassessmentform(this.patchdata);
      }
    }
  }

  confirmnewassessmnet(val: any) {
    if (val === 'yes') {
      this.patchqiassessmentform(this.patchdata);
    }
    else {
      this.YouthInformationForm.patchValue({
        YouthName: null
      })
    }
    (<any>$('#newassessmentwarning-popup')).modal('hide');
  }

  patchqiassessmentform(event: any) {
    this.YouthInformationForm.patchValue(event);
    this.YouthInformationForm.patchValue({
      icwastatus: event.icwastatus.toLowerCase()
    })
    if (event.parentlgname) {
      this.YouthInformationForm.patchValue({
        adultcontact: event.parentlgname
      })
    }
    if (event.relntoyouth) {
      this.YouthInformationForm.patchValue({
        adultrelationtochild: event.relntoyouth
      })
    }
    if (event.livingphno) {
      this.YouthInformationForm.patchValue({
        adultphonenumber: event.livingphno
      })
    }

    if (event.otherissues) {

      this.showothersc = true;
    } else {
      this.showothersc = false;
    }
    var youthlivingaddress
    if (event.YouthcurrentLiving === 'Placement') {
      youthlivingaddress = event.livaddress;


    } else if (event.YouthcurrentLiving === 'Home of Parent or Legal Guardian') {
      youthlivingaddress = event.addresslineone + " " + event.addresslinetwo + " " + event.city + " " + event.county + " " +
        event.state + " " + event.zipcode;
    } else if (event.YouthcurrentLiving === 'Living Arrangement') {
      youthlivingaddress = event.livaddress
    }
    if (youthlivingaddress) {
      this.YouthInformationForm.patchValue({
        youthassessmentaddress: youthlivingaddress
      })
    }

    if (this.prfadata?.submissiondata?.youthinformation?.Youthpronoun === '3') {
      this.onChangepronoun('3');
    }
    if (this.prfadata?.submissiondata?.youthinformation?.Preflang === 'Others') {
      this.onlanguagechange('Others');
    }
    const persondetails = this.involvedpersonslist.find((item: { cjamspid: any; }) => item.cjamspid === event.YouthCjamspid);
    this.selectedPersonId = persondetails?.personid;
    this.selectedactorid = persondetails?.intakeservicerequestactorid;
    this.getInvolvedPersonWithPersonID(this.selectedPersonId);
    if (this.prfadata && (this.prfadata.mode === 'start')) {
      this.placementreqform.patchValue({
        qiassessmentstartdate: new Date()

      })
    }
  }

  eventracecheck(event: any) {
    this.ethinicityDropdownItems$.subscribe(data => {
      this.chooseitem = data;
      const raceIds = event.race.map((item: { racetypekey: any; }) => item.racetypekey);
      const raceValues: any[] = [];
      raceIds.forEach((item: any) => {
        data.forEach(ele => {
          if (ele.ref_key === item) {
            raceValues.push(ele.value_text);
          }
        })
      })
      this.YouthInformationForm.patchValue({
        Youthsrace: raceValues.map(item => item)
      })
    });
  }

  eventethinicitycheck(event: any) {
    let racetype: any[] = [];
    this.ethinicityDropdownItems1$.subscribe(data => {
      this.chooseitem = data;
      racetype = data.filter(item => item.ref_key === event.ethinicity);
      this.YouthInformationForm.patchValue({
        Youthsethnicity: racetype[0].value_text
      })
    });
  }

  onChangepronoun(event: any) {
    if (event === "3") {
      this.showother = true;
      this.YouthInformationForm.get('otherpronoun')?.setValidators([Validators.required]);
    } else {
      this.showother = false;
      this.YouthInformationForm.controls['otherpronoun'].clearValidators();
      this.YouthInformationForm.patchValue({ otherpronoun: null })
    }
  }

  getPRFAdata() {
    const PRFAdata: any = {
      youthinformation: this.YouthInformationForm.getRawValue(),
      placementinfo: this.placementreqform.getRawValue(),
      currentSubmissionId: this.currentSubmissionId,
      routingsupervisors: this.routingSupervisors,
      sendNotification: false,
      assessmentStaus: this.assessmentStatus || this.prfadata.submissiondata?.assessmentStaus || null,
      personid: this.selectedPersonId || this.prfadata.submissiondata?.personid || null,
      assessmentactor: []
    };
    const assessmentactorValue = (this.prfadata.submissiondata ? this.prfadata.submissiondata?.assessmentactor[0]?.intakeservicerequestactorid : null);
    const assessmentactor = { 'intakeservicerequestactorid': this.selectedactorid ? this.selectedactorid : assessmentactorValue}
    PRFAdata.assessmentactor.push(assessmentactor);
    return PRFAdata;
  }

  onchangespecial(event: any) {
    if (event.target.value === 'otherissues') {
      if (event.target.checked) {
        this.showothersc = true;
      } else {
        this.showothersc = false;
        this.YouthInformationForm.patchValue({
          chkboxother: null
        })
        this.YouthInformationForm.controls['chkboxother'].updateValueAndValidity();

      }
    }
  }

  onlanguagechange(event: any) {

    if (event === 'Others') {
      this.langother = true;
    } else {
      this.langother = false;
      this.YouthInformationForm.controls['Preflangother'].clearValidators();
      this.YouthInformationForm.controls['Preflangother'].updateValueAndValidity();
      this.YouthInformationForm.patchValue({ Preflangother: null })
    }
  }

  submitForApproval() {
    this.assessmentStatus = 'Review';
    const submissionData = this.getPRFAdata();

    submissionData.currentSubmissionId = this.currentSubmissionId;
    submissionData.routingsupervisors = this.routingSupervisors;

    this._dataStoreService.setData('PRINTDATA', submissionData);
    this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, submissionData)
      .subscribe((response) => {
          this._alertService.success(`${this.assessmentStatus === 'Review' ? 'Approval' : this.assessmentStatus} Submitted Successfully`);
          this.goBack();
        },
        (error) => {
          this._alertService.error('Unable to submit for approval.');
        }
      );
  }

  goBack() {
    setTimeout(() => {
      this._router.navigate(['/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/assessment']);
    }, 1000);
  }

  // Section 2
  private createInterviewGroup(modal: any) {
    return this._formBuilder.group({
      name: modal.name ? modal.name : null,
      interviewdate: modal.interviewdate ? modal.interviewdate : null,
      relationtochild: modal.relationtochild ? modal.relationtochild : null,
      isattempted: modal.isattempted ? modal.isattempted : false,
      iscompleted: modal.iscompleted ? modal.iscompleted : false,
    });
  }

  private createInterviewGroupNew() {
    return this._formBuilder.group({
      name: null,
      interviewdate: null,
      relationtochild: null,
      isattempted: false,
      iscompleted: false,
    });
  }

  addInterview(modal: any) {
    if (modal) {
      const control = <FormArray>this.placementreqform.controls['interviewarray'];
      control.push(this.createInterviewGroup(modal));
    } else {
      const control = <FormArray>this.placementreqform.controls['interviewarray'];
      control.push(this.createInterviewGroupNew());
    }
  }

  getcollateral() {
    const request = {
      objectid: this.id,
      objecttype: 'case'
    };
    this._commonHttpService.getArrayList(
      {
        where: request,
        method: 'get',
        nolimit: true
      },
      'collateral/list?filter'
    ).subscribe(data => {
      if (data && data.length && data[0].getcollateraldetails && data[0].getcollateraldetails.length) {
        data[0].getcollateraldetails.forEach((val: { collateralid: any; fullname: any; }) => {
          this.interviewMemberList.push({
            personid: val.collateralid,
            fullname: val.fullname
          })
        });
      }
    });

  }

  getInvolvedPersonWithPersonID(pid: any) {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();

    return this._commonHttpService.getArrayList(
      {
        page: 1,
        limit: 100,
        method: 'get',
        where: {
          'objectid': this.id,
          'objecttypekey': 'servicecase',
          'personid': pid,
          'isExpungementSuperUser': isExpungementSuperUser,
          'iscaseexpunged': this.iscaseexpunged
        }
      },
      'People/getallpersonrelationbyprovidedpersonid?filter'
    ).subscribe((result) => {
      this.relationshipList = (result?.length) ? result : [];
    }, error => {
      this._alertService.error('Error. Please check !!');
    });
  }

  getRelationType(pid: any, i: any) {
    if (this.relationshipList?.length) {
      const relationtype = this.relationshipList.filter(item => item.person2id === pid);
      if (relationtype.length > 0) {
        (<FormArray>this.placementreqform.get('interviewarray')).controls[i].patchValue({
          relationtochild: relationtype[0].relation
        })
      } else {
        (<FormArray>this.placementreqform.get('interviewarray')).controls[i].patchValue({
          relationtochild: 'Unknown'
        })
      }
    } else {
      (<FormArray>this.placementreqform.get('interviewarray')).controls[i].patchValue({
        relationtochild: 'Unknown'
      })
    }
  }

  onChangeAssessmentType(event: any): void {
    this.placementreqform.controls['qiassessmentstartdate'].reset()
    this.placementreqform.controls['qiassessmentenddate'].reset()
  }
  changeCheckBox(modal: any) {
    if (modal) {
      this.placementreqform.patchValue({ childneeds: null });
    } else {
      this.placementreqform.patchValue({ thechildcurrent: null });
    }
  }
  private getLegalCustodyDropdown() {
    this._commonHttpService
      .getArrayList(
        {
          where: {
            referencetypeid: '28',
            teamtypekey: null
          },
          method: 'get',
          nolimit: true
        },
        'referencetype/gettypes' + '?filter'
      )
      .subscribe((res) => {
        res.forEach((dropdowns) => {
          this.legalstatus.push(dropdowns.description)
        })
      });
  }
  deleteinterview(i: any) {
    const control = <FormArray>this.placementreqform.controls['interviewarray'];
    control.removeAt(i);

  }
  getAssignmentsList() {
    this._commonHttpService.getArrayList(
      {
        where: { servicecaseid: this.id },
        method: 'get'
      },
      'Caseassignments/getworkload?filter'
    ).subscribe(data => {
      if (data) {
        const fam = data.filter(item => item.enddate == null);
        if (fam && fam.length > 0 && this.roleTypeKey == 'QUINW') {
          fam.forEach(element => {
            this.handleFamElementFn(element);
          })
        }
      }

    });
  }
  // Assosiated with getAssignmentsList function
  private handleFamElementFn(element: any) {
    const _key = element.responsibilitytypekey;
    if (_key && (_key === 'family' || _key === 'child' || _key === 'administrative')) {
      if (element.toworkerdetails) {
        const familyAssignmentWorker = element.toworkerdetails.filter((a: { securityusersid: string; }) => a.securityusersid === this._authService.getCurrentUser().user.securityusersid);
        if (familyAssignmentWorker.length > 0) {
          this.hasFamilyAccessToCase = true;
        }
      }
    }
  }
  getControlSDataFn(name: string): any[] {
    return Object.values((this.placementreqform.get(name) as FormGroup).controls)
  }
}