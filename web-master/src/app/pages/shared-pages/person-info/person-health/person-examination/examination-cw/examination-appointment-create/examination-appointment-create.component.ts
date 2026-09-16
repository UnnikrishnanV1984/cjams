
import {map, share, pluck} from 'rxjs/operators';
import { Component, OnInit, Input } from '@angular/core';
import { forkJoin ,  Observable } from 'rxjs';
import { AlertService, CommonHttpService, DataStoreService } from '../../../../../../../@core/services';
import moment from 'moment';
import { CaseWorkerUrlConfig } from '../../../../../../case-worker/case-worker-url.config';
import { DropdownModel, PaginationRequest } from '../../../../../../../@core/entities/common.entities';
import { PersonExaminationService } from '../../person-examination.service';
import { IntakeStoreConstants } from '../../../../../../newintake/my-newintake/my-newintake.constants';

@Component({
    selector: 'examination-appointment-create',
    templateUrl: './examination-appointment-create.component.html',
    styleUrls: ['./examination-appointment-create.component.scss'],
    standalone: false
})
export class ExaminationAppointmentCreateComponent implements OnInit {

  examTypeDropdownItems$!: Observable<any[]>;
  notkeptreasonDropdownItem$!: Observable<any[]>;
  specialityExamTypeDropdownItems$!: Observable<any[]>;
  labTestDropdownItems$!: Observable<any[]>;
  APPOINTMENT_KEPT = 1;
  APPOINTMENT_NOT_KEPT = 0;
  APPOINTMENT_REFUSED = 2;

  appointmentActions: any[] = [];
  min!: Date;
  minNextAppointment!: Date;
  epstdTimeFrames: any;
  enableTimeFrame: boolean = false;
  disableTimeFramSelection: boolean = false;
  @Input() appointments: any[] = [];
  @Input() disabled = false;
  showlabtestother : boolean = false;
  showspecialexamother : boolean = false;
  showdropdownvalue: boolean = false;
  isshowdropdown: boolean = true;
  showfcauthform: boolean = false;
  showotherflag:boolean =false;
  @Input()
  requiredForApproval!: boolean;
  provcaremissedappt: boolean =false;
  provcaregmissdappt =['CPA','Public','Kinship'];
  infoDialog!: string;
  specialityExamTypeDropdownItems: any[] = [];
  specialityExamItems: any;
  constructor(private _commonHttpService: CommonHttpService,
    private _examinationService: PersonExaminationService,
    private _dataStoreService: DataStoreService,
    private _alertSevice: AlertService) { }


  ngOnInit() {
    const dob = new Date(this._dataStoreService.getData(IntakeStoreConstants.DATE_OF_BIRTH));
    if(dob){
      this.minNextAppointment = dob;
    }else{
      this.minNextAppointment = new Date();}
    this.appointments.forEach(appt =>{
      if(appt.apptDate){
        this.calculateAppointmentDurationView(appt);
      }
    });
    this.min = new Date();
    this.loadDropDown();
    this.getTimeFrameList();
    this.enableTimeFram();
    if(this.appointments[0].notkeptreason === 'NKR1' ||this.appointments[0].notkeptreason === 'NKR2'|| this.appointments[0].notkeptreason === 'NKR3'|| this.appointments[0].notkeptreason === 'NKR4'|| this.appointments[0].notkeptreason === 'NKR5' ||this.appointments[0].notkeptreason === 'NKR6'|| this.appointments[0].notkeptreason === 'NKR7'|| this.appointments[0].notkeptreason === null){
      this.isshowdropdown = true;
      if(this.appointments[0].notkeptreason === 'NKR1'){
        this.notkeptreason('NKR1')

      } else if(this.appointments[0].notkeptreason === 'NKR6') {
        this.notkeptreason('NKR6') 
      }
      else if(this.appointments[0].notkeptreason === 'NKR7') {
        this.notkeptreason('NKR7') 
      }
    } else {
      this.isshowdropdown = false;
    } 
  }

  private getSpecialityExamItems()
  {
    this._commonHttpService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '318' }
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
    ).subscribe(result => {
      this.specialityExamItems = result;
      if (this.appointments[0]?.natureofexamkey === '32926' ){
        this.specialityExamItems = this.specialityExamItems.filter((x: { description_tx: string; }) => 
          x.description_tx.toLowerCase() == 'urgent visit' ||
          x.description_tx.toLowerCase() == 'follow up visit' ||
          x.description_tx.toLowerCase() == 'orthodontics' ||
          x.description_tx.toLowerCase() == 'dental surgery' || 
          x.description_tx.toLowerCase() == 'specialist appointment' 
        );
      }else
      if (this.appointments[0]?.natureofexamkey === '3257' ){
        this.specialityExamItems = this.specialityExamItems.filter((x: { description_tx: string; }) => 
          x.description_tx.toLowerCase() == 'gyn' ||
          x.description_tx.toLowerCase() == 'hearing' ||
          x.description_tx.toLowerCase() == 'vision' 
        );
      }else
      {
        this.specialityExamItems = this.specialityExamItems.filter((x: { description_tx: string; }) => 
          x.description_tx.toLowerCase() !== 'urgent visit' &&
          x.description_tx.toLowerCase() !== 'follow up visit' &&
          x.description_tx.toLowerCase() !== 'orthodontics' &&
          x.description_tx.toLowerCase() !== 'dental surgery' && 
          x.description_tx.toLowerCase() !== 'specialist appointment' 
        );
      }
  });

  }
  private loadDropDown() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '320' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '319' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '323' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      )
    ]).pipe(
      map((result) => {
        return {
          examTypeList: this.createNewDropDown(result[0]),
          labTestList: this.createNewDropDown(result[1]),
          notKeptReason: this.createNewDropDown(result[2])
        };
      }),
      share(),);
      this.getSpecialityExamItems();
    this.examTypeDropdownItems$ = source.pipe(pluck('examTypeList'));
    this.labTestDropdownItems$ = source.pipe(pluck('labTestList'));
    this.notkeptreasonDropdownItem$ =source.pipe(pluck('notKeptReason'));
    
    this.appointmentActions =  [{
      ref_key: 1,
      description: 'Kept'
    },
    {
      ref_key: 0,
      description: 'Not kept'
    }
  ];
  }

  createNewDropDown(result: any){
    return result.map(
      (res: { description_tx: any; picklist_value_cd: any; }) =>
        new DropdownModel({
          text: res.description_tx,
          value: res.picklist_value_cd
        })
    )
  }

  populateSpecialityExam()
  {
    this.appointments[0].issemiannualdentalvisit = null;
    this.appointments[0].isannualhealthvisit =  null;
    this.getSpecialityExamItems();
  }

  getTimeFrameList() { 
    this._commonHttpService
    .getPagedArrayList(
      new PaginationRequest({
        page: 1,
        limit: 10,
        method: 'get',
        where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '10047' },
      }),
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
    ).subscribe((result: any) => {
        this.epstdTimeFrames = result;
        this.epstdTimeFrames.sort(function(a: { picklist_value_cd: number; }, b: { picklist_value_cd: number; }) {
          return a.picklist_value_cd - b.picklist_value_cd;
        });
    });
  }

  removeItem(index: any) {
    this.appointments.splice(index, 1);
  }
  
  calculateAppointmentDuration(item: any) {
    const formatApptDate = item.apptDate ? moment(item.apptDate).format('MM-DD-YYYY') : null;
    if(item.starttime && item.endtime){
    const _startTime = moment(formatApptDate + ' ' + item.starttime + ':00');
    const _endTime = moment(formatApptDate + ' ' + item.endtime + ':00');
    if(_endTime > _startTime){
    const computedDuration: any = moment.duration(_endTime.diff(_startTime));
    if (computedDuration['_data']) {
      item.durationhours = computedDuration['_data'].hours;
      item.durationmins = computedDuration['_data'].minutes;
    }
  } else {
    item.endtime = null;
    this._alertSevice.error('End time must be greater than Start time.');
  }
  }
}

calculateAppointmentDurationView(item: any) {
  const _startTime = moment(moment(item.apptDate).format('MM/DD/YYYY') + ' ' + item.starttime + ':00');
  const _endTime = moment(moment(item.apptDate).format('MM/DD/YYYY') + ' ' + item.endtime + ':00');

  const computedDuration: any = moment.duration(_endTime.diff(_startTime));
  if (computedDuration['_data']) {
    item.durationhours = computedDuration['_data'].hours;
    item.durationmins = computedDuration['_data'].minutes;
  }
}

  addItem() {
    this.appointments.push(this._examinationService.getNewAppointment());
  }

  validateTimeFrame(value: any) {
    this.enableTimeFrame = (['3257', '3256', '7833', '3255'].includes(value)) ? true : false; 
    this?.appointments?.forEach(e => {
      e.timeframe = null;
    });
  }

  calculatePersonAge(dob?: any) {
    if (dob) {
      const years = moment().diff(dob, 'years', false);
      dob.setFullYear( dob?.getFullYear() + 4 );
      if(years && (years > 4) || (years === 4 && ((moment().diff(dob, 'days', false)) - 1) > 184)) {
        this.disableTimeFramSelection = true;
      } 
    }
  }

  enableTimeFram() {
    if(this.appointments.length && this.appointments[0].timeframe) {
      this.enableTimeFrame = true;
    }

    if(this.disabled) {
      this.disableTimeFramSelection = true;
    } else {
      this.calculatePersonAge(new Date(this._dataStoreService.getData(IntakeStoreConstants.DATE_OF_BIRTH)));
    }
  }
  selectLabTest(value: any) {
      value.map((res: string) => {
      if( res === '7829') {
        this.showlabtestother = true; 
      } else {
        this.showlabtestother = false; 

      }
      });
}

showdropdown(selected: any, index: any){
  if (selected ==='Not kept') {
    this.showdropdownvalue = true;
  } else {
    this.showfcauthform = false;
    this.showotherflag = false;
  }
  this.resetToDefault(index);
}
resetToDefault(index: any) {
  this.appointments[index].notkeptreason = '';
  this.appointments[index].otherreason = '';
  this.appointments[index].authformcompletion = '';
  this.appointments[index].notcompletedauthform = '';
}
notkeptreason(event: string) {
  if (event === 'NKR1'){
    const dob = moment(new Date(this._dataStoreService.getData(IntakeStoreConstants.DATE_OF_BIRTH)));
    const age = moment().diff(dob, 'years', true);
    
    if(age >=18){
     this.showfcauthform = true;
    } else {
      this.showfcauthform = false;
    }
  }
  else {
    this.showfcauthform = false;
    this.appointments[0].notcompletedauthform ='';
    this.appointments[0].authformcompletion = ''
  }
  if(event === 'NKR6'){
    this.showotherflag =  true;
  } else{
    this.showotherflag = false;
    this.appointments[0].otherreason = '';
  }
  if(event === 'NKR7') {
    this.provcaremissedappt = true;
  }else{
    this.provcaremissedappt = false;
    this.appointments[0].provcaremissed = '';
  }
}
resetfostercare(event: string) {
  if(event === "1") {
    this.appointments[0].notcompletedauthform = '';
  }
}
showInfoDialog(value: string)
  {
    this.infoDialog = value;
    (<any>$('#info-dialog')).modal('show');
  }
}