import { Component, OnDestroy, OnInit, EventEmitter, Output, Input } from '@angular/core';
import { ExitPlacementService } from './exit-placement.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { PlacementConstants } from '../constants';
import { ServiceCasePlacementsService } from '../service-case-placements.service';
import moment from 'moment';
import { AlertService, CommonHttpService } from '../../../../../@core/services';
import {HospitalizationService} from "../../../../../shared/services/hospitalization.service"
import { Subscription } from 'rxjs';


@Component({
    selector: 'exit-placements',
    templateUrl: './exit-placements.component.html',
    styleUrls: ['./exit-placements.component.scss'],
    standalone: false
})
export class ExitPlacementsComponent implements OnInit, OnDestroy {
  @Input() child: any;
  exitTypes: any[] = [];
  reasonsForExit: any[] = [];
  exitPlacementForm: FormGroup;
  exitReasonKey: any;
  reasonForExitRequired = false;
  transferAgencyRequried = false;
  commentsRequired = false;
  exitMinDate:any;
  exitMaxDate = new Date();
  children: any[] = [];
  startDate: any;
  startTime: any;
  reasonforexit : any;
  transferagencies : any;
  dtformat = 'YYYY-MM-DD';
  dischargeDateSubscription!: Subscription;
  dischargeTimeSubscription!: Subscription;
  @Output() 
  exitEndDateEvent = new EventEmitter();
  @Output() 
  exitEndTimeEvent = new EventEmitter();

  @Output()
  disposableortrashbagevent = new EventEmitter();

  KRD_startdate: any;
  KRD_enddate: any;
  // placementdisposableortrashbag:any;
  //TPR pre-adoptive change
  // changePreAdoptiveRequired = false;
  // isproviderpreadoptive = true;
  // changePreAdoptiveMsg:string;

  constructor(private _service: ServiceCasePlacementsService, 
    private formBuilder: FormBuilder, 
    private _alertService: AlertService, 
    private exitService: ExitPlacementService,
    private readonly _commonHttpService: CommonHttpService,
    private _hospitalizationService: HospitalizationService) {
    this.exitPlacementForm = this.exitService.getFormInstance();
  }

  ngOnInit() {
    this.loadDropDowns();
    this.getDates();
    this.exitPlacementForm.get('exitreasontypekey')?.disable();
    const minEndDate = moment(this.exitService.minExitDate).format(this.dtformat); 
    this.exitMinDate = moment(minEndDate).toDate(); 
    this.children = this._service.placementDetails;
    if(this._service.placementDetails[0].placement.placementtypekey === 'LA') {
      this.forminitialize();
    }
    if(this.children[0].placement.placementtypekey === 'PRPL' && this.children[0].placement.placementrevision !== null){
      this.exitPlacementForm.patchValue({
        leastrestrictiveplacement:this.children[0].placement.placementrevision[0].leastrestrictiveplacement
      });
    }

    this.startTime = moment(new Date(this._service.placementDetails[0]?.placement?.stime)).format("HH:mm");
    this.startDate = moment(new Date(this._service.placementDetails[0]?.placement?.startdate)).format(this.dtformat);

    this.exitPlacementForm.get('exitreasontypekey')?.valueChanges.subscribe(value => {
      this.onExitReasonTypeChange(value);
    });

   this.dischargeDateSubscription = this._hospitalizationService.getDischargeDate().subscribe((value: any)=>{
      if (value) {
        const dateObject = new Date(value)
        this.exitPlacementForm.get("enddate")?.patchValue(dateObject);
        this.exitPlacementForm.updateValueAndValidity();
        this.exitEndDateEvent.emit(value);
      }

    })
    this.dischargeTimeSubscription = this._hospitalizationService.getDischargeTime().subscribe((value: any)=>{
      if (value) {
       
        this.exitPlacementForm.get("endtime")?.patchValue(value);
        this.exitPlacementForm.updateValueAndValidity();
        this.exitEndTimeEvent.emit(value);
      }

    })
  }

  ngOnDestroy(): void {
      this.dischargeDateSubscription.unsubscribe();
      this.dischargeTimeSubscription.unsubscribe();
      this._hospitalizationService.setExitPlacementEndDate(null);
      
      
  }

  endDateChange(event: any){
    this._hospitalizationService.setExitPlacementEndDate(event);
    this.exitEndDateEvent.emit(event);
  }
  
  endTimeChange(exitPlacementForm: any) {
    const endTime = exitPlacementForm.get("endtime").value
    this._hospitalizationService.setExitPlacementEndTime(endTime);
    this.exitEndTimeEvent.emit(endTime);
  }

  forminitialize() {
    if(this.children[0].placement.revisionupdate !== null && this.children[0].placement.revisionupdate.enddate !== null) {

      this.exitReasonKey = this.children[0].placement.revisionupdate.exitreasontypkey;
      
      this.exitPlacementForm = this.formBuilder.group({
        //transferagency: [''],
        placementtypekey: ['LA'],
        enddate: [this.children[0].placement.revisionupdate.enddate],
        endtime: [this.children[0].placement.revisionupdate.endtime],
        exittypekey:[this.children[0].placement.revisionupdate.exittypekey],
        exitreasontypekey:[this.children[0].placement.revisionupdate.exitreasontypkey],
        remarks:[this.children[0].placement.revisionupdate.remarks],
        leastrestrictiveplacement:[this.children[0].placement.revisionupdate.leastrestrictiveplacement],       
        transferagency :[this.children[0].placement.revisionupdate.transferagency],
        otherpublicagency : [this.children[0].placement.revisionupdate.otherpublicagency],
        placementdisposableortrashbag :[' '],
        ladisposableortrashbag: [' '],
        exitluggage: [], 
        exitluggageprovided :[],
        exitluggagecomments :[],
        exitdisposableortrashbag: [],

                  
      });
     
      
      if(this.children[0].placement.revisionupdate.exittypekey != null) {
        this.onExitTypeChange(false);
      }

      this.exitService.exitPlacementForm = this.exitPlacementForm;

    }
    
  }

  loadDropDowns() {
     this.exitService.getreasontype().subscribe(result => {
       this.reasonforexit = result.filter(item=>item.activeflag === 1)
       const age = moment().diff(this.children[0].dob, 'years');
       if (age < 18 ) {
         this.reasonforexit  = this.reasonforexit .filter((item: { ref_key: string; }) => item.ref_key !== 'RNAWAY');
        }
       this.reasonforexit.sort((a: any, b: any) => a.description.localeCompare(b.description));
      }) ;
      
      
      this.exitService.gettransferagency().subscribe(result => {
        this.transferagencies = result.filter(item=>item.activeflag === 1)
        this.transferagencies.sort((a: any, b: any) => a.description.localeCompare(b.description));
       }) ;

    this.exitService.getExitTypes() .subscribe(result => {
      if (result && result.length) {
        this.exitTypes = result;
      }

    });
  }

  getDates() {
    this._commonHttpService.getSettings(['KRD_startdate','KRD_enddate']).subscribe(
      (res: any) => {
        this.KRD_startdate = res.settings?.find((e: { settingname: string; }) => e.settingname === 'KRD_startdate')?.settingvalue;
        this.KRD_enddate = res.settings?.find((e: { settingname: string; }) => e.settingname === 'KRD_enddate')?.settingvalue;
        if (this.children && this.children.length
          && this.children[0].placement
           && this.children[0].placement.providerdetails 
           && this.children[0].placement.providerdetails.provider_id) {        
          if(this.children[0].placement.service_id == '9' ) {
             this.exitMaxDate = new Date(this.KRD_enddate);
          } else if(this.children[0].placement.service_id == '530' || this.children[0].placement.service_id == '531' ) {
            this.exitMinDate = new Date(this.KRD_startdate);
         }
       }
        
        return res;
      },
      (error: any) => {
        console.error('Error fetching setting:', error);
      }
    );
  }

 
  onExitReasonTypeChange(status: any) {
    if(status){
      this.exitPlacementForm.patchValue({
        transferagency: null,
        otherpublicagency: null
      })
    }
    // setting transfer agency non mandatory when reason type selected other than transfer to another non dhs agency.
    const exitReasonTypeKey = this.exitPlacementForm.getRawValue().exitreasontypekey;
    if (exitReasonTypeKey == PlacementConstants.REASON_FOR_EXIT.TRANSFER_TO_ANOTHER_NON_DHS) {
      this.transferAgencyRequried = true;
    } else {
      this.transferAgencyRequried = false;
      this.exitPlacementForm.get('transferagency')?.markAsUntouched();
      this.exitPlacementForm.get('transferagency')?.setErrors(null);
    }
  }


  ontransferagencyChange(){
    this.exitPlacementForm.patchValue({
      otherpublicagency:null
    })
  }
  
  onExitTypeChange(status: any) {
    const exitTypeKey = this.exitPlacementForm.getRawValue().exittypekey;
    if (status) {
      this.exitPlacementForm.patchValue({
        exitreasontypekey: null,
        transferagency: null,
        otherpublicagency: null
      });
    }
    if (exitTypeKey === PlacementConstants.EXIT_TYPES.CHANGE_IN_PLACEMENT || exitTypeKey === PlacementConstants.EXIT_TYPES.PERM_LEAVING_CUSTODY) {
      this.reasonForExitRequired = true;
      this.exitPlacementForm.patchValue({
        exitreasontypekey: this.getexitreasontypekey(status)
      })
      this.exitPlacementForm.get('exitreasontypekey')?.enable();
      this.exitPlacementForm.get('exitreasontypekey')?.setValidators([Validators.required]);
      if (exitTypeKey === PlacementConstants.EXIT_TYPES.CHANGE_IN_PLACEMENT) {
        this.exitService.getReasonForExit(exitTypeKey).subscribe(result => {
          if (result && result.length) {
            this.reasonsForExit = result;
          }
        });
      }
      else if (exitTypeKey === PlacementConstants.EXIT_TYPES.PERM_LEAVING_CUSTODY) {
        this.reasonsForExit = this.reasonforexit;
      }
    } else {
      this.reasonForExitRequired = false;
      this.exitPlacementForm.get('exitreasontypekey')?.disable();
      this.exitPlacementForm.get('exitreasontypekey')?.clearValidators();
      this.reasonsForExit = [];
    }
    this.exitPlacementForm.get('exitreasontypekey')?.updateValueAndValidity();
    if (PlacementConstants.EXIT_TYPES.OTHER === exitTypeKey) {
      this.commentsRequired = true;
    } else {
      this.commentsRequired = false;
    }
  }

  getexitreasontypekey(status: any){
    return (this.exitReasonKey && !status) ? this.exitReasonKey : null;
  }
timeToMinutes(time: string): number {
  const [hours, minutes] = time.split(':').map(Number);
  return hours * 60 + minutes;
}
  timechange() {

    const currentTime = moment(new Date()).format("HH:mm");
    const currentDate = moment(new Date()).format(this.dtformat);
    const givenDate = moment(this.exitPlacementForm.getRawValue().enddate).format(this.dtformat);
    const givenTime = this.exitPlacementForm.getRawValue().endtime;

    if(givenTime !== null && this.timeToMinutes(currentTime) < this.timeToMinutes(givenTime) && currentDate === givenDate) {
      this._alertService.error('End date & time should be less than the current time');
      this.exitPlacementForm.patchValue({endtime: null});
    } else if(givenTime !== null && this.timeToMinutes(this.startTime) > this.timeToMinutes(givenTime) && this.startDate === givenDate) {
      this._alertService.error('Exit date & time should be greater than the start date & time');
      this.exitPlacementForm.patchValue({endtime: null});
    }
    
  }

  // checkProviderPreAdoptive() {
  //   //if provider has pre-finalized adoptive then good else show error message and reset flag value
  //   if(this.isproviderpreadoptive) {
  //     this.changePreAdoptiveMsg = 'This will end current placement and start a new placement with same provider Pre-Finalized Adoptive Home placement structure.'
  //   } else {
  //     this.changePreAdoptiveMsg = 'The current provider does not have pre-adoptive home approval. Please contact provider resource workers.'
  //     this.exitPlacementForm.patchValue({
  //       ischangepreadoptive : null
  //     });
  //   }
  // }
  openexitreasoninfo(){
    (<any>$('#open-location-of-infobox')).modal('show');
  }
  closeinfobox(){
    (<any>$('#open-location-of-infobox')).modal('hide');
  }
  luggagebuttonreset(value: any){
    if(value ===1){

      this.exitPlacementForm.patchValue({
        exitluggageprovided :null,
       exitluggagecomments:null,
        exitdisposableortrashbag :null

      })
      
      const plluggagepurchasedTemp: any = this.exitPlacementForm.get('exitluggageprovided');
      plluggagepurchasedTemp.clearValidators();
      plluggagepurchasedTemp.updateValueAndValidity();
    
    }
      if(value ===2){
        this.exitPlacementForm.patchValue({
          exitdisposableortrashbag :null, 
         exitluggagecomments:null
  
        })

      }
    
      const luggagecomments: any = this.exitPlacementForm.get('exitluggagecomments');
      const placementdisposableortrashbag: any =this.exitPlacementForm.get('exitdisposableortrashbag');
      luggagecomments.clearValidators();
      luggagecomments.updateValueAndValidity();
      placementdisposableortrashbag.clearValidators();
      placementdisposableortrashbag.updateValueAndValidity();
  }

}