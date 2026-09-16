
import {pluck, share, map} from 'rxjs/operators';
import { Component, OnInit, Injector } from '@angular/core';
import moment from 'moment';
import { PersonService } from '../person.service';
import { FormGroup, FormBuilder } from '@angular/forms';
import { Observable } from 'rxjs';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DropdownModel, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AlertService, AuthService, CommonHttpService, SessionStorageService, DataStoreService, GenericService } from './../../../../../@core/services';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { Assessments } from '../../../_entities/caseworker.data.model';

@Component({
    selector: 'progress-review',
    templateUrl: './progress-review.component.html',
    styleUrls: ['./progress-review.component.scss'],
    standalone: false
})
export class ProgressReviewComponent implements OnInit {
  timeframeforcompletion$!: Observable<DropdownModel[]>;
  presentsubprogram$!: Observable<DropdownModel[]>;
  subprogramassignmentrecommended$!: Observable<DropdownModel[]>;
  outofhomecare$!: Observable<DropdownModel[]>;
  courtaction$!: Observable<DropdownModel[]>;
  serviceplandropdown$!: Observable<DropdownModel[]>;
  riskassessmentdate$!: DropdownModel[];
  safecdate$!: DropdownModel[];
  progressReviewFormGroup!: FormGroup;
  id!: string;
  daNumber: string;
  roleId!: AppUser;
  progressReviewList$: any;
  progressReviewList: any;
  personList: any[] = [];
  personidlist: any[] = [];
  showPanel = false;
  assessment$!: Observable<Assessments[]>;
  overallriskratingupdatedval: any;
  familyintialassessmentdata: any;
  overallriskrating: any;
  agencyserviceslist: any;
  isServiceCase!: string;
  dtformat = 'MM/DD/YYYY';
  newBtnDisabled: boolean | undefined;
  approvalStatus: boolean | undefined;
  iscaseexpunged: any = 0;
  
  private _commonService: CommonHttpService; 
  private _alertService: AlertService; 
  private _service: GenericService<Assessments>;
  private _dataStoreService: DataStoreService; 
  private _authService: AuthService; 
  private _personService: PersonService; 
  private formBuilder: FormBuilder; 
  private storage: SessionStorageService;

  constructor(private injector: Injector){
    this._commonService = this.injector.get<CommonHttpService>(CommonHttpService); 
    this._alertService = this.injector.get<AlertService>(AlertService); 
    this._service = this.injector.get<GenericService<Assessments>>(GenericService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService); 
    this._authService = this.injector.get<AuthService>(AuthService); 
    this._personService = this.injector.get<PersonService>(PersonService); 
    this.formBuilder = this.injector.get<FormBuilder>(FormBuilder); 
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);

    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
  }

  ngOnInit() {
    this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.roleId = this._authService.getCurrentUser();
    this.isServiceCase = this.storage.getItem('ISSERVICECASE');
    this.initiateFormGroup();
    this.loadProgressReviewDropdowns();
    this.getCaseEvaluationDetails();
    this.getServicePlanList();
    this.getAssessmentsData();
    this.getAgencyServiceList();
    this._personService.getPersonsList().subscribe((item) => {
      this.personList = item.data;
    });
    this.progressReviewFormGroup.disable();
  }

  getCaseEvaluationDetails() {
    this._personService.getCaseEvaluationDetails(this.id).subscribe(res => {
      if (res && res.length > 0) {
        this.progressReviewList$ = res[0];
        this.progressReviewFormGroup.patchValue(this.progressReviewList$);
        this.progressReviewFormGroup.patchValue({
          extnapprovalstatustypekeyforui: this.getMultiSelectDropDown(this.progressReviewList$.extnapprovalstatustypekey),
          closinglettercopytypekeyforui: this.getMultiSelectDropDown(this.progressReviewList$.closinglettercopytypekey)
        });
      }
    });
  }

  getAgencyServiceList() {
    this._personService.getAgencyServiceList(this.daNumber).subscribe((res: any) => {
      this.agencyserviceslist = res['servicelogData'];
    });
  }


  addVendorServices() {
    // (<any>$('#view-newagencyprovider')).modal('show');
  }


  riskassessmentchange(event: string) {
    if (this.familyintialassessmentdata && this.familyintialassessmentdata.intakassessment && this.familyintialassessmentdata.intakassessment.length > 0) {
      this.familyintialassessmentdata.intakassessment.forEach((element: { assessmentid: string; submissiondata: { risklevel2: any; }; }) => {
        if (event === element.assessmentid) {
          const risklevel = element.submissiondata.risklevel2;
          this.checkRiskLevel(risklevel);
        }
      });
    }
  }
  checkRiskLevel(risklevel: number){
    if (risklevel >= 0 && risklevel <= 1) {
      this.overallriskrating = 'Low';
    } else if (risklevel >= 2 && risklevel <= 4) {
      this.overallriskrating = 'Moderate';
    } else if (risklevel >= 5 && risklevel <= 8) {
      this.overallriskrating = 'High';
    } else if (risklevel >= 8) {
      this.overallriskrating = 'Very High';
    } else {
      this.overallriskrating = 'N/A';
    }
  }

  getAssessmentsData() {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    let inputRequest: Object;
    if (this.isServiceCase) {
      inputRequest = {
        objecttypekey: 'servicecase',
        objectid: this.id,
        // objectid: '1ab13583-6d94-4929-92e0-09723df839f3',
        isExpungementSuperUser: isExpungementSuperUser,
        iscaseexpunged: this.iscaseexpunged
      };
    } else {
      inputRequest = {
        servicerequestid: this.id,
        categoryid: null,
        subcategoryid: null,
        targetid: null,
        assessmentstatus: null,
        isExpungementSuperUser: isExpungementSuperUser
      };
    }

    const source = this._service
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 25,
          where: inputRequest,
          method: 'get'
        }),
        'admin/assessment/list?filter'
      ).pipe(
      map(result => {
        return { data: result.data, count: result.count };
      }),
      share(),);
    this.assessment$ = source.pipe(pluck('data'));

    const familyintialassessmentlist: any[] = [];
    const safecassessmentlist: any[] = [];
    this.assessment$.forEach((res) => {
      const familyintialassessment = res.find(element => element.description === 'MFIRA');
      this.familyintialassessmentdata = familyintialassessment;
      if (familyintialassessment && familyintialassessment.intakassessment && familyintialassessment.intakassessment.length > 0) {
        familyintialassessment.intakassessment.forEach(assessment => {
          const date = moment(new Date(assessment.updateddate)).format(this.dtformat);
          const dp = new DropdownModel({
            text: date,
            value: assessment.assessmentid
          });
          familyintialassessmentlist.push(dp);
        }
        );
        this.riskassessmentchange(familyintialassessment.assessmentid);
        this.riskassessmentdate$ = familyintialassessmentlist as DropdownModel[];
      }
      const safecassessment = res.find(element => element.description === 'SAFE-C');
      if (safecassessment && safecassessment.intakassessment && safecassessment.intakassessment.length > 0) {
        safecassessment.intakassessment.forEach(assessment => {
          const date = moment(new Date(assessment.updateddate)).format(this.dtformat);
          const dp = new DropdownModel({
            text: date,
            value: assessment.assessmentid
          });
          safecassessmentlist.push(dp);
        }
        );
        this.safecdate$ = safecassessmentlist as DropdownModel[];
      }

    });
  }


  getServicePlanList() {
    this.serviceplandropdown$ = this._personService.getServicePlanList(this.id).pipe(map(result => {
      return result.map(
        (res) => {
          const date = moment(new Date(res.goaldate)).format(this.dtformat);
          return new DropdownModel({
            text: date,
            value: res.serviceplangoalid
          });
        });
    }));
  }

  checkProperty() {
    let count = 0;
    this.personList.forEach(o => {
      if (o.isSingned) {
        count++;
      }
    });


    return count;
  }

  onPersonChecked(event: { checked: any; }, person: any) {
    person.isSingned = event.checked;
    if (this.checkProperty() >= 1) {
      this.showPanel = true;
    } else {
      this.showPanel = false;
    }
  }


  loadProgressReviewDropdowns() {
    const source = this._personService.loadProgressReviewDropdowns().pipe(
      map((result) => {
        return {
          timeframeforcompletion: this.createDropDownModel(result[0]),
          presentsubprogram: this.createDropDownModel(result[1]),
          subprogramassignmentrecommended: this.createDropDownModel(result[1]),
          outofhomecare:  this.createDropDownModel(result[2]),
          courtaction: this.createDropDownModel(result[3])
        };
      }),share(),);
    this.timeframeforcompletion$ = source.pipe(pluck('timeframeforcompletion'));
    this.presentsubprogram$ = source.pipe(pluck('presentsubprogram'));
    this.subprogramassignmentrecommended$ = source.pipe(pluck('subprogramassignmentrecommended'));
    this.outofhomecare$ = source.pipe(pluck('outofhomecare'));
    this.courtaction$ = source.pipe(pluck('courtaction'));
  }

  createDropDownModel(result: any)
  {
    return result.map(
      (res: { description: any; ref_key: any; }) =>
        new DropdownModel({
          text: res.description,
          value: res.ref_key
        })
    )
  }

  getMultiSelectDropDown(array: any) {
    const multiSelectDropDown: any[] = [];
    if (array && array.length) {
      const arrymultidropdown = array.split(',');
      arrymultidropdown.forEach((data: any) => {
        multiSelectDropDown.push(data);
      });
    }
    return multiSelectDropDown ? multiSelectDropDown : [];
  }


  save() {
    this.progressReviewList = this.progressReviewFormGroup.getRawValue();
    this.progressReviewList.caseid = this.id;
    this.progressReviewList.activeflag = 1;
    this.progressReviewList.closinglettercopytypekey = this.assignMultiSelectValues(this.progressReviewList.closinglettercopytypekeyforui);
    this.progressReviewList.extnapprovalstatustypekey = this.assignMultiSelectValues(this.progressReviewList.extnapprovalstatustypekeyforui);

    this.progressReviewList.serviceneededflag = this.updateflags(this.progressReviewList.serviceneededflag);
    this.progressReviewList.caseopenflag = this.updateflags(this.progressReviewList.caseopenflag);
    this.progressReviewList.aodflag = this.updateflags(this.progressReviewList.aodflag);
    this.progressReviewList.approvalagencyflag = this.updateflags(this.progressReviewList.approvalagencyflag);
    this.progressReviewList.adminextnsinfsflag = this.updateflags(this.progressReviewList.adminextnsinfsflag);
    this.progressReviewList.ssapolicyflag = this.updateflags(this.progressReviewList.ssapolicyflag);
    this.progressReviewList.referalmadeagencyflag = this.updateflags(this.progressReviewList.referalmadeagencyflag);
    this.progressReviewList.noserviceneededflag = this.updateflags(this.progressReviewList.noserviceneededflag);
    this.progressReviewList.providerrefflag = this.updateflags(this.progressReviewList.providerrefflag);
    this.progressReviewList.objectivesachievedflag = this.updateflags(this.progressReviewList.objectivesachievedflag);
    this.progressReviewList.familyrefusedserviceflag = this.updateflags(this.progressReviewList.familyrefusedserviceflag);
    this.progressReviewList.casetransferflag = this.updateflags(this.progressReviewList.casetransferflag);
    this.progressReviewList.servivceagreementflag = this.updateflags(this.progressReviewList.servivceagreementflag);



    const body = this.progressReviewList;
    this._commonService.create(body, 'caseevaluation/addupdate').subscribe(result => {
      if (result) {
        this.getCaseEvaluationDetails();
        this._alertService.success('Saved successfully!');
      }
    }, (error) => {
      this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    }
    );
  }

  updateflags(flag: any) {
    if (flag) {
      return 1;
    } else {
      return 0;
    }
  }

  assignMultiSelectValues(val: any) {
    let array = '';
    if (val) {
      val.forEach(function (element: string, index: number) {
        if (index === 0) {
          array = element;
        } else if (index > 0) {
          array = array + ',' + element;
        }
      });
    }
    return array;
  }

  private initiateFormGroup() {
    this.progressReviewFormGroup = this.formBuilder.group({
      caseevaluationid: [''],
      caseid: [''],
      evaluationdate: null,
      nextrecondate: null,
      timeframetypekey: null,
      presentprogramtypekey: null,
      presentprogramopendate: null,
      presentprogramcloseddate: null,
      exttilldate: null,
      riskassessmentid: null,
      safetyassessmentid: null,
      newreferraltext: null,
      familyperception: null,
      familyserviceneeds: null,
      positiveresponsetypekey: null,
      treatmentissues: null,
      courtinvolvement: null,
      ofhplacement: null,
      totalfund: null,
      fianotificationtypekey: null,
      fianotification: null,
      workerdiscusstypekey: null,
      workerdiscuss: null,
      familystrength: null,
      requestextn: null,
      extntime: null,
      approvalstatustypekey: null,
      extnrequired: null,
      servicesprovided: null,
      serviceoutcome: null,
      serviceplanprogress: null,
      serviceplanobjectives: null,
      serviceplandisagreement: null,
      serviceemployed: null,
      familyclosingreason: null,
      providedclosingplantypekey: null,
      providedclosingplan: null,
      closinglettercopytypekey: null,
      closinglettercopytypekeyforui: null,
      closinglettercopy: null,
      futureservicetypekey: null,
      futureservice: null,
      serviceneededflag: null,
      casetransferflag: null,
      transfertotypekey: null,
      transferserviceintensitytypekey: null,
      caseopenflag: null,
      aodflag: null,
      consentformcompleted: null,
      referralformcompleted: null,
      providerrefflag: null,
      noserviceneededflag: null,
      objectivesachievedflag: null,
      familyrefusedserviceflag: null,
      supportservicecomments: null,
      servivceagreementflag: null,
      extnapprovalstatustypekey: null,
      extnapprovalstatustypekeyforui: null,
      serviceintensitylevel: null,
      insertedby: null,
      insertedon: null,
      updatedby: null,
      updatedon: null,
      activeflag: 1,
      fmlyclosingreasontypekey: null,
      fmlyclosingreason: null,
      concurtypekey: null,
      concurrecommendation: null,
      safedate: null,
      safetydecisiontypekey: null,
      safetyplaninitiatedflag: null,
      riskassessmentdate: null,
      overallriskrating: null,
      summary: null,
      serviceplanid: null,
      old_id: null,
      approvalagencyflag: null,
      adminextnsinfsflag: null,
      ssapolicyflag: null,
      referalmadeagencyflag: null
    });
  }
}
