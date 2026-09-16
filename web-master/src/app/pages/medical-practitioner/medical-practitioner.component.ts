
import {map, pluck} from 'rxjs/operators';
import { Component, OnInit, Injector } from '@angular/core';
import { HttpService } from '../../@core/services/http.service';
import { DomSanitizer } from '@angular/platform-browser';
import { AlertService, SessionStorageService, CommonHttpService, AuthService } from '../../@core/services';
import { PaginationRequest, PaginationInfo } from '../../@core/entities/common.entities';
import { Observable ,  forkJoin ,  Subject } from 'rxjs';
import { AppConfig } from '../../app.config';
import { environment } from '../../../environments/environment.dev';
import { FileError, NgxfUploaderService } from 'ngxf-uploader';
import { HttpHeaders } from '@angular/common/http';
import { AppUser } from '../../@core/entities/authDataModel';
import { GLOBAL_MESSAGES } from '../../@core/entities/constants';
import { GetintakAssessment } from '../case-worker/_entities/caseworker.data.model';
import moment from 'moment';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import FormioExport from 'formio-export';
import _ from 'lodash';
import { CaseWorkerUrlConfig } from '../case-worker/case-worker-url.config';
import { Placement } from '../case-worker/dsds-action/placement/_entities/placement.model';

declare let $: any;
declare let Formio: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'medical-practitioner',
    templateUrl: './medical-practitioner.component.html',
    styleUrls: ['./medical-practitioner.component.scss'],
    standalone: false
})
export class MedicalPractitionerComponent implements OnInit {
  showUpload = false;
  toSave = false;
  id: any;
  attachmentTypeForm: FormGroup;
  startAssessment$: Observable<any[]>;
  totalRecord$: Observable<number>;
  paginationInfo: PaginationInfo = new PaginationInfo();
  showAssesment = -1;
  getAsseesmentHistory: GetintakAssessment[] = [];
  assessmmentName: any;
  currentTemplateId: any;
  attachmentType: string;
  placement: Placement;
  selectedSafeCDangerInfluence: any[] = [];
  medicalDashboard$: Observable<any[]>;
  uploadedFile = [];
  currentUser: AppUser;
  fileToSave = [];
  attachmentResponse: any;
  daNumber: any;
  intakeserviceid: any;
  personId: any;
  selectedAssessment: any;
  selectedStatus = '';
  intakeSummary: any;
  involvedPersons: any;
  private pageStream$ = new Subject<number>();
  assToCopy: any;
  intakeNumber = '';
  providerapplicant = 'Provider Applicant';
  addassessmenturl = 'admin/assessment/Add';
  savesuccessmsg = ' saved successfully.';
  iframepopupid = '#iframe-popup';
  assessmentpopupid = '#assessment-popup';
  dtformat = 'YYYY-MM-DD';
  private _authService: AuthService;
  private _commonService: CommonHttpService;
  private storage: SessionStorageService;
  private _alertService: AlertService;
  public sanitizer: DomSanitizer;
  private _formbuilder: FormBuilder;
  private _http: HttpService;
  private _uploadService: NgxfUploaderService;
  constructor(private injector: Injector) {
    this._authService = this.injector.get<AuthService>(AuthService);
    this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this.sanitizer = this.injector.get<DomSanitizer>(DomSanitizer);
    this._formbuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._http = this.injector.get<HttpService>(HttpService);
    this._uploadService = this.injector.get<NgxfUploaderService>(NgxfUploaderService);
    this.currentUser = this._authService.getCurrentUser();
    this.daNumber = '201800411047';
  }

  ngOnInit() {
    this.intializeForm();
    this.pageStream$.subscribe((data) => {
      this.paginationInfo.pageNumber = data;
      this.getPage(this.selectedStatus, data);
    });
    this.getPage('Pending', 1);
  }

  intializeForm() {
    this.attachmentTypeForm = this._formbuilder.group({
      assessmentsubmissiontypekey: [null, Validators.required]
    });
  }

  toggleUpload(event) {
    if (event === '1') {
      this.showUpload = true;
    } else {
      this.showUpload = false;
    }
  }

  getReSult(result) {
    const list = result.data.map(item => {
      item.isNew = this.toShowPlay(item);
      return item;
    });
     
    return {
      data: list, count: result.data.length ? result.data[0].totalcount : ''
    };
  }

  getPage(status, page: number) {
    this.showAssesment = -1;
    this.selectedStatus = status;
    if (this.currentUser.role.name === this.providerapplicant) {
      const source = this._commonService
      .getArrayList(
        new PaginationRequest({
          limit: this.paginationInfo.pageSize,
          page: this.paginationInfo.pageNumber,
          where: {
            status: status
          },
          method: 'get'
        }),
        'Assignedassessments/getproviderassessmentdashboard?filter'
      ).pipe(
      map((result: any) => this.getReSult(result)));

      this.medicalDashboard$ = source.pipe(pluck('data'));
      if (page === 1) {
        this.totalRecord$ = source.pipe(pluck('count'));
      }
    } else {
      const source = this._commonService
      .getArrayList(
        new PaginationRequest({
          limit: this.paginationInfo.pageSize,
          page: this.paginationInfo.pageNumber,
          where: {
            status: status
          },
          method: 'get'
        }),
        'Assignedassessments/getassessmentdashboard?filter'
      ).pipe(
      map((result: any) => this.getReSult(result)));

      this.medicalDashboard$ = source.pipe(pluck('data'));
      if (page === 1) {
        this.totalRecord$ = source.pipe(pluck('count'));
      }
    }

  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.pageSize = pageInfo.itemsPerPage;
    this.pageStream$.next(this.paginationInfo.pageNumber);
  }

  onError() {
    setTimeout(function () {
      $(this.assessmentpopupid).scrollTop(0);
    }, 200);
    this._alertService.error('Unable to save ' + this.assessmmentName + '. Please try again.');
  }

  startAssessment(assessment) {
    this.selectedAssessment = assessment;
    this.getIntakeSummary();
    this.assessmmentName = assessment.titleheadertext;
    this.currentTemplateId = assessment.external_templateid;
    this.intakeserviceid = assessment.intakeserviceid;
    this.intakeNumber = assessment.intakenumber;
    const _self = this;
    Formio.setToken(this.storage.getObj('fbToken'));
    Formio.baseUrl = environment.formBuilderHost;
    Formio.createForm(document.getElementById('assessmentForm'), environment.formBuilderHost + `/form/${assessment.external_templateid}`).then((form) => {
      // Formio.createForm(document.getElementById('assessmentForm'), environment.formBuilderHost + `/form/5bbd15292229906dcc0e14b1`).then(function (form) {
      form.components = form.components.map((item) => {
        return this.formcomponentMapFn(item);
      });
      form.submission = {
        data: _self.getFormPrePopulation(_self.assessmmentName, form.data, assessment.displayname, assessment.dob)
      };
      form.on('submit', (submission) => {
        if (_self.assessmmentName === 'SAFE-C') {
          submission.data['safeCDangerInfluence'] = _self.selectedSafeCDangerInfluence;
        }
        const status = 'InProcess';

        this.providerApplicantCheckFn(_self, status, submission);
      });
      form.on('render', (formData) => {
        $(this.iframepopupid).modal('show'); 
        setTimeout(function () {
          $(this.assessmentpopupid).scrollTop(0);
        }, 200);
      });

      form.on('error', (error) => this.onError());
    });
  }

  private providerApplicantCheckFn(_self: this, status: string, submission: any) {
    if (_self.currentUser.role.name === this.providerapplicant) {
      _self._http
        .post(this.addassessmenturl, {
          externaltemplateid: _self.currentTemplateId,
          assessmentstatustypekey1: status,
          objectid: this.returnObjectidFn(_self),
          submissionid: submission._id,
          submissiondata: this.returnSubmissionDataFn(submission),
          form: submission.form ? submission.form : null,
          score: submission.data.score ? submission.data.score : 0
        })
        .subscribe(() => {
          this.addAssessmentApiResponseFn(_self);
        });
    } else {
      _self._http
        .post(this.addassessmenturl, {
          externaltemplateid: _self.currentTemplateId,
          assessmentstatustypekey1: status,
          objectid: _self.intakeserviceid,
          submissionid: submission._id,
          submissiondata: this.returnSubmissionDataFn(submission),
          form: submission.form ? submission.form : null,
          score: submission.data.score ? submission.data.score : 0
        })
        .subscribe(() => {
          this.addAssessmentApiResponseFn(_self);
        });
    }
  }

  private returnObjectidFn(_self: this) {
    return _self.intakeNumber ? _self.intakeNumber : _self.intakeserviceid;
  }

  private returnSubmissionDataFn(submission: any) {
    return submission.data ? submission.data : null;
  }

  private addAssessmentApiResponseFn(_self: this) {
    _self._alertService.success(_self.assessmmentName + this.savesuccessmsg);
    _self.getPage('Pending', 1);
    $(this.iframepopupid).modal('hide');
  }

  private getFormPrePopulation(formName: string, submissionData: any, name: string, dob: string) {
    let assToCopy = {};
    if (formName === 'C.A.R.E. Home - Provider Back-up Medical Form') {
      this.ifAddressDetailsCkeckFn(submissionData);
    }
    if (this.selectedAssessment && this.selectedAssessment.intakeassessment && this.selectedAssessment.intakeassessment.length > 0) {
      assToCopy = this.selectedAssessment.intakeassessment[0].submissiondata;
      submissionData = assToCopy;
    } else {
      
      submissionData['ResidentsName'] = this.returnResidentsNameFn(submissionData);
      submissionData['date'] = moment(new Date()).format(this.dtformat);
      submissionData['mainDate'] = moment(new Date()).format(this.dtformat);
      submissionData['ResidentsDOB'] = moment(this.selectedAssessment.dob).format(this.dtformat);
      if (this.reportedAdultDetails && this.reportedAdultDetails.length > 0) {
        submissionData['PhoneNumber'] = this.returnPhoneNumberFn();
        submissionData['panel5000110429470297Columns2PhoneNumber'] = this.returnPhoneNumberFn();
      }
      submissionData['Resident'] = this.returnResidentFn(submissionData);
      if (this.intakeSummary && this.intakeSummary.providername) {
        let providerName = '';
        this.intakeSummary.providername.forEach(element => {
          providerName += element.providername + ', ';
        });

        submissionData['CareProvider'] = providerName;
        submissionData['CAREProvider'] = providerName;
        submissionData['DateCompleted'] = moment(new Date()).format(this.dtformat);
        submissionData['RESIDENTSNAME'] = this.returnResidentsNameFn(submissionData);
        submissionData['ResidentsDOB1'] = moment(this.selectedAssessment.dob).format(this.dtformat);
        submissionData['NurseConsDate'] = moment(new Date()).format(this.dtformat);
        submissionData['NextReviewDate'] = moment(new Date()).format(this.dtformat);
      }
      submissionData['RegisteredNurseConsultant'] = this.returnRegisteredNurseConsultantFn(submissionData);
      submissionData['NurseConsultant'] = this.returnNurseConsultantFn(submissionData);
      if (this.reportedAdultDetails && this.reportedAdultDetails.length > 0 && this.reportedAdultDetails[0].medicationinformation) {
        this.ifMedicationinformationCheckFn(submissionData);
      }
      submissionData['applicantname'] = this.returnApplicantnameFn(name, submissionData);
      submissionData['Date'] = moment(new Date()).format(this.dtformat);
      submissionData['NextDate'] = moment(new Date()).format(this.dtformat);
      submissionData['DateCompleted'] = moment(new Date()).format(this.dtformat);
      submissionData['applicantdob'] = this.returnApplicantdobFn(dob, submissionData);
    }
    return submissionData;
  }

  private ifAddressDetailsCkeckFn(submissionData: any) {
    if (this.selectedAssessment.address && this.selectedAssessment.countyname && this.selectedAssessment.zipcode) {
      submissionData['countyDetailsText'] = this.selectedAssessment.countyname + ', ' + this.selectedAssessment.address + ', ' + this.selectedAssessment.zipcode;
    }
  }

  private returnApplicantdobFn(dob: string, submissionData: any): any {
    return (dob) ? moment(new Date(dob)).format(this.dtformat) : submissionData['applicantdob'];
  }

  private returnApplicantnameFn(name: string, submissionData: any): any {
    return (name) ? name : submissionData['applicantname'];
  }

  private ifMedicationinformationCheckFn(submissionData: any) {
    submissionData['panel06311922059450592Columns2DataGrid'] = [];
    this.reportedAdultDetails[0].medicationinformation.forEach((data) => {
      submissionData['panel06311922059450592Columns2DataGrid'].push({
        TreatmentsWithDirections: data.medicationname + ', ' + data.frequency + ', ' + data.dosage,
        ReasonforMedicationorTreatment: data.prescriptionreason,
        RelatedTestingorMonitoring: data.monitoring
      });
    });
    submissionData['subPanel2DataGrid'] = [];
    this.reportedAdultDetails[0].medicationinformation.forEach((data) => {
      submissionData['subPanel2DataGrid'].push({
        Medicationname: data.medicationname,
        Dosage: data.dosage,
        Frequency: data.frequency,
        Prescriptionreason: data.prescriptionreason
      });
    });
  }

  private returnNurseConsultantFn(submissionData: any): any {
    return this.currentUser.user.userprofile.displayname ? this.currentUser.user.userprofile.displayname : submissionData['NurseConsultant'];
  }

  private returnRegisteredNurseConsultantFn(submissionData: any): any {
    return this.currentUser.user.userprofile.displayname ? this.currentUser.user.userprofile.displayname : submissionData['RegisteredNurseConsultant'];
  }

  private returnResidentsNameFn(submissionData: any): any {
    return this.selectedAssessment ? this.selectedAssessment.displayname : submissionData['RESIDENTSNAME'];
  }

  private returnResidentFn(submissionData: any): any {
    return this.selectedAssessment ? this.selectedAssessment.displayname : submissionData['Resident'];
  }

  private returnPhoneNumberFn(): any {
    return this.reportedAdultDetails[0].phonenumber ? this.reportedAdultDetails[0].phonenumber : '';
  }

  get reportedAdultDetails() {
    if (this.involvedPersons) {
      return this.involvedPersons.filter(item => {
        return item.rolename === 'RA' || (item.roles.length && item.roles.filter(itm => itm.intakeservicerequestpersontypekey === 'RA').length);
      });
    } else {
      return null;
    }
  }

  private setPhysicalAttr(personHeight, personWeight) {
    this._commonService
      .getSingle(
        {
          personId: this.selectedAssessment.personid,
          height: personHeight,
          weight: personWeight,
          method: 'post'
        },
        'People/updatepersonphysicalattribute'
      ).subscribe();
  }
  getIntakeSummary() {
    forkJoin([
      this._commonService.getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          where: { intakeservreqid: this.selectedAssessment.intakeserviceid }
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
      ),
      this._commonService.getPagedArrayList(
        {
          where: {
            intakeserviceid: this.id
          },
          page: 1,
          limit: 50,
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.PlacementListUrl + '?filter'
      ),
      this._commonService
        .getSingle(
          {
            intakeserviceid: this.selectedAssessment.intakeserviceid,
            method: 'post'
          },
          'Investigations/getinvestigationsummary'
        )]).subscribe((data) => {
          this.involvedPersons = data[0]['data'];
          this.placement = data[1]['data'][0];
          this.intakeSummary = data[2][0];
        });
  }

  showAssessment(id: number, row) {
    this.getAsseesmentHistory = row;
    if (this.showAssesment !== id) {
      this.showAssesment = id;
    } else {
      this.showAssesment = -1;
    }
  }


  // file upload functions
  uploadFile(file: File | FileError): void {
    if (!(file instanceof Array)) {
      return;
    }
    file.map((item, index) => {
      const fileExt = item.name
        .toLowerCase()
        .split('.')
        .pop();
      if (
        fileExt === 'mp3' ||
        fileExt === 'ogg' ||
        fileExt === 'wav' ||
        fileExt === 'acc' ||
        fileExt === 'flac' ||
        fileExt === 'aiff' ||
        fileExt === 'mp4' ||
        fileExt === 'mov' ||
        fileExt === 'avi' ||
        fileExt === '3gp' ||
        fileExt === 'wmv' ||
        fileExt === 'mpeg-4' ||
        fileExt === 'pdf' ||
        fileExt === 'txt' ||
        fileExt === 'docx' ||
        fileExt === 'doc' ||
        fileExt === 'xls' ||
        fileExt === 'xlsx' ||
        fileExt === 'jpeg' ||
        fileExt === 'jpg' ||
        fileExt === 'png' ||
        fileExt === 'ppt' ||
        fileExt === 'pptx' ||
        fileExt === 'gif' ||
         fileExt === 'cr2' ||
         fileExt === 'rtf'
      ) {
        this.uploadedFile.push(item);
        this.uploadAttachment(index);
      } else {
        // tslint:disable-next-line:quotemark
        this._alertService.error(fileExt + " format can't be uploaded");
      }
    });
  }

  uploadAttachment(index) {
    let uploadURL = '';
    
      uploadURL = AppConfig.baseUrl +
        'attachments/uploadsFile' + '?srno=' + this.daNumber;
    
    this._uploadService
      .upload({
        url: uploadURL,
        headers: new HttpHeaders().set('ctype', 'file'),
        filesKey: ['file'],
        files: this.uploadedFile[index],
        process: true
      })
      .subscribe(
        (response) => {
          if (response.status) {
            this.uploadedFile[index].percentage = response.percent;
          }
          if (response.status === 1 && response.data) {
            this.attachmentResponse = response.data;
            this.fileToSave.push(response.data);
            this.fileToSave[this.fileToSave.length - 1].documentattachment = {
              attachmenttypekey: '',
              attachmentclassificationtypekey: '',
              attachmentdate: new Date(),
              sourceauthor: '',
              attachmentsubject: '',
              sourceposition: '',
              attachmentpurpose: '',
              sourcephonenumber: '',
              acquisitionmethod: '',
              sourceaddress: '',
              locationoforiginal: '',
              insertedby: this.currentUser.user.userprofile.displayname,
              note: '',
              updatedby: this.currentUser.user.userprofile.displayname,
              activeflag: 1
            };
            this.fileToSave[this.fileToSave.length - 1].description = '';
            this.fileToSave[this.fileToSave.length - 1].documentdate = new Date();
            this.fileToSave[this.fileToSave.length - 1].title = '';
            this.fileToSave[this.fileToSave.length - 1].daNumber = this.daNumber;
            this.fileToSave[this.fileToSave.length - 1].objecttypekey = 'ServiceRequest';
            this.fileToSave[this.fileToSave.length - 1].rootobjecttypekey = 'ServiceRequest';
            this.fileToSave[this.fileToSave.length - 1].activeflag = 1;
            this.fileToSave[this.fileToSave.length - 1].daNumber = this.daNumber;
            this.fileToSave[this.fileToSave.length - 1].insertedby = this.currentUser.user.userprofile.displayname;
            this.fileToSave[this.fileToSave.length - 1].updatedby = this.currentUser.user.userprofile.displayname;
            this.fileToSave[this.fileToSave.length - 1].securityusersid = this.currentUser.user.userprofile.securityusersid;
          }
        },
        (err) => {
          console.error(err);
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
          this.uploadedFile.splice(index, 1);
        }
      );
  }

  submitAttachmentType() {
    let data = {};
    if (this.attachmentTypeForm.valid) {
      data = {
        'assessmenttemplateid': this.selectedAssessment.assessmenttemplateid,
        'securityusersid': this.currentUser.user.securityusersid,
        'assessmentsubmissiontypekey': this.attachmentTypeForm.value.assessmentsubmissiontypekey,
        'objectid': this.selectedAssessment.intakeserviceid,
        'submissionid': null,
        'assessmentname': this.selectedAssessment.titleheadertext
      };
      this.saveTypeAssessment(data);
      $('#type-select').modal('hide');
      this.attachmentTypeForm.reset();
    } else {
      this._alertService.error('Please select type');
    }
  }

  completeAssessment(assessment) {
    let data = {};
    if (this.currentUser.role.name === this.providerapplicant) {
      if (!assessment.isNew) {
      data = {
        'assessmenttemplateid': assessment.assessmenttemplateid,
        'securityusersid': assessment.securityusersid,
        'intakenumber': assessment.intakenumber,
        'objectid': assessment.intakeserviceid,
        'submissionid': assessment.intakeassessment[0].submissionid
      };
      const url = 'Assignedassessments/assessmentcompletedbyproviderapplicant';
      this._commonService.create(data, url).subscribe(result => {
        this._alertService.success('Completed Successfully');
        this.getPage('Pending', this.paginationInfo.pageNumber);
      });
    } else {
      this._alertService.warn('Please Save or Complete the assessment');
    }
    } else {
    if (assessment) {
      this.selectedAssessment = assessment;
      if (!assessment.isNew) {
        data = {
          'assessmenttemplateid': assessment.assessmenttemplateid,
          'securityusersid': this.currentUser.user.securityusersid,
          'objectid': assessment.intakeserviceid,
          'submissionid': assessment.intakeassessment[0].submissionid,
          'assessmentname': assessment.titleheadertext
        };
        this.saveTypeAssessment(data);
      } else {
        $('#type-select').modal('show'); 
        }
      }
    }
  }

  calculateDueDate(givenDate) {
    const date = new Date(givenDate);
    date.setDate(date.getDate() + 10);
    return date;
  }

  saveTypeAssessment(data) {
    const url = 'Assignedassessments/assessmentcompleted';
    this._commonService.create(data, url).subscribe(result => {
      
      this.getPage('Pending', this.paginationInfo.pageNumber);
    });
  }

  assessmentPrintView(assessment: GetintakAssessment, needData) {
    const _self = this;
    Formio.setToken(this.storage.getObj('fbToken'));
    Formio.baseUrl = environment.formBuilderHost;
    let url = '';
    if (needData) {
      url = environment.formBuilderHost + `/form/${assessment.external_templateid}/submission/${assessment.submissionid}`;
    } else {
      url = environment.formBuilderHost + `/form/${assessment.external_templateid}`;
    }
    Formio.createForm(document.getElementById('assessmentForm'), url, {
      readOnly: true
    }).then(function (submission) {
      const options = {
        ignoreLayout: true
      };
      _self.viewHtml(submission._form, submission._submission, options);
    });
  }

  viewHtml(componentData, submissionData, formioOptions) {
    delete submissionData._id;
    delete submissionData.owner;
    delete submissionData.modified;
    const exporter = new FormioExport(componentData, submissionData, formioOptions);
    const appDiv = document.getElementById('assPrintView');
    exporter.toHtml().then((html) => {
      html.style.margin = 'auto';
      const iframe = this.createIframe(appDiv);
      const doc = iframe.contentDocument || iframe.contentWindow.document;
      doc.body.appendChild(html);
      window.frames['ifAssessmentView'].focus();
      window.frames['ifAssessmentView'].print();
    });
  }

  private createIframe(el) {
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

  submittedAssessment(assessment: GetintakAssessment, readOnly) {
    this.assessmmentName = assessment.titleheadertext;
    Formio.setToken(this.storage.getObj('fbToken'));
    Formio.baseUrl = environment.formBuilderHost;
    let url = '';
    if (readOnly) {
      url = environment.formBuilderHost + `/form/${assessment.external_templateid}/submission/${assessment.submissionid}`;
    } else {
      url = environment.formBuilderHost + `/form/${assessment.external_templateid}`;
    }
    Formio.createForm(document.getElementById('assessmentForm'), url, {
      readOnly: true
    }).then(function (submission) {
      $(this.iframepopupid).modal('show'); 
      submission.on('render', () => {
        this.assessmentpopupScroll();
      });
    });
  }

  updateAssessment(comepleteAssessment, assessment) {
    this.selectedAssessment = comepleteAssessment;
    this.getIntakeSummary();
    this.assessmmentName = assessment.titleheadertext;
    this.intakeNumber = assessment.intakenumber;
    Formio.setToken(this.storage.getObj('fbToken'));
    Formio.baseUrl = environment.formBuilderHost;
    const _self = this;
    Formio.createForm(document.getElementById('assessmentForm'), environment.formBuilderHost + `/form/${assessment.external_templateid}/submission/${assessment.submissionid}`, {
      readOnly: false
    }).then((form) => {
      form.components = form.components.map(item => {
        return this.formcomponentMapFn(item);
      });
      form.submission = {
        data: _self.getFormPrePopulation(_self.assessmmentName, form.data, assessment.displayname, assessment.dob)
      };
      $(this.iframepopupid).modal('show');
      form.on('render', formData => {
        this.assessmentpopupScroll();
      });
      form.on('submit', submission => {
        if (_self.assessmmentName === 'SAFE-C') {
          submission.data['safeCDangerInfluence'] = _self.selectedSafeCDangerInfluence;
          const height = submission.data['Height'] ? submission.data['Height'] : '';
          const weight = submission.data['Weight'] ? submission.data['Weight'] : '';
          _self.setPhysicalAttr(height, weight);
        }
        const status = 'InProcess';
        this.updateProviderApplicantCheckFn(_self, submission, status);
      });

      form.on('error', error => this.onError());
    });
  }

  assessmentpopupScroll() {
    setTimeout(function () {
      $(this.assessmentpopupid).scrollTop(0);
    }, 200);
  }

  private formcomponentMapFn(item: any) {
    if (item.key === 'Complete' && item.type === 'button') {
      item.action = 'submit';
    }
    return item;
  }

  private updateProviderApplicantCheckFn(_self: this, submission: any, status: string) {
    if (_self.currentUser.role.name === this.providerapplicant) {
      _self._http
        .post(this.addassessmenturl, {
          externaltemplateid: _self.currentTemplateId,
          objectid: _self.intakeNumber,
          submissionid: submission._id,
          submissiondata: submission.data ? submission.data : null,
          form: submission.form ? submission.form : null,
          score: submission.data.score ? submission.data.score : 0,
          // assessmentstatustypekey1: status,
          // comments: comments
          assessmentstatustypekey1: status,
        })
        .subscribe(() => {
          this.updateProviderapplicantResponseFn(_self);
        });
    } else {
      _self._http
        .post(this.addassessmenturl, {
          externaltemplateid: _self.currentTemplateId,
          objectid: _self.intakeserviceid,
          submissionid: submission._id,
          submissiondata: submission.data ? submission.data : null,
          form: submission.form ? submission.form : null,
          score: submission.data.score ? submission.data.score : 0,
          // assessmentstatustypekey1: status,
          // comments: comments
          assessmentstatustypekey1: status,
        })
        .subscribe(() => {
          this.updateProviderapplicantResponseFn(_self);
        });
    }
  }

  private updateProviderapplicantResponseFn(_self: this) {
    _self._alertService.success(_self.assessmmentName + this.savesuccessmsg);
    _self.getPage('Pending', 1);
    _self.showAssessment(_self.showAssesment, _self.getAsseesmentHistory);
    $(this.iframepopupid).modal('hide'); 
  }

  toShowPlay(assessment) {
    if (assessment.intakeassessment && assessment.intakeassessment.length) {
      const history = assessment.intakeassessment;
      const draft = history.find(item => item.assessmentstatustypekey === 'InProcess' || item.assessmentstatustypekey === 'Review');
      if (draft) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }

  }

}
