import { Component, Injector, OnInit } from '@angular/core';
import { NytdSurveyService } from './nytd-survey.service';
import { FormGroup, FormBuilder, FormArray } from '@angular/forms';
import { AlertService, AuthService } from '../../../@core/services';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { PersonInfoService } from '../person-info/person-info.service';
import moment from 'moment';
import { ActivatedRoute } from '@angular/router';
import jsPDF from 'jspdf';
import { ElementSchemaRegistry } from '@angular/compiler';
import { Html2CanvasService } from '../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';

@Component({
    selector: 'nytd-survey',
    templateUrl: './nytd-survey.component.html',
    styleUrls: ['./nytd-survey.component.scss'],
    standalone: false
})

export class NytdSurveyComponent implements OnInit {
  loggedInUser: any;
  personInfo:any;
  personid: any[] = [];
  selectedReport: any;
  response: any[] = [];
  dataElements: any[] = [];
  elementValues: any[] = [];
  detailDataElements: any[] = [];
  servedDataElements: any[] = [];
  surveyDataElements: any[] = [];
  surveyQ1to5DataElements: any[] = [];
  surveyQ6to12DataElements: any[] = [];
  surveyQ13DataElements: any[] = [];
  surveyQ14DataElements: any[] = [];
  surveyQ15DataElements: any[] = [];
  surveyQ16DataElements: any[] = [];
  surveyQ17DataElements: any[] = [];
  surveyQ18to20DataElements: any[] = [];
  setNullQ18to20: boolean=false;
  surveyQsAccess: boolean = true;
  mandatoryResponses: boolean = false;
  negativeResponses: boolean = false;
  clientIneligible: boolean = false;
  editMode: boolean = false;
  showSurveyPage: boolean = false;
  surveyStatus: any[] = [];
  reportTypes: any[] = [];
  afcarsRef: any[] = [];
  NytdSurveyFormGroup!: FormGroup;
  NytdSurveyQ1to5FormGroup!: FormGroup;
  NytdSurveyQ6to12FormGroup!: FormGroup;
  NytdSurveyQ13FormGroup!: FormGroup;
  NytdSurveyQ14FormGroup!: FormGroup;
  NytdSurveyQ15FormGroup!: FormGroup;
  NytdSurveyQ16FormGroup!: FormGroup;
  NytdSurveyQ17FormGroup!: FormGroup;
  NytdSurveyQ18to20FormGroup!: FormGroup;

  pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];

  mandatoryResponsesMsg: string = 'All Survey reponses are mandatory!';
  negativeResponsesMsg: string = 'All Survey reponses cannot be No, Declined or Not Applicable!';
  clientIneligibleMsg: string = 'This Client cannot be included in NYTD Report. NYTD timeframe has expired or the Client is no longer NYTD eligible.';

  totalRecords: any;
  paginationInfo: PaginationInfo = new PaginationInfo();
  sortData: any;

  summary: any[] = [];
  userNames: any;
  notapplicable = 'not applicable';
  q13q14validationpopupid = '#q13-q14-validation';
  private route: ActivatedRoute;
  private _formBuilder: FormBuilder;
  private _alertService: AlertService;
  private html2canvas:Html2CanvasService;
  constructor (
    private _authService: AuthService,
    private _NytdSurveyService: NytdSurveyService,
    public _personService: PersonInfoService,
    private readonly injector : Injector
  ) {
    this.html2canvas = this.injector.get<Html2CanvasService>(Html2CanvasService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this.route.data.subscribe(data => {
      if(data && data.config) {
        //Report type description to populate on summary grid
        this.reportTypes = data.config.reportTypes;
        //Survey - element 34 drop-down statuses
        this.surveyStatus = data.config.surveyStatuses;
        //Data elements
        this.dataElements = data.config.dataElements;
        //Summary grid data
        this.summary = data.config.summary;
        //User names for summary grid
        this.userNames = data.config.userNames;
      }
    });
   }

  ngOnInit() {
    this.initForm();
    this.loggedInUser = this._authService.getCurrentUser().user.userprofile.displayname;
    this.personid = (this._personService.getPersonId()) ? this._personService.getPersonId() : '';
    this.personInfo = this._personService.getPersonInfo();
    
    const clientAge = moment().diff(moment(new Date(this.personInfo.personbasicdetails.dob)), 'years');
    this.showSurveyPage = clientAge >= 17 ? true : false;

    //sort summary grid data 
    this.getSortedSummary(false);
  }

  getSortedSummary(isSaveVerify: boolean) {
    this.summary = this.summary.filter((s:any) => s.activeflag === 1);
    this.summary.sort((a:any,b:any) => a.insertedon >= b.insertedon ? -1 : 1 );
    //filter tab-level data elements
    if (isSaveVerify) {
      const currId = this.selectedReport.summaryid;
      const currentSelected = this.summary.find((s:any) => s.summaryid = currId);
      this.selectedReport = currentSelected;
    } else {
      this.getDataElements();
    }
  }

  getDataElements() {
    this.dataElements.forEach((e:any) => {
      e.old_id = Number(e.old_id)
    });
    this.detailDataElements = this.dataElements.filter((e:any) => e.old_id > 0 && e.old_id < 14);
    this.servedDataElements = this.dataElements.filter((e:any) => e.old_id >= 14 && e.old_id < 34);
    this.surveyDataElements = this.dataElements.filter((e:any) => e.old_id >= 34 && e.old_id < 37);

    this.surveyQ1to5DataElements = this.dataElements.filter((e:any) => e.old_id >= 37 && e.old_id < 42);
    this.surveyQ6to12DataElements = this.dataElements.filter((e:any) => e.old_id >= 45 && e.old_id < 52);
    this.surveyQ13DataElements = this.dataElements.filter((e:any) => e.old_id == 52);
    this.surveyQ14DataElements = this.dataElements.filter((e:any) => e.old_id == 53);
    this.surveyQ15DataElements = this.dataElements.filter((e:any) => e.old_id == 54);
    this.surveyQ16DataElements = this.dataElements.filter((e:any)=> e.old_id == 55);
    this.surveyQ17DataElements = this.dataElements.filter((e:any) => e.old_id >= 56);
    this.surveyQ18to20DataElements = this.dataElements.filter((e:any) => e.old_id >= 42 && e.old_id < 45);

    //auto-select latest record on first load
    if (this.summary.length && this.summary.length > 0) {
      this.selectReport(this.summary[0], true);
    }
  }

  initForm() {
    this.initSurveyForm();
    this.initSurveyQsForm();
  }

  initSurveyForm() {
    this.NytdSurveyFormGroup = this._formBuilder.group({
      elements: this._formBuilder.array([])
    });
  }

  initSurveyQsForm() {
    this.NytdSurveyQ1to5FormGroup = this._formBuilder.group({
      elements: this._formBuilder.array([])
    });
    this.NytdSurveyQ6to12FormGroup = this._formBuilder.group({
      elements: this._formBuilder.array([])
    });
    this.NytdSurveyQ13FormGroup = this._formBuilder.group({
      elements: this._formBuilder.array([])
    });
    this.NytdSurveyQ14FormGroup = this._formBuilder.group({
      elements: this._formBuilder.array([])
    });
    
    this.NytdSurveyQ15FormGroup = this._formBuilder.group({
      elements: this._formBuilder.array([])
    });
    this.NytdSurveyQ16FormGroup = this._formBuilder.group({
      elements: this._formBuilder.array([])
    });
    this.NytdSurveyQ17FormGroup = this._formBuilder.group({
      elements: this._formBuilder.array([])
    });
    this.NytdSurveyQ18to20FormGroup = this._formBuilder.group({
      elements: this._formBuilder.array([])
    });
  }
get element14(){
  return this.NytdSurveyQ14FormGroup.get('elements') as any;
}
get element13(){
  return this.NytdSurveyQ13FormGroup.get('elements') as any;
}
get element6to12(){
  return this.NytdSurveyQ6to12FormGroup.get('elements') as any;
}
get element1to5(){
  return this.NytdSurveyQ1to5FormGroup.get('elements') as any;
}
get element(){
  return this.NytdSurveyFormGroup.get('elements') as any;
}
get element15(){
  return this.NytdSurveyQ15FormGroup.get('elements') as any;
}
get element16(){
  return this.NytdSurveyQ16FormGroup.get('elements') as any;
}
get element17(){
  return this.NytdSurveyQ17FormGroup.get('elements') as any;
}
get element18to20(){
  return this.NytdSurveyQ18to20FormGroup.get('elements') as any;
}



  initSurveyElements() {
    const control = <FormArray>this.NytdSurveyFormGroup.controls.elements;

    while(control.length > 0) {
      control.removeAt(0);
    }
    
    this.surveyDataElements.forEach( (e:any) => {
      control.push(this._formBuilder.group({
        elementid: e.elementid,
        elementvalue: e.elementvalue,
        elementdesc: e.elementdesc,
        old_id: e.old_id
        })
      );
    });
  }

  initSurveyQsElements() {
    const controlQ1to5 = <FormArray>this.NytdSurveyQ1to5FormGroup.controls.elements;
    
    while(controlQ1to5.length > 0) {
      controlQ1to5.removeAt(0);
    }

    this.surveyQ1to5DataElements.forEach( (e:any) => {
      controlQ1to5.push(this._formBuilder.group({
        elementid: e.elementid,
        elementvalue: e.elementvalue,
        elementdesc: e.elementdesc,
        old_id: e.old_id
        })
      );
    });

    const controlQ6to12 = <FormArray>this.NytdSurveyQ6to12FormGroup.controls.elements;
    
    while(controlQ6to12.length > 0) {
      controlQ6to12.removeAt(0);
    }

    this.surveyQ6to12DataElements.forEach( (e:any) => {
      controlQ6to12.push(this._formBuilder.group({
        elementid: e.elementid,
        elementvalue: e.elementvalue,
        elementdesc: e.elementdesc,
        old_id: e.old_id
        })
      );
    });

    const controlQ13 = <FormArray>this.NytdSurveyQ13FormGroup.controls.elements;
    
    while(controlQ13.length > 0) {
      controlQ13.removeAt(0);
    }

    this.surveyQ13DataElements.forEach( (e:any) => {
      this.controlQ13Data(controlQ13,e);
    });

    const controlQ14 = <FormArray>this.NytdSurveyQ14FormGroup.controls.elements;
    
    while(controlQ14.length > 0) {
      controlQ14.removeAt(0);
    }

    this.surveyQ14DataElements.forEach( (e:any) => {
      this.ControlQ14Data(controlQ14,e);
    });

    const controlQ15 = <FormArray>this.NytdSurveyQ15FormGroup.controls.elements;
    
    while(controlQ15.length > 0) {
      controlQ15.removeAt(0);
    }

    this.surveyQ15DataElements.forEach( (e:any) => {
      controlQ15.push(this._formBuilder.group({
        elementid: e.elementid,
        elementvalue: e.elementvalue,
        elementdesc: e.elementdesc,
        old_id: e.old_id
        })
      );
    });

    const controlQ16 = <FormArray>this.NytdSurveyQ16FormGroup.controls.elements;
    
    while(controlQ16.length > 0) {
      controlQ16.removeAt(0);
    }

    this.surveyQ16DataElements.forEach( (e:any) => {
      this. controlQ16Data(controlQ16,e);
    });

    const controlQ17 = <FormArray>this.NytdSurveyQ17FormGroup.controls.elements;
    
    while(controlQ17.length > 0) {
      controlQ17.removeAt(0);
    }

    this.surveyQ17DataElements.forEach( (e:any) => {
      this.controlQ17Data(controlQ17,e);
    });


    var fostercareStatusOutcomes = this.surveyDataElements.filter((e:any) => e.old_id == 36);
      if(fostercareStatusOutcomes?.[0]?.elementvalue?.toLowerCase() === 'no') {
         this.setNullQ18to20 = true
      } else {
         this.setNullQ18to20 = false;
      }

    const controlQ18to20 = <FormArray>this.NytdSurveyQ18to20FormGroup.controls.elements;
    
    while(controlQ18to20.length > 0) {
      controlQ18to20.removeAt(0);
    }

    this.surveyQ18to20DataElements.forEach( (e:any) => {
      controlQ18to20.push(this._formBuilder.group({
        elementid: e.elementid,
        elementvalue: (e.elementvalue || !this.surveyQsAccess || this.setNullQ18to20) ? e.elementvalue : this.notapplicable,
        elementdesc: e.elementdesc,
        old_id: e.old_id
        })
      );
    });
  }

  selectReport(item:any, firstLoad:any) {
    this.selectedReport = item;
 
    this.showSurveyPage = item.reporttypekey === '13056' || item.reporttypekey === '13057' ? true : false;
    const reportingPeriodValue = item.reportingperiod.slice(4) === '09' ? '30' : '31';
    this.showSurveyPage = (moment(new Date(item.reportingperiod.substring(0, 4) + '-' + item.reportingperiod.slice(4) + '-' +  reportingPeriodValue))
                          >= moment(new Date(this.personInfo.personbasicdetails.dob)).add(17,'years')) ? true : false;
    
    this._NytdSurveyService.getNytdDetail(item.summaryid)
    .subscribe(data => {
      if (data && data.length) {
        this.elementValues = data;
        this.loadNYTDDetail();
        this.loadNYTDServed();
        if(this.showSurveyPage) {
          this.loadNYTDSurvey(null);
        }
      } else {
        this.detailDataElements = [];
        this.servedDataElements = [];
        this.surveyDataElements = [];
        this.surveyQ1to5DataElements = [];
        this.surveyQ6to12DataElements = [];
        this.surveyQ13DataElements = [];
        this.surveyQ14DataElements = [];
        this.surveyQ15DataElements = [];
        this.surveyQ16DataElements = [];
        this.surveyQ17DataElements = [];
        this.surveyQ18to20DataElements = [];
      }
      if (firstLoad) {
        this.goToNextPage('nytd-step1');
      }
    });
  }

  loadNYTDDetail() {
    this.reusableMapFn(this.detailDataElements);
    this.detailDataElements = [...this.detailDataElements];
    this.detailDataElements.sort((a:any,b:any) => a.old_id - b.old_id);
  }

  loadNYTDServed() {
    this.reusableMapFn(this.servedDataElements);
    this.servedDataElements = [...this.servedDataElements];
    this.servedDataElements.sort((a:any,b:any) => a.old_id - b.old_id);
  }

  loadNYTDSurvey(input:any) {
    this.elementValues = this.checkInputDataFn(input);
    // surveyDataElements
    this.reusableMapFn(this.surveyDataElements);
    this.surveyDataElements.sort((a:any,b:any) => a.old_id - b.old_id);
    
    var outcomesReportingStatus = this.surveyDataElements.filter((e:any) => e.old_id == 34);
    this.surveyQsAccess = this.surveyQsAccessBooleanFn(outcomesReportingStatus);
    // surveyQ1to5DataElements
    this.reusableMapFn(this.surveyQ1to5DataElements);
    this.surveyQ1to5DataElements.sort((a:any,b:any) => a.old_id - b.old_id);
    // surveyQ6to12DataElements
    this.reusableMapFn(this.surveyQ6to12DataElements);
    this.processElement46view(this.surveyQ6to12DataElements);
    this.surveyQ6to12DataElements.sort((a:any,b:any) => a.old_id - b.old_id);
    // surveyQ13DataElements
    this.reusableMapFn(this.surveyQ13DataElements);
    // surveyQ14DataElements
    this.reusableMapFn(this.surveyQ14DataElements);
    // surveyQ15DataElements
    this.reusableMapFn(this.surveyQ15DataElements);
    // surveyQ16DataElements
    this.reusableMapFn(this.surveyQ16DataElements);
    // surveyQ17DataElements
    this.reusableMapFn(this.surveyQ17DataElements);
    // surveyQ18to20DataElements
    this.reusableMapFn(this.surveyQ18to20DataElements);
    this.surveyQ18to20DataElements.sort((a:any,b:any) => a.old_id - b.old_id);

    this.surveyDataElements = [...this.surveyDataElements];
    this.surveyQ1to5DataElements = [...this.surveyQ1to5DataElements];
    this.surveyQ6to12DataElements = [...this.surveyQ6to12DataElements];
    this.surveyQ13DataElements = [...this.surveyQ13DataElements];
    this.surveyQ14DataElements = [...this.surveyQ14DataElements];
    this.surveyQ15DataElements = [...this.surveyQ15DataElements];
    this.surveyQ16DataElements = [...this.surveyQ16DataElements];
    this.surveyQ17DataElements = [...this.surveyQ17DataElements];
    this.surveyQ18to20DataElements = [...this.surveyQ18to20DataElements];
    
    this.initSurveyElements();
    this.initSurveyQsElements();
  }

  private reusableMapFn(element: any) {
    element.forEach((e:any) => {
      this.elementValuesMapFn(e);
    });
  }

  private elementValuesMapFn(e: any) {
    this.elementValues.forEach((v:any) => {
      if (e.elementid === v.elementid) {
        e.elementvalue = v.elementvalue;
      }
    });
  }

  private checkInputDataFn(input: any) {
    return input ? input : this.elementValues;
  }

  private surveyQsAccessBooleanFn(outcomesReportingStatus: any): boolean {
    return outcomesReportingStatus[0].elementvalue === '13058' ? true : false;
  }

  clearForm() {
    this.NytdSurveyFormGroup.reset();
    this.NytdSurveyQ1to5FormGroup.reset();
    this.NytdSurveyQ6to12FormGroup.reset();
    this.NytdSurveyQ13FormGroup.reset();
    this.NytdSurveyQ14FormGroup.reset();
    this.NytdSurveyQ15FormGroup.reset();
    this.NytdSurveyQ16FormGroup.reset();
    this.NytdSurveyQ17FormGroup.reset();
    this.NytdSurveyQ18to20FormGroup.reset();
  }

  //add new or update existing based on directive
  newResponse (directive:any) { 
    var msg = '';
    msg = (directive ===  'add') ? 'created' : 'updated';

    this._NytdSurveyService.createNewResponse(this.personInfo.personbasicdetails.cjamspid, directive)
      .subscribe((res) => {
        if(res && res[0]?.sp_nytd_data_population === 'success') {
          this._NytdSurveyService.getNytdSummary(this.personid)
          .subscribe(data => {
            if (data) {
              this.summary = data;
              this.getSortedSummary(false);
              this._alertService.success('Response ' +msg+ ' successfully!');
            }
          });
        } else {
          this.mandatoryResponses = false;
          this.negativeResponses = false;
          this.clientIneligible = true;
          (<any>$('#common-alert-box')).modal('show');
        }
    });
  }

  //save, verify or delete based on directive (after perform())
  save(directive:any) {
    var msg = '';
    msg = (directive ===  'saveOnly') ? 'saved' :  this.saveVerifyFn(directive);

    this._NytdSurveyService.saveUpdateNytdSurvey(this.selectedReport, this.response, directive)
      .subscribe((res) => {
        this._NytdSurveyService.getNytdSummary(this.personid)
          .subscribe(data => {
            if (data) {
              this.summary = data;
              this.getSortedSummary(true);
              this._alertService.success('Response ' +msg+ ' successfully!');
            }
          });
    });
  }

  private saveVerifyFn(directive: any): string {
    return (directive === 'saveVerify') ? 'verified' : 'deleted';
  }

  validateResponse() {
    const surveyData = this.NytdSurveyFormGroup.getRawValue();
    const surveyQ1to5Data = this.NytdSurveyQ1to5FormGroup.getRawValue();
    const surveyQ6to12Data = this.NytdSurveyQ6to12FormGroup.getRawValue();
    const surveyQ13Data = this.NytdSurveyQ13FormGroup.getRawValue();
    const surveyQ14Data = this.NytdSurveyQ14FormGroup.getRawValue();
    const surveyQ15Data = this.NytdSurveyQ15FormGroup.getRawValue();
    const surveyQ16Data = this.NytdSurveyQ16FormGroup.getRawValue();
    const surveyQ17Data = this.NytdSurveyQ17FormGroup.getRawValue();
    const surveyQ18to20Data = this.NytdSurveyQ18to20FormGroup.getRawValue();
  
    if (this.surveyQsAccess) { //perform the below validation only when 'true' i.e. Outcomes reporting status = Youth Participated, else skip
      let checkForAllValues = surveyQ1to5Data.elements.filter((e:any) => e.elementvalue == null);
      checkForAllValues = this.checkForAllValuesFn1(checkForAllValues, surveyQ6to12Data, surveyQ13Data, surveyQ14Data, surveyQ15Data);
      checkForAllValues = this.checkForAllValuesFn2(checkForAllValues, surveyQ16Data, surveyQ17Data, surveyQ18to20Data);

      const checkForAllNegs1to5 = surveyQ1to5Data.elements.filter((e:any) => e.elementvalue === 'no' || e.elementvalue === 'declined');
      const checkForAllNegs6to12 = surveyQ6to12Data.elements.filter((e:any) => e.elementvalue === 'no' || e.elementvalue === 'declined');
      const checkForAllNegs13 = surveyQ13Data.elements.filter((e:any) => e.elementvalue === 'no' || e.elementvalue === 'declined');
      const checkForAllNegs14 = surveyQ14Data.elements.filter((e:any) => e.elementvalue === 'no' || e.elementvalue === 'declined');
      const checkForAllNegs15 = surveyQ15Data.elements.filter((e:any) => e.elementvalue === 'no' || e.elementvalue === 'declined');
      const checkForAllNegs16 = surveyQ16Data.elements.filter((e:any) => e.elementvalue === 'no' || e.elementvalue === 'declined');
      const checkForAllNegs17 = surveyQ17Data.elements.filter((e:any) => e.elementvalue === 'no' || e.elementvalue === 'declined');
      const checkForAllNegs18to20 = surveyQ18to20Data.elements.filter((e:any) => e.elementvalue === 'no' || e.elementvalue === 'declined');

      const sumSurveyLength = (surveyQ1to5Data.elements.length + surveyQ6to12Data.elements.length + surveyQ13Data.elements.length + surveyQ14Data.elements.length + surveyQ15Data.elements.length + surveyQ16Data.elements.length + surveyQ17Data.elements.length + surveyQ18to20Data.elements.length)
      const sumAllNegsLength = (checkForAllNegs1to5.length + checkForAllNegs6to12.length + checkForAllNegs13.length + checkForAllNegs14.length + checkForAllNegs15.length + checkForAllNegs16.length + checkForAllNegs17.length + checkForAllNegs18to20.length);
      const getAllNegsBooleanValue = (checkForAllNegs1to5 && checkForAllNegs6to12 && checkForAllNegs13 && checkForAllNegs14 && checkForAllNegs15 && checkForAllNegs16 && checkForAllNegs17 && checkForAllNegs18to20);
      this.checkSurveyAndNegoConditionFn(checkForAllValues, getAllNegsBooleanValue, sumAllNegsLength, sumSurveyLength);
    } else {
      this.negativeAndMandatoryResponsesFn();
    }
    this.response = [];
    this.reusableForeachFn(surveyData);
    this.reusableForeachFn(surveyQ1to5Data);
    this.processElement46save(surveyQ6to12Data.elements);
    this.reusableForeachFn(surveyQ6to12Data);
    this.reusableForeachFn(surveyQ13Data);
    this.reusableForeachFn(surveyQ14Data);
    this.reusableForeachFn(surveyQ15Data);
    this.reusableForeachFn(surveyQ16Data);
    this.reusableForeachFn(surveyQ17Data);
    this.reusableForeachFn(surveyQ18to20Data);
  }

  private checkSurveyAndNegoConditionFn(checkForAllValues: any, getAllNegsBooleanValue: any, sumAllNegsLength: any, sumSurveyLength: any) {
    if (checkForAllValues && checkForAllValues.length > 0) {
      this.mandatoryResponses = true;
      this.negativeResponses = false;
    } else if (getAllNegsBooleanValue && (sumAllNegsLength === sumSurveyLength)) {
      this.negativeResponses = true;
      this.mandatoryResponses = false;
    } else {
      this.negativeAndMandatoryResponsesFn();
    }
  }

  private checkForAllValuesFn2(checkForAllValues: any, surveyQ16Data: any, surveyQ17Data: any, surveyQ18to20Data: any) {
    if (!checkForAllValues || checkForAllValues.length === 0) {
      checkForAllValues = surveyQ16Data.elements.filter((e:any) => e.elementvalue == null);
    }
    if (!checkForAllValues || checkForAllValues.length === 0) {
      checkForAllValues = surveyQ17Data.elements.filter((e:any) => e.elementvalue == null);
    }
    if (!checkForAllValues || checkForAllValues.length === 0) {
      checkForAllValues = surveyQ18to20Data.elements.filter((e:any) => e.elementvalue == null);
    }
    return checkForAllValues;
  }

  private checkForAllValuesFn1(checkForAllValues: any, surveyQ6to12Data: any, surveyQ13Data: any, surveyQ14Data: any, surveyQ15Data: any) {
    if (!checkForAllValues || checkForAllValues.length === 0) {
      checkForAllValues = surveyQ6to12Data.elements.filter((e:any) => e.elementvalue == null);
    }
    if (!checkForAllValues || checkForAllValues.length === 0) {
      checkForAllValues = surveyQ13Data.elements.filter((e:any) => e.elementvalue == null);
    }
    if (!checkForAllValues || checkForAllValues.length === 0) {
      checkForAllValues = surveyQ14Data.elements.filter((e:any) => e.elementvalue == null);
    }
    if (!checkForAllValues || checkForAllValues.length === 0) {
      checkForAllValues = surveyQ15Data.elements.filter((e:any) => e.elementvalue == null);
    }
    return checkForAllValues;
  }

  private negativeAndMandatoryResponsesFn() {
    this.negativeResponses = false;
    this.mandatoryResponses = false;
  }

  private reusableForeachFn(elementsData: any) {
    elementsData.elements.forEach((element :any)=> {
      this.response.push(element);
    });
  }

  validateQ13(event:any) {
    const val = event.value ? event.value : '';
    const surveyQ14Data = this.NytdSurveyQ14FormGroup.getRawValue();

    if (surveyQ14Data.elements && (surveyQ14Data.elements[0].elementvalue && surveyQ14Data.elements[0].elementvalue !== this.notapplicable) && (val == 'no' || val == 'declined')) {
      this.resetQ13();
      (<any>$(this.q13q14validationpopupid)).modal('show');
    }

    if (surveyQ14Data.elements && (surveyQ14Data.elements[0].elementvalue == this.notapplicable || surveyQ14Data.elements[0].elementvalue == 'declined') && val == 'yes') {
      this.resetQ13();
      (<any>$(this.q13q14validationpopupid)).modal('show');
    }
  }

  validateQ14(event:any) {
    const val = event.value ? event.value : '';
    const surveyQ13Data = this.NytdSurveyQ13FormGroup.getRawValue();

    if (surveyQ13Data.elements && (surveyQ13Data.elements[0].elementvalue == 'no' || surveyQ13Data.elements[0].elementvalue == 'declined') && val !== this.notapplicable) {
      this.resetQ14();
      (<any>$(this.q13q14validationpopupid)).modal('show');
    }

    if (surveyQ13Data.elements && (surveyQ13Data.elements[0].elementvalue == 'yes') && (val == this.notapplicable || val == 'declined')) {
      this.resetQ14();
      (<any>$(this.q13q14validationpopupid)).modal('show');
    }
  }

  validateQ16(event:any) {
    if(this.selectedReport.reporttypekey !== '13054') {
      const val = event.value ? event.value : '';
      const surveyQ17Data = this.NytdSurveyQ17FormGroup.getRawValue();

      if (surveyQ17Data.elements && (surveyQ17Data.elements.some((e:any) => e.elementvalue == this.notapplicable)) && val == 'yes') {
        this.resetQ16();
        (<any>$(this.q13q14validationpopupid)).modal('show');
      }

      if (surveyQ17Data.elements && (surveyQ17Data.elements.some((e:any) => e.elementvalue && e.elementvalue !== this.notapplicable)) && val !== 'yes') {
        this.resetQ16();
        (<any>$(this.q13q14validationpopupid)).modal('show');
      }
    }
  }

  validateQ17(event:any) {
    if(this.selectedReport.reporttypekey !== '13054') {
      const val = event.value ? event.value : '';
      const surveyQ16Data = this.NytdSurveyQ16FormGroup.getRawValue();

      if (surveyQ16Data.elements && (surveyQ16Data.elements[0].elementvalue && surveyQ16Data.elements[0].elementvalue !== 'yes') && val !== this.notapplicable) {
        this.resetQ17(false);
        (<any>$(this.q13q14validationpopupid)).modal('show');
      }

      // check with SSI --
      if (surveyQ16Data.elements && (surveyQ16Data.elements[0].elementvalue == 'yes') && val == this.notapplicable) {
        this.resetQ17(true);
        (<any>$(this.q13q14validationpopupid)).modal('show');
      }
    }
  }

  validateQ18Q19Q20(event:any) {
    const val = event.value ? event.value : '';
    const surveyData = this.NytdSurveyFormGroup.getRawValue(); //check E34 value i.e. Foster Care Status - Outcomes

    if (surveyData.elements && (surveyData.elements.some((e:any) => e.elementvalue.toLowerCase() == 'yes')) && (val !== this.notapplicable)) {
      this.resetQ18Q19Q20(false);
      (<any>$(this.q13q14validationpopupid)).modal('show');
    }

    if (surveyData.elements && (surveyData.elements.some((e:any) => e.elementvalue.toLowerCase() == 'no')) && (val == this.notapplicable)) {
      this.resetQ18Q19Q20(true);
      (<any>$(this.q13q14validationpopupid)).modal('show');
    }
  }

  perform(action: string, report:any) {
    this.selectedReport = report;
    
    switch (action) {
      case 'add':
        this.newResponse('add');
        break;
      case 'view':
        this.editMode = false;
        this.selectReport(report, true);
        break;
      case 'manualUpdate':
        (<any>$('#confirm-updation')).modal('show');
        break;
      case 'update':
        this.newResponse('update');
        break;
      case 'edit':
        this.editMode = true;
        this.selectReport(report, true);
        break;
      case 'save':
        this.validateResponse();
        this.save('saveOnly');
        break;
      case 'verify':
        this.validateResponse();
        if(this.selectedReport.reporttypekey !== '13054' && this.selectedReport.reporttypekey !== '13055') {
          if(!this.mandatoryResponses && !this.negativeResponses ) {
            (<any>$('#confirm-verification')).modal('show');
          } else {
            (<any>$('#common-alert-box')).modal('show');
          }
        } else { //@TM: don't need to perform response validation for Served population since there's no Survey
          (<any>$('#confirm-verification')).modal('show');          
        }
        break;
      case 'saveVerify':
        this.save('saveVerify');
        break;
      case 'delete':
        (<any>$('#confirm-deletion')).modal('show');
        break;
      case 'softDelete':
        this.save('softDelete')
        break;
      case 'print':
        this.downloadReportPdf();
        break;
      default:
        break;
    }
  }

  goToNextPage(pageToGo: string) {
    const pageId:any = $('#' + pageToGo);
    pageId.click();
    $('html,body').animate({ scrollTop: pageId?.offset()?.top }, 'slow');
  }

  setSurveyAccess(event:any) {
    const accessModifiers = ['13059','13060','13061','13062','13063','13064','13065','13067'] //@TM: remove hard-coded values
    if (accessModifiers.includes(event.value)) {
      (<any>$('#reset-survey-qs')).modal('show');
    } else {
      this.surveyQsAccess = true;
      this.initSurveyQsElements();
    }
  }

  resetSurveyQs (flag:any) {
    if(flag) {
      this.surveyQ1to5DataElements.map((e:any) => {
        e.elementvalue = null
      });
      this.surveyQ6to12DataElements.map((e:any) => {
        e.elementvalue = null
      });
      this.surveyQ13DataElements.map((e:any) => {
        e.elementvalue = null
      });
      this.surveyQ14DataElements.map((e:any) => {
        e.elementvalue = null
      });
      this.surveyQ15DataElements.map((e:any) => {
        e.elementvalue = null
      });
      this.surveyQ16DataElements.map((e:any) => {
        e.elementvalue = null
      });
      this.surveyQ17DataElements.map((e:any) => {
        e.elementvalue = null
      });
      this.surveyQ18to20DataElements.map((e:any) => {
        e.elementvalue = null
      });
      this.surveyQ1to5DataElements = [...this.surveyQ1to5DataElements];
      this.surveyQ6to12DataElements = [...this.surveyQ6to12DataElements];
      this.surveyQ13DataElements = [...this.surveyQ13DataElements];
      this.surveyQ14DataElements = [...this.surveyQ14DataElements];
      this.surveyQ15DataElements = [...this.surveyQ15DataElements];
      this.surveyQ16DataElements = [...this.surveyQ16DataElements];
      this.surveyQ17DataElements = [...this.surveyQ17DataElements];
      this.surveyQ18to20DataElements = [...this.surveyQ18to20DataElements];

      this.surveyQsAccess = false;
      this.initSurveyQsElements();
    } else {
      this.selectReport(this.selectedReport, false);
      this.surveyQsAccess = true;
    }
    
  }

  resetQ13() {
    this.surveyQ13DataElements.map((e:any) => {
      e.elementvalue = null
    });
    this.surveyQ13DataElements = [...this.surveyQ13DataElements];
    const controlQ13 = <FormArray>this.NytdSurveyQ13FormGroup.controls.elements;
  
    while(controlQ13.length > 0) {
      controlQ13.removeAt(0);
    }

    this.surveyQ14DataElements.forEach( (e:any) => {
      this.controlQ13Data(controlQ13,e);
    });
  }

  controlQ13Data(controlQ13:any,e:any){
    controlQ13.push(this._formBuilder.group({
      elementid: e.elementid,
      elementvalue: e.elementvalue,
      elementdesc: e.elementdesc,
      old_id: e.old_id
      })
    );
  }

  resetQ14() {
    this.surveyQ14DataElements.map((e:any) => {
      e.elementvalue = null
    });
    this.surveyQ14DataElements = [...this.surveyQ14DataElements];
    const controlQ14 = <FormArray>this.NytdSurveyQ14FormGroup.controls.elements;
  
    while(controlQ14.length > 0) {
      controlQ14.removeAt(0);
    }

    this.surveyQ14DataElements.forEach( (e:any) => {
     this.ControlQ14Data(controlQ14,e);
    });
  }

  ControlQ14Data(controlQ14:any,e:any){
    controlQ14.push(this._formBuilder.group({
      elementid: e.elementid,
      elementvalue: e.elementvalue,
      elementdesc: e.elementdesc,
      old_id: e.old_id
      })
    );
  }

  resetQ16() {
    this.surveyQ16DataElements.map((e:any) => {
      e.elementvalue = null
    });
    this.surveyQ16DataElements = [...this.surveyQ16DataElements];
    const controlQ16 = <FormArray>this.NytdSurveyQ16FormGroup.controls.elements;
    
    while(controlQ16.length > 0) {
      controlQ16.removeAt(0);
    }

    this.surveyQ16DataElements.forEach( (e:any) => {
     this. controlQ16Data(controlQ16,e);
    });
  }

  controlQ16Data(controlQ16:any,e:any){
    controlQ16.push(this._formBuilder.group({
      elementid: e.elementid,
      elementvalue: e.elementvalue,
      elementdesc: e.elementdesc,
      old_id: e.old_id
      })
    );
  }

  resetQ17(resetNA:any) {
    const surveyQ17Data = this.NytdSurveyQ17FormGroup.getRawValue();

    if (resetNA) {
      surveyQ17Data.elements.map((e:any) => {
        if (e.elementvalue == this.notapplicable) {
          e.elementvalue = null
        }
      });
    } else {
      surveyQ17Data.elements.map((e:any) => {
        if (e.elementvalue !== this.notapplicable) {
          e.elementvalue = null
        }
      });
    }
    
    const controlQ17 = <FormArray>this.NytdSurveyQ17FormGroup.controls.elements;
    
    while(controlQ17.length > 0) {
      controlQ17.removeAt(0);
    }

    surveyQ17Data.elements.forEach( (e:any) => {
      this.controlQ17Data(controlQ17,e);
    });
  }

  controlQ17Data(controlQ17:any,e:any){
    controlQ17.push(this._formBuilder.group({
      elementid: e.elementid,
      elementvalue: e.elementvalue,
      elementdesc: e.elementdesc,
      old_id: e.old_id
      })
    );
  }

  resetQ18Q19Q20(resetNA:any) {
    const surveyQ18to20Data = this.NytdSurveyQ18to20FormGroup.getRawValue();

    if (resetNA) {
      surveyQ18to20Data.elements.map((e:any) => {   // NOSONAR    // This function has less than 3 records of duplicate lines. Hence, it is marked as no sonar
        if (e.elementvalue == this.notapplicable) {
          e.elementvalue = null
        }
      });
    } else {
      surveyQ18to20Data.elements.map((e:any) => { // NOSONAR    // This function has less than 3 records of duplicate lines. Hence, it is marked as no sonar
        if (e.elementvalue !== this.notapplicable) {
          e.elementvalue = null
        }
      });
    }

    const controlQ18to20 = <FormArray>this.NytdSurveyQ18to20FormGroup.controls.elements;
    
    while(controlQ18to20.length > 0) {
      controlQ18to20.removeAt(0);
    }

    surveyQ18to20Data.elements.forEach( (e:any) => {
      controlQ18to20.push(this._formBuilder.group({
        elementid: e.elementid,
        elementvalue: e.elementvalue,
        elementdesc: e.elementdesc,
        old_id: e.old_id
        })
      );
    });
  }

  processElement46view(input:any) {
    const ele46: any[] = input.filter((e:any) => e.old_id == 46)

    if(ele46.length > 0) {
      if (ele46[0].elementvalue === "Associate's degree(e.g., A.A.)") {
        ele46[0].elementvalue = '7x';
      } else if (ele46[0].elementvalue === "Bachelor's degree(e.g., B.A. or B.S.)") {
        ele46[0].elementvalue = '7y';
      }
  
      this.surveyQ6to12DataElements.map((e:any) => {
        if (e.old_id === 46) {
          e.elementvalue = ele46[0].elementvalue;
        }
      });
    }
  }

  processElement46save(input:any) {
    const ele46: any[] = input.filter((e:any) => e.old_id == 46)

    if(ele46.length > 0) {
      if (ele46[0].elementvalue === "7x") {
        ele46[0].elementvalue = "Associate's degree(e.g., A.A.)";
      } else if (ele46[0].elementvalue === "7y") {
        ele46[0].elementvalue = "Bachelor's degree(e.g., B.A. or B.S.)";
      }
  
      this.surveyQ6to12DataElements.map((e:any) => {    // NOSONAR    // This function has less than 3 records of duplicate lines. Hence, it is marked as no sonar
        if (e.old_id === 46) {
          e.elementvalue = ele46[0].elementvalue;
        }
      });
    }
  }

  getReportType(typeCd:any) {
    const type = this.reportTypes.filter((r:any) => r.picklist_value_cd === typeCd);
    if(type && type.length>0) {
      return type[0].value_tx;
    } else {
      return '';
    }
  }

  getUserName(id:any) {
    const name = this.userNames.data.filter((u:any) => u.securityusersid == id);
    if(name && name.length>0) {
      return name[0].displayname;
    } else {
      return id;
    }
  }

  async downloadReportPdf() {
    const pages:any = document.getElementsByClassName('pdf-page');
    let pageImages:any[] = [];
    for (let i = 0; i < pages.length; i++) {
      const pageName = pages.item(i).getAttribute('data-page-name');
      if (pageName === 'NYTD Survey') {
        await this.html2canvas.capture(<HTMLElement>pages.item(i)).then((canvas: any) => {
          const img = canvas.toDataURL('image/png');
          pageImages.push(img);
        });
      }
    }

    this.pdfFiles.push({ fileName: 'NYTD', images: pageImages });
    pageImages = [];
    this.convertImageToPdf();
  }

  convertImageToPdf() {
    this.pdfFiles.forEach((pdfFile) => {
        let doc:any = null;
        doc = new jsPDF();
        const width = doc.internal.pageSize.getWidth() - 10;
        const heigth = doc.internal.pageSize.getHeight() - 10;

        pdfFile.images.forEach((image, index) => {

          doc.addImage(image, 'PNG', 3, 5, width, heigth);
          if (pdfFile.images.length > index + 1) {
              doc.addPage();
          }
        });
        doc.save(pdfFile.fileName);
    });
    
    this.pdfFiles = [];
  }

  customSort(event:any) {
    this.sortData = event;
    this.paginationInfo.pageNumber = 1;
  }

  onSorted($event: any) {
    this.paginationInfo.sortBy = $event.sortColumn + ' ' + $event.sortDirection;
  }

  getNytdSurveyQ15FormGroupData(name: string): any[] {
    return Object.values((this.NytdSurveyQ15FormGroup.get(name) as FormGroup).controls);
  }

  getNytdSurveyQ15FormGroupOrderData(name: string): any {
    return Object.values((this.NytdSurveyQ15FormGroup.get(name) as FormGroup).controls.old_id);
  }
}
