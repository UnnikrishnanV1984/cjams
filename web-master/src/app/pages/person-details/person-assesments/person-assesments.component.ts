
import {mergeMap, map} from 'rxjs/operators';
import { Component, OnInit, EventEmitter, Injector } from '@angular/core';
import { PaginationInfo, DropdownModel } from '../../../@core/entities/common.entities';
import { ActivatedRoute } from '@angular/router';
import { PersonAssesmentsService } from './person-assesments.service';
import { AuthService, CommonHttpService, SessionStorageService, AlertService, DataStoreService } from '../../../@core/services';
import {
  Assessments, GetintakAssessment,
  IntakeAssessmentRequestIds, IntakeDATypeDetail,
  AssessmentSummary, AllegationItem, InvolvedPerson,
  AssessmentScores
} from '../../newintake/my-newintake/_entities/newintakeModel';
import { HttpService } from '../../../@core/services/http.service';
import { IntakeStoreConstants } from '../../newintake/my-newintake/my-newintake.constants';
import { NewUrlConfig } from '../../newintake/newintake-url.config';
import { AppConfig } from '../../../app.config';
import { environment } from '../../../../environments/environment.dev4';
import { AppUser } from '../../../@core/entities/authDataModel';
import { Observable } from 'rxjs';
import { EvaluationFields } from '../../newintake/my-newintake/_entities/newintakeSaveModel';
declare var $: any;
declare var Formio: any;
declare var FormioExport: any;
import _ from 'lodash';
import { PersonDetailsService } from '../person-details.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-assesments',
    templateUrl: './person-assesments.component.html',
    styleUrls: ['./person-assesments.component.scss'],
    standalone: false
})
export class PersonAssesmentsComponent implements OnInit {
  totalRecords!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  items: any[] = [];
  personid: string | null | undefined;
  id!: string;
  daNumber!: string;
  assessmmentName!: string;
  private intakeDATypeDetail!: IntakeDATypeDetail;
  role!: AppUser;
  private assessmentRequestDetail!: IntakeAssessmentRequestIds;
  startAssessment$!: Observable<Assessments[]>;
  assessmentSummary$!: Observable<AssessmentSummary[]>;
  totalRecords$!: Observable<number>;
  daTypeDropDownItems$!: Observable<DropdownModel[]>;
  daSubTypeDropDownItems$!: Observable<DropdownModel[]>;
  filteredAllegationItems: AllegationItem[] = [];
  submissionId!: string;
  assessmentTemplateId!: string;
  showAssesment = -1;
  getAsseesmentHistory: GetintakAssessment[] = [];
  formioOptions!: {
    formio: {
      ignoreLayout: true;
      emptyValue: '-';
    };
  };
  templateComponentData: any;
  templateSubmissionData: any;
  getScoreOnClose!: boolean;
  selectedPurpose!: string;
  currentTemplateId!: string;
  isReadOnlyForm = false;
  refreshForm: any;
  safeCKeys!: string[];
  selectedSafeCDangerInfluence: any[] = [];
  intakeFormData: any;
  addedPersons: InvolvedPerson[] = [];
  evalFields!: EvaluationFields;
  assmntScores: AssessmentScores = new AssessmentScores();
  store: any;
  agency = '';
  showAssmnt!: boolean;
  intakeFormDRAIData: any = null;
  savesuccessmsg = ' saved successfully.';
  iframepopupid = '#iframe-popup';
  assessmentpopupid = '#assessment-popup';
  jwttokenkey = 'x-jwt-token';

  private route: ActivatedRoute;
    private _personService: PersonAssesmentsService;
    private _personDetailsService: PersonDetailsService;
    private _authService: AuthService;
    private _commonService: CommonHttpService;
    private storage: SessionStorageService;
    private _alertService: AlertService;
    private _http: HttpService;
    private _dataStore: DataStoreService;

  constructor(private injector:Injector){
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._personService = this.injector.get<PersonAssesmentsService>(PersonAssesmentsService);
    this._personDetailsService = this.injector.get<PersonDetailsService>(PersonDetailsService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._http = this.injector.get<HttpService>(HttpService);
    this._dataStore = this.injector.get<DataStoreService>(DataStoreService);
  
    this.route.data.subscribe((response: any) => {
      this.items = response.items.data;
      this.totalRecords = response.items.count;
    });
    this.personid = this.route.snapshot.parent?.parent?.paramMap.get('personid');
    this.store = this._dataStore.getCurrentStore();
  }

  ngOnInit() {
    this.agency = this._authService.getAgencyName();
    this.refreshForm = new EventEmitter();

    this.loadDropdownItems();
    this.role = this._authService.getCurrentUser();

    this.id = this.store[IntakeStoreConstants.intakenumber];
    {
      this.addedPersons = this.store[IntakeStoreConstants.addedPersons];
    }
    {
      this.evalFields = this.store[IntakeStoreConstants.evalFields];
    }
    if (this._authService.isDJS()) {
      this.getIntakeDRAIAssessmentDetails();
    }
  }

  private loadDropdownItems() {
    this.daTypeDropDownItems$ = this._commonService
      .getArrayList(
        {
          nolimit: true,
          where: { activeflag: 1 },
          method: 'get'
        },
        NewUrlConfig.EndPoint.Intake.DATypeUrl + '?filter'
      ).pipe(
      map(result => {
        return result.map(res => new DropdownModel({ text: res.description, value: res.intakeservreqtypeid }));
      }));
  }

  getPage(paginationInfo: PaginationInfo) {
    this.paginationInfo.where = {
      personid: this.personid, personstatus: this._personDetailsService.personStatus, agencycode: 'DJS',
      intakeservicerequesttypeid: '', intakeservicerequestsubtypeid: '',
      target: 'Intake'
    };
    this._personService.getAssesmentList(this.paginationInfo).subscribe((assessment: any) => {
      this.items = assessment.data;
      this.totalRecords = assessment.count;
    });
  }

  startAssessment(assessment: any) {
    this.showAssmnt = true;
    this.assessmmentName = assessment.titleheadertext;
    this.currentTemplateId = assessment.external_templateid;
    const _self = this;
    Formio.setToken(this.storage.getObj('fbToken'));
    Formio.baseUrl = environment.formBuilderHost;
    Formio.createForm(document.getElementById('assessmentForm'), environment.formBuilderHost + `/form/${assessment.external_templateid}`).then((form: any) => {
      form.components = form.components.map((item: { key: string; type: string; action: string; }) => {         
        if (item.key === 'Complete' && item.type === 'button') {
          item.action = 'submit';
        }
        return item;
      });
      form.submission = {
        data: _self.getFormPrePopulation(_self.assessmmentName, form.data)
      };
      form.on('submit', (submission: any) => {
        if (_self.assessmmentName === 'SAFE-C') {
          submission.data['safeCDangerInfluence'] = _self.selectedSafeCDangerInfluence;
        }
        _self._http
          .post('admin/assessment/Add', {
            externaltemplateid: _self.currentTemplateId,
            assessmentstatustypekey1: 'Submitted',
            objectid: _self.id,
            submissionid: submission._id,
            submissiondata: submission.data ? submission.data : null,
            form: submission.form ? submission.form : null,
            score: submission.data.score ? submission.data.score : 0
          })
          .subscribe((response: any) => {
            _self._alertService.success(_self.assessmmentName + this.savesuccessmsg);
            _self.redirectToAssessment();
          });
      });
      form.on('change', (formData: any) => {
        _self.safeCProcess(formData);
      });
      form.on('render', (formData: any) => {
        (<any>$(this.iframepopupid)).modal('show'); // NOSONAR
        setTimeout(() => {
          $(this.assessmentpopupid).scrollTop(0);
        }, 200);
      });

      form.on('error', (error: any) => {
        setTimeout(() => {
          $(this.assessmentpopupid).scrollTop(0);
        }, 200);
        _self._alertService.error('Unable to save ' + _self.assessmmentName + '. Please try again.');
      });
    });
  }
  redirectToAssessment() {
    this.showAssmnt = false;
    this.pageChanged({ itemsPerPage: 10, page: 1 });
  }

  updateAssessment(assessment: GetintakAssessment) {
    this.showAssmnt = true;
    this.assessmmentName = assessment.titleheadertext;
    Formio.setToken(this.storage.getObj('fbToken'));
    Formio.baseUrl = environment.formBuilderHost;
    const _self = this;
    Formio.createForm(document.getElementById('assessmentForm'), environment.formBuilderHost + `/form/${assessment.external_templateid}/submission/${assessment.submissionid}`, {
      readOnly: false,
      icons:'fontawesome'
    }).then((form: any) => { 
      form.components = form.components.map((item: { key: string; type: string; action: string; }) => {   // NOSONAR   
        if (item.key === 'Complete' && item.type === 'button') {  //This function has less than 3 lines of code which is identical to the one on line 173. Hence we are marking it as No sonar
          item.action = 'submit';
        }
        return item;
      });
      form.submission = {
        data: _self.getFormPrePopulation(_self.assessmmentName, form.data)
      };
      (<any>$(this.iframepopupid)).modal('show');   // NOSONAR
      form.on('render', (formData: any) => {
        setTimeout(() => {
          $(this.assessmentpopupid).scrollTop(0);
        }, 200);
      });
      form.on('submit', (submission: any) => {
        if (_self.assessmmentName === 'SAFE-C') {
          submission.data['safeCDangerInfluence'] = _self.selectedSafeCDangerInfluence;
        }
        _self._http
          .post('admin/assessment/Add', {
            externaltemplateid: _self.currentTemplateId,
            objectid: _self.id,
            submissionid: submission._id,
            submissiondata: submission.data ? submission.data : null,
            form: submission.form ? submission.form : null,
            score: submission.data.score ? submission.data.score : 0,
            assessmentstatustypekey1: 'Submitted',
          })
          .subscribe(() => {
            _self._alertService.success(_self.assessmmentName + this.savesuccessmsg);
            _self.redirectToAssessment();
          });
      });
      form.on('change', (formData: any) => {
        _self.safeCProcess(formData);
      });

      form.on('error', (_error: any) => {   // NOSONAR 
        setTimeout(() => { // This function has less than 3 lines of duplicate code. Hence marking it as No Sonar
          $(this.assessmentpopupid).scrollTop(0);
        }, 200);
        _self._alertService.error('Unable to save ' + _self.assessmmentName + '. Please try again.');
      });
    });
  }

  submittedAssessment(assessment: GetintakAssessment) {
    this.assessmmentName = assessment.titleheadertext;
    Formio.setToken(this.storage.getObj('fbToken'));
    Formio.baseUrl = environment.formBuilderHost;
    Formio.createForm(document.getElementById('assessmentForm'), environment.formBuilderHost + `/form/${assessment.external_templateid}/submission/${assessment.submissionid}`, {
      readOnly: true,
      icons:'fontawesome'
    }).then((submission: any) => {
      (<any>$(this.iframepopupid)).modal('show');   // NOSONAR
      submission.on('render', (formData: any) => { // NOSONAR  // This function has less than 3 lines of duplicate code. Hence marking it as No Sonar 
        setTimeout(() => {
          $(this.assessmentpopupid).scrollTop(0);
        }, 200);
      });
    });
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.pageSize = pageInfo.itemsPerPage;
    this.getPage(this.paginationInfo);
  }

  assessmentPrintView(assessment: GetintakAssessment) {
    const _self = this;
    Formio.setToken(this.storage.getObj('fbToken'));
    Formio.baseUrl = environment.formBuilderHost;
    Formio.createForm(document.getElementById('assessmentForm'), environment.formBuilderHost + `/form/${assessment.external_templateid}/submission/${assessment.submissionid}`, {
      readOnly: true,
      icons:'fontawesome'
    }).then(function (submission: any) {
      const options = {
        ignoreLayout: true
      };
      _self.viewHtml(submission._form, submission._submission, options);
    });
  }

  private safeCProcess($event: any) {
    this.safeCProcessEvent($event);
  }

  safeCProcessEvent($event: any)
  {
    if (this.assessmmentName === 'SAFE-C') {
      if ($event.changed) {
        const dangerInfluenceKey = $event.changed.component.key;
        if (dangerInfluenceKey && this.safeCKeys.indexOf(dangerInfluenceKey) > -1) {
          const dangerInflunceItem = this.selectedSafeCDangerInfluence.find((item) => item.value === dangerInfluenceKey);
          this.checkDangerInflunceItemFn(dangerInflunceItem, $event, dangerInfluenceKey);
        }
      }
    } else {
      this.selectedSafeCDangerInfluence = [];
    }
  }

  viewHtml(componentData: any, submissionData: any, formioOptions: any) {
    delete submissionData._id;
    delete submissionData.owner;
    delete submissionData.modified;
    const exporter = new FormioExport(componentData, submissionData, formioOptions);
    const appDiv = document.getElementById('divPrintView');
    exporter.toHtml().then((html: any) => {
      html.style.margin = 'auto';
      const iframe: any = this.createIframe(appDiv);
      const doc = iframe.contentDocument || iframe.contentWindow.document;
      doc.body.appendChild(html);
      const assessmentIframeFn = document.getElementById('ifAssessmentView') as HTMLIFrameElement | null;
      if (assessmentIframeFn && assessmentIframeFn.contentWindow) {
          assessmentIframeFn.contentWindow.focus();
          assessmentIframeFn.contentWindow.print();
      }
      // window.frames['ifAssessmentView'].focus();
      // window.frames['ifAssessmentView'].print();
    });
  }

  private createIframe(el: any) {
    _.forEach(el.getElementsByTagName('iframe'), (_iframe) => {
      el.removeChild(_iframe);
    });
    const iframe = document.createElement('iframe');
    iframe.setAttribute('id', 'ifAssessmentView');
    iframe.setAttribute('name', 'ifAssessmentView');
    iframe.setAttribute('frameborder', '0');
    iframe.setAttribute('webkitallowfullscreen', '');
    iframe.setAttribute('mozallowfullscreen', '');
    iframe.setAttribute('allowfullscreen', '');
    iframe.setAttribute('style', 'width: -webkit-fill-available;height: -webkit-fill-available;');
    el.appendChild(iframe);
    return iframe;
  }

  showAssessment(id: number, row: any) {
    this.getAsseesmentHistory = row;
    if (this.showAssesment !== id) {
      this.showAssesment = id;
    } else {
      this.showAssesment = -1;
    }
  }

  private getFormPrePopulation(formName: string, submissionData: any) {
    const prefillUtil: any = null;
    switch (formName.toUpperCase()) {
      case 'MARYLAND FAMILY INITIAL  RISK ASSESSMENT':
        break;

      case 'MARYLAND FAMILY RISK REASSESSMENT':
        break;

      case 'SAFE-C':
        break;

      case 'CANS-F':
        break;
      case 'HOME HEALTH REPORT':
        break;
      case 'SAFE-C OHP':
        break;
      case 'TRANSPORTATION PLAN FORM ATTENDING SCHOOL OF ORIGIN FROM OUT-OF-HOME PLACEMENT':
        break;
      case 'BEST INTEREST DETERMINATION FORM':
        break;
      case 'INTAKE DETENTION RISK ASSESSMENT INSTRUMENT':
        submissionData = prefillUtil.fillIntakeDetentnRiskAssmntInstrument(submissionData, this.intakeFormDRAIData);
        break;
      case 'DOMESTIC VIOLENCE LETHALITY ASSESSMENT':
        submissionData = prefillUtil.fillDomsticViolncLethalityAssmnt(submissionData);
        break;
      case 'DMST SCREENING TOOL':
        submissionData = prefillUtil.fillDMSTScreeningTool(submissionData);
        break;
      case 'MCASP RISK ASSESSMENT':
        submissionData = prefillUtil.fillMCASPriskAssment(submissionData);
    }
    return submissionData;
  }

  getIntakeDRAIAssessmentDetails() {
    if (this.addedPersons && this.addedPersons.length) {
      const personid = this.addedPersons.filter(data => data.Role === 'Youth');
      this._commonService
        .getArrayList(
          {
            method: 'get',
            where: {
              personid: personid && personid.length ? personid[0].Pid : ''
            }
          },
          'Intakeservicerequests/prepopasmtdrai?filter'
        )
        .subscribe((response) => {
          this.intakeFormDRAIData = response;
        });
    }
  }

  private populateIntake() {
    this._commonService
      .getArrayList(
        {
          method: 'get',
          where: {
            servicerequestid: this.id
          }
        },
        'Intakedastagings/getintakesnapshot?filter'
      )
      .subscribe((response) => {
        this.intakeFormData = response[0];
      });
  }

  private getSubmittedAssessmentForm(external_templateid: string, submissionid: string) {
    const templateUrl = environment.formBuilderHost + `/form/${external_templateid}`;
    const submissionUrl = environment.formBuilderHost + `/form/${external_templateid}/submission/${submissionid}`;
    const fbToken = this.storage.getObj('fbToken');
    this._http.setHeader(this.jwttokenkey, `${fbToken}`);
    this._http.overrideUrl = true;
    return this._http.get(templateUrl).pipe(mergeMap((data) => {
      this.templateComponentData = data;
      return this._http.get(submissionUrl);
    }));
  }

  private getAssessmentForm(external_templateid: string) {
    const templateUrl = environment.formBuilderHost + `/form/${external_templateid}`;
    const fbToken = this.storage.getObj('fbToken');
    this._http.setHeader(this.jwttokenkey, `${fbToken}`);
    this._http.overrideUrl = true;
    return this._http.get(templateUrl);
  }

  onFormSubmit($event: any) {
    const submissionUrl = environment.formBuilderHost + `/form/${this.currentTemplateId}/submission?live=1`;
    const fbToken = this.storage.getObj('fbToken');
    this._http.setHeader(this.jwttokenkey, `${fbToken}`);
    this._http.overrideUrl = true;
    let submittedForm = {};
    if (this.assessmmentName === 'SAFE-C') {
      $event.data['safeCDangerInfluence'] = this.selectedSafeCDangerInfluence;
    }
    return this._http
      .post(submissionUrl, $event).pipe(
      mergeMap(
        (data) => {
          submittedForm = {
            externaltemplateid: this.currentTemplateId,
            assessmentstatustypekey1: 'Submitted',
            objectid: this.id,
            submissionid: data._id,
            submissiondata: $event.data ? $event.data : null,
            form: data.form ? data.form : null,
            score: $event.data.score ? $event.data.score : 0
          };
          this._http.overrideUrl = false;
          this._http.baseUrl = AppConfig.baseUrl;
          return this._http.post(NewUrlConfig.EndPoint.Intake.SubmitAssessment, submittedForm);
        }
      ))
      .subscribe(() => {
        this._alertService.success(this.assessmmentName + this.savesuccessmsg);
        (<any>$(this.iframepopupid)).modal('hide'); // NOSONAR
        this.closeAssessment();
      });
  }
  onFormRendered(_event: any) {
    $(this.iframepopupid).removeClass(' intake radio-inline');
  }
  onFormInvalid(_event: any) {
  }
  onFormChange(event: any) {
    this.safeCProcessEvent(event);
  }

  private checkDangerInflunceItemFn(dangerInflunceItem: any, $event: any, dangerInfluenceKey: any) {
    if (dangerInflunceItem) {
      if ($event.changed.value === 'no' || $event.data[$event.changed.component.key] === 'no') {
        const itemIndex = this.selectedSafeCDangerInfluence.indexOf(dangerInflunceItem);
        this.selectedSafeCDangerInfluence.splice(itemIndex, 1);
      }
    } else {
      if ($event.changed.value === 'yes' || $event.data[$event.changed.component.key] === 'yes') {
        this.selectedSafeCDangerInfluence.push({
          text: $event.changed.component.label,
          value: dangerInfluenceKey
        });
      }
    }
  }

  closeAssessment() {
    this.pageChanged({ itemsPerPage: 10, page: 1 });
  }



  navigationToSdm() {
    (<any>$('#sdm-tab')).click();   // NOSONAR
  }

  printView() {
    const assessmentIframeFn = document.getElementById('ifAssessmentView') as HTMLIFrameElement | null;
    if (assessmentIframeFn && assessmentIframeFn.contentWindow) {
        assessmentIframeFn.contentWindow.focus();
        assessmentIframeFn.contentWindow.print();
    }
    // window.frames['ifAssessmentView'].focus();
    // window.frames['ifAssessmentView'].print();
  }

  viewPdf() {
    const exporter = new FormioExport(this.templateComponentData, this.templateSubmissionData, this.formioOptions);
    const appDiv = document.getElementById('divPrintView');
    const formioPdfConfig = {
      download: false,
      filename: this.assessmmentName + '.pdf',
      html2canvas: {
        logging: true,
        onclone: (doc: any) => {
          //No operation needed here
        },
        onrendered: (canvas: any) => {
          //No operation needed here
        }
      }
    };

    exporter.toPdf(formioPdfConfig).then((pdf: any) => {
      const iframe = this.createIframe(appDiv);
      iframe.src = pdf.output('datauristring');
    });
  }

  private getIntakeAssessmentDetails() {
    this.assessmentRequestDetail = Object.assign({});
    const assessmentRequest = new IntakeAssessmentRequestIds();
    assessmentRequest.intakeservicerequesttypeid = '';
    assessmentRequest.intakeservicerequestsubtypeid = '';
    assessmentRequest.agencycode = this.agency;
    assessmentRequest.intakenumber = this.id;
    assessmentRequest.target = 'Intake';
    this.assessmentRequestDetail = assessmentRequest;
    this.pageChanged({ itemsPerPage: 10, page: 1 });
  }

  onDASubTypeChange(option: any) {
    if (option.value) {
      this.intakeDATypeDetail.DasubtypeKey = option.value;
      this.intakeDATypeDetail.DasubtypeText = option.label;
    }
  }

  onDATypeChange(option: any) {
    this.intakeDATypeDetail = new IntakeDATypeDetail();
    this.intakeDATypeDetail.DaTypeKey = option.value;
    this.intakeDATypeDetail.DaTypeText = option.label;
    const url = NewUrlConfig.EndPoint.Intake.DATypeUrl + '?filter';
    this.daSubTypeDropDownItems$ = this._commonService
      .getArrayList(
        {
          include: 'servicerequestsubtype',
          where: { intakeservreqtypeid: this.intakeDATypeDetail.DaTypeKey },
          method: 'get',
          nolimit: true
        },
        url
      ).pipe(
      map(data => {
        return data[0].servicerequestsubtype.map((res: { description: any; servicerequestsubtypeid: any; }) => new DropdownModel({ text: res.description, value: res.servicerequestsubtypeid }));
      }));
  }

  getDRAIScore(result: any) {
    if (result && result.data) {
      result.data.forEach((element: any) => {
        if (element.titleheadertext === 'Intake Detention Risk Assessment Instrument') {
          if (element.intakassessment && element.intakassessment.length > 0) {
            const latestDrai = element.intakassessment[0].submissiondata;
            const scores = {
              score: latestDrai.score,
              value: latestDrai.value,
              AD: latestDrai.AD,
              SD: latestDrai.SD,
              SD2: latestDrai.SD2
            };
            this.assmntScores.DRAI = scores;
            this._dataStore.setData(IntakeStoreConstants.assessmentScore, this.assmntScores);
          }
        }
      });
    }
  }
  getMCAPScore(result: any) {
    if (result && result.data) {
      result.data.forEach((element: any) => {
        if (element.titleheadertext === 'MCASP Risk Assessment') {
          if (element.intakassessment && element.intakassessment.length > 0) {
            const latestMcasp = element.intakassessment[0].submissiondata;
            const scores = {
              dhs: latestMcasp.dhs1,
              shs: latestMcasp.shs2,
              risklevel: latestMcasp.risklevel
            };
            this.assmntScores.MCASP = scores;
            this._dataStore.setData(IntakeStoreConstants.assessmentScore, this.assmntScores);
          }
        }
      });
    }
  }

  isAssmentCompelete(submissionData: any) {
    if (submissionData) {
      if (submissionData.Complete === true) {
        return 1;
      }
      if (submissionData.submit === true) {
        return 2;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }
}
