import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';

@Component({
    selector: 'living-arrangment-details',
    templateUrl: './living-arrangment-details.component.html',
    styleUrls: ['./living-arrangment-details.component.scss'],
    standalone: false
})
export class LivingArrangmentDetailsComponent implements OnInit {

  @Input() child: any;
  @Output() 
  dischargeDateEvent = new EventEmitter();
  @Output()
  hospitalizationFormEvent = new EventEmitter();
  hospitalizationData: any;
  @Output()
  hospitalizationFormStatusEvent = new EventEmitter();
  hospitalizationFormStatus = true;

  ngOnInit() {
    this.hospitalizationData = this.child?.placement?.placementrevision?.[0]?.hospitalizationdetails ?? null;
  }

  getwhereabouts(value: any) {
    let whereabouts = 'Unknown'
    if(value == 'instate') {
      whereabouts = 'In State';
    } else if(value == 'outstate') {
      whereabouts = 'Out State';
    } else if(value == 'outcountry') {
      whereabouts = 'Out Of Country';
    } 
    return whereabouts;
  }

  handleDischargeDateEvent(value: any){

    this.dischargeDateEvent.emit(value);


  }
  updateHospitalizationFormValues(event: any){
    
    this.hospitalizationFormEvent.emit( event);

  }


  getHospitalizationForm(event: any){
    this.hospitalizationFormStatus = event;
    this.hospitalizationFormStatusEvent.emit( event);
  }

}