
import {timer as observableTimer } from 'rxjs';
import { AfterViewInit, Component, Injector, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import _ from 'lodash';

import { environment } from '../../../../../../../environments/environment';
import { AppUser } from '../../../../../../@core/entities/authDataModel';
import {
  AlertService,
  AuthService,
  CommonHttpService,
  DataStoreService,
  SessionStorageService,
} from '../../../../../../@core/services';
import { HttpService } from '../../../../../../@core/services/http.service';
import { DSDSActionSummary, GetintakAssessment, RoutingInfo } from '../../../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import {
  AssessmentContactNotes,
  General,
  InvestigationSummary,
} from '../../../disposition/_entities/disposition.data.models';
import { InvolvedPerson } from '../../../involved-persons/_entities/involvedperson.data.model';
import { Placement } from '../../../service-plan/_entities/service-plan.model';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { AppConstants } from '../../../../../../@core/common/constants';

declare var Formio: any;
declare var FormioExport: any;
@Component({
    selector: 'appla-view',
    templateUrl: './appla-view.component.html',
    standalone: false
})
export class ApplaViewComponent implements OnInit, AfterViewInit {

  id: string;
  generalSummary!: General;
  daNumber: string;
  assessmmentName!: string;
  investigationSummary!: InvestigationSummary;
  private token!: AppUser;
  selectedSafeCDangerInfluence: any[] = [];
  currentTemplateId!: string;
  isChildSafe = true;
  safeCKeys: string[];
  involvedPersons!: InvolvedPerson[];
  routingInfo!: RoutingInfo[];
  placement!: Placement[];
  assessmentSummary!: AssessmentContactNotes;
  formioOptions!: {
    formio: {
      ignoreLayout: true;
      emptyValue: '-';
    };
  };
  isReadOnlyForm = false;
  intakAssessment = new GetintakAssessment();
  dsdsActionsSummary = new DSDSActionSummary();
  isInitialized = false;
  private formTriggered = false;
  isServiceCase!: string;
  serviceCaseId!: string | null;
  private route: ActivatedRoute;
  private _authService: AuthService;
  private storage: SessionStorageService;
  private _alertService: AlertService;
  private _http: HttpService;
  private _router: Router;

  constructor(
    private readonly injector : Injector,
    private _dataStoreService: DataStoreService,
    private _commonHttpService: CommonHttpService
  ) {
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._http = this.injector.get<HttpService>(HttpService);
    this._router = this.injector.get<Router>(Router);

    this.safeCKeys = [
      'caregiverdescribes',
      'caregiverfailstoprotect',
      'caregivermadeaplausible',
      'caregiverrefuses',
      'caregiversemotionalinstability',
      'caregiversexplanation',
      'caregiversjustification',
      'caregiverssuspected',
      'childscurrentimminent',
      'childsexualabuse',
      'childswhereabouts',
      'currentactofmaltreatment',
      'domesticviolence',
      'extremelyanxious',
      'multiplereports',
      'servicestothecaregiver',
      'specialneeds',
      'unabletoprotect',
      'servicestothecaregiver2'
    ];
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
  }
  assessmentpopupid = '#assessment-popup';
  ngOnInit() {
    this.isServiceCase = this.storage.getItem('ISSERVICECASE');
    if (this.isServiceCase) {
      this.serviceCaseId = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    } else {
      this.serviceCaseId = null;
    }
    this.getInvestigationSummary();
    this.token = this._authService.getCurrentUser();
    this.isInitialized = true;
  }

  ngAfterViewInit() {
    this._dataStoreService.currentStore.subscribe(storeData => {
      if (this.isInitialized && storeData['SUBSCRIPTION_TARGET'] === 'CASEWORKER_ASSESSMENT_LOAD') {
        this.involvedPersons = storeData['CASEWORKER_INVOLVED_PERSON'];
        this.routingInfo = storeData['CASEWORKER_ROUTING_INFO'];
        this.investigationSummary = storeData['INVESTIGATION_SUMMARY'];
        this.placement = storeData['CASEWORKER_PLACEMENT'];
        this.intakAssessment = storeData['CASEWORKER_SELECTED_ASSESSMENT'];
        this.dsdsActionsSummary = storeData['dsdsActionsSummary'];
        if (this.intakAssessment) {
          if (this.intakAssessment.mode === 'start') {
            this.startAssessment(this.intakAssessment);
          } else if (this.intakAssessment.mode === 'submit') {
            this.submittedAssessment(this.intakAssessment);
          } else if (this.intakAssessment.mode === 'update') {
            this.updateAssessment(this.intakAssessment);
          } else if (this.intakAssessment.mode === 'print') {
            this.assessmentPrintView(this.intakAssessment);
          }
        } else {
          this.redirectToAssessment();
        }
        this.isInitialized = false;
      }
    });
  }

  startAssessment(assessment: any) {
    this.assessmmentName = assessment.description;
    this.currentTemplateId = assessment.external_templateid;
    const _self = this;
    Formio.setToken(this.storage.getObj('fbToken'));
    Formio.baseUrl = environment.formBuilderHost;
    Formio.createForm(document.getElementById('assessmentForm'), environment.formBuilderHost + `/form/${assessment.external_templateid}`).then((form: any) => {
      form.components = form.components.map((item: any) => {
        if (item.key === 'Complete' && item.type === 'button') {
          item.action = 'submit';
        }
        return item;
      });
      form.submission = {
        data: this.getFormPrePopulation(this.assessmmentName, form.data)
      };
      form.on('submit', (submission: any) => {
        submission.data['child'] = _self._dataStoreService.getData('placed_child');
        let status = '';
        let comments = '';
        if (_self.token.role.name === 'apcs') {
          status = submission.data.assessmentstatus;
          comments = submission.data.supervisorcomments;
        } else if (_self.token.role.name === 'field') {
          if (submission.data.submit) {
            status = 'InProcess';
          } else {
            status = 'Submitted';
          }
          comments = submission.data.caseworkercomments;
        }
        _self._http
          .post('admin/assessment/add', this.handleAssessmentAddPayloadFn(_self, submission, status, comments))
          .subscribe(response => {
            _self._alertService.success(_self.assessmmentName + ' saved successfully.');
            _self.redirectToAssessment();
            /// (<any>$('#iframe-popup')).modal('hide');
            if (_self.assessmmentName === 'SAFE-C') {
              observableTimer(500).subscribe(() => {
                _self._router.routeReuseStrategy.shouldReuseRoute = function () {
                  return false;
                };
                _self._router.navigateByUrl(_self._router.url).then(() => {
                  _self._router.navigated = false;
                  _self._router.navigate([_self._router.url]);
                });
              });
            } else {
              this.handleIfAssessmmentNameMatchFn(_self, submission);
            }
          });
      });
      form.on('change', (formData: any) => {
        _self.safeCProcess(formData);
      });
      form.on('render', (_formData: any) => {
        /// (<any>$('#iframe-popup')).modal('show');
        setTimeout(() => {
          $(this.assessmentpopupid).scrollTop(0);
        }, 200);
      });

      this.handleFormErrorMsgAlertFn(form, _self);
    });
  }
  // Assosiated with startAssessment method
  private handleFormErrorMsgAlertFn(form: any, _self: this) {
    form.on('error', (_error: any) => {
      setTimeout(() => {
        $(this.assessmentpopupid).scrollTop(0);
      }, 200);
      _self._alertService.error('Unable to save ' + _self.assessmmentName + '. Please try again.');
    });
  }
  // Assosiated with startAssessment method
  private handleIfAssessmmentNameMatchFn(_self: this, submission: any) {
    if (_self.assessmmentName === 'BEST INTEREST DETERMINATION FOR EDUCATIONAL PLACEMENT') {
      const participantDetail: any[] = [];
      const reportedChild = _self.involvedPersons.filter(item => {
        return item.rolename === 'RC' || (item.roles.length && item.roles.filter(itm => itm.intakeservicerequestpersontypekey === 'RC').length);
      });
      let reportedChildName = '';
      if (reportedChild.length) {
        reportedChildName = reportedChild[0].lastname;
        if (reportedChild[0].firstname) {
          reportedChildName += ', ' + reportedChild[0].firstname;
        }
      }
      _self.involvedPersons.forEach(item => {
        if (item.rolename !== 'RC' && item.rolename !== 'AM') {
          participantDetail.push({
            intakeserviceid: _self.id,
            personid: item.personid,
            relationship: item.relationship,
            email: item.email,
            firstname: item.firstname,
            lastname: item.lastname,
            message: 'This is to notify you that the child ' +
              reportedChildName.toUpperCase() +
              ' is being enrolled in ' +
              submission.data.selectedcurrentschool +
              ' school based on the best interest assessment for education'
          });
        }
      });
      _self._commonHttpService.create(participantDetail, CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.Notification).subscribe();
    }
  }
  // Assosiated with startAssessment method
  private handleAssessmentAddPayloadFn(_self: this, submission: any, status: string, comments: string): any {
    return {
      externaltemplateid: _self.currentTemplateId,
      objectid: _self.id,
      submissionid: submission._id,
      submissiondata: submission.data ? submission.data : null,
      form: submission.form ? submission.form : null,
      score: submission.data.score ? submission.data.score : 0,
      ischildsafe: _self.isChildSafe,
      assessmentstatustypekey1: status ? status : null,
      servicecaseid: _self.serviceCaseId,
      comments: comments ? comments : null
    };
  }

  submittedAssessment(assessment: GetintakAssessment) {
    this.assessmmentName = assessment.titleheadertext;
    Formio.setToken(this.storage.getObj('fbToken'));
    Formio.baseUrl = environment.formBuilderHost;
    Formio.createForm(document.getElementById('assessmentForm'), environment.formBuilderHost + `/form/${assessment.external_templateid}/submission/${assessment.submissionid}`, {
      readOnly: true
    }).then((submission: any) => {
      /// (<any>$('#iframe-popup')).modal('show');
      submission.on('render', () => {
        setTimeout(() => $(this.assessmentpopupid).scrollTop(0), 200);
      });
    });
  }
  updateAssessment(assessment: GetintakAssessment) {
    this.assessmmentName = assessment.titleheadertext;
    Formio.setToken(this.storage.getObj('fbToken'));
    Formio.baseUrl = environment.formBuilderHost;
    const _self = this;
    Formio.createForm(document.getElementById('assessmentForm'), environment.formBuilderHost + `/form/${assessment.external_templateid}/submission/${assessment.submissionid}`, {
      readOnly: false
    }).then((form: any) => {
      form.components = form.components.map((items: any) => {
        if (items.key === 'Complete' && items.type === 'button') {
          items.action = 'submit';
        }
        return items;
      });
      form.submission = {
        data: _self.getFormPrePopulation(_self.assessmmentName, form.data)
      };
      /// (<any>$('#iframe-popup')).modal('show');
      form.on('render', () => {
        setTimeout(() => $(this.assessmentpopupid).scrollTop(0), 200);
      });
      form.on('submit', (submission: any) => {
        if (_self.assessmmentName === 'SAFE-C') {
          submission.data['safeCDangerInfluence'] = _self.selectedSafeCDangerInfluence;
        }
        let status = '';
        let comments = '';
        if (_self.token.role.name === 'apcs') {
          status = submission.data.assessmentstatus;
          comments = submission.data.supervisorcomments;
        } else if (_self.token.role.name === 'field') {
          if (submission.data.submit) {
            status = 'InProcess';
          } else {
            status = 'Submitted';
          }
          comments = submission.data.caseworkercomments;
        }
        _self._http
          .post('admin/assessment/add', this.handleUpdateAssessmentPayloadDataFn(_self, submission, status, comments))
          .subscribe(response => {
            _self._alertService.success(_self.assessmmentName + ' saved successfully.');
            _self.redirectToAssessment();
          });
      });
      form.on('change', (formData: any) => {
        _self.safeCProcess(formData);
      });

      this.handleFormErrorMsgAlertFn(form, _self);
    });
  }
  // Assosiated with updateAssessment method
  private handleUpdateAssessmentPayloadDataFn(_self: this, submission: any, status: string, comments: string): any {
    return {
      externaltemplateid: _self.currentTemplateId,
      objectid: _self.id,
      submissionid: submission._id,
      submissiondata: submission.data ? submission.data : null,
      form: submission.form ? submission.form : null,
      score: submission.data.score ? submission.data.score : 0,
      assessmentstatustypekey1: status ? status : null,
      servicecaseid: _self.serviceCaseId,
      comments: comments ? comments : null
    };
  }

  assessmentPrintView(assessment: GetintakAssessment) {
    const _self = this;
    Formio.setToken(this.storage.getObj('fbToken'));
    Formio.baseUrl = environment.formBuilderHost;
    Formio.createForm(document.getElementById('assessmentForm'), environment.formBuilderHost + `/form/${assessment.external_templateid}/submission/${assessment.submissionid}`, {
      readOnly: true
    }).then(function (submission: any) {
      const options = {
        ignoreLayout: true
      };
      _self.viewHtml(submission._form, submission._submission, options);
    });
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
    });
  }

  private createIframe(el: any) {
    _.forEach(el.getElementsByTagName('iframe'), _iframe => {
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

  private getFormPrePopulation(formName: string, submissionData: any) {
    return submissionData;
  }

  private safeCProcess($event: any) {
    if (this.assessmmentName !== 'SAFE-C') {
      this.selectedSafeCDangerInfluence = [];
      return;
    }
    if ($event.changed) {
      const dangerInfluence = $event.changed.component.key;
      if (dangerInfluence === 'safetydecision4') {
        this.isChildSafe = !$event.data[$event.changed.component.key];
      }
      this.handleDangerInfluenceKeyCondFn(dangerInfluence, $event);
    }
  }
  // Assosiated with safeCProcess method
  private handleDangerInfluenceKeyCondFn(dangerInfluenceKey: any, $event: any) {
    if (dangerInfluenceKey && this.safeCKeys.indexOf(dangerInfluenceKey) > -1) {
      const dangerInflunceItem = this.selectedSafeCDangerInfluence.find(item => item.value === dangerInfluenceKey);
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
  }

  private getInvestigationSummary() {
    this._commonHttpService
      .getSingle(
        {
          intakeserviceid: this.id,
          method: 'post'
        },
        'Investigations/getinvestigationsummary'
      )
      .subscribe(data => {
        if (data.length) {
          this.investigationSummary = data[0];
          if (this.investigationSummary.general && this.investigationSummary.general.length) {
            this.generalSummary = this.investigationSummary.general[0];
          }
          if (this.investigationSummary.assessmentcontactnotes && this.investigationSummary.assessmentcontactnotes.length) {
            this.assessmentSummary = this.investigationSummary.assessmentcontactnotes[0];
          }
        }
      });
  }

  redirectToAssessment() {
    this.isInitialized = false;
    if (this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)) {
      this._router.navigate(['/pages/cjams-dashboard/cw-assessment']);
    } else {
      this._router.navigate(['../list'], { relativeTo: this.route });
    }
  }
}
