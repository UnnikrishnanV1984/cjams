import { Component, EventEmitter, Injector, Input, OnInit, Output, SimpleChanges } from '@angular/core';
import { Title4eService } from '../services/title4e.service';
import { SessionStorageService } from '../../../@core/services';


@Component({
  selector: 'dashboard-widget',
  templateUrl: './dashboard-widget.component.html',
  styleUrls: ['./dashboard-widget.component.scss'], 
  standalone: false
})
export class DashboardWidgetComponent implements OnInit {
  @Output() selectedprogress = new EventEmitter<string>();
  @Output() selectedeligibility = new EventEmitter<string>();
  @Input() widgetcount : any;
  @Input() totalcount!:number;
  @Input() type!:string
  @Input() userRole!:string;
  @Input() hideunassigned : any;
  
unassigned ={percent:0,count:0};
pending ={percent:0,count:0};
completed ={percent:0,count:0};
overdue ={percent:0,count:0};
duecount ={percent:0,count :0};
approvedcount={percent:0,count :0};
pendingcount={percent:0,count :0};
rejectedcount={percent:0,count :0};
  showcompleted: boolean=false;
  selectedbox: any;
  progressselected!: any;
  activeModule: any = null;

  private titleIVeService: Title4eService;
  private _sessionStorage: SessionStorageService;

  constructor(private injector :Injector) { 
    this.titleIVeService = this.injector.get<Title4eService>(Title4eService);
    this._sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
  }

  ngOnInit(): void {

    // this.unassigned.count=this.widgetcount?.unassignedcount;
    this.titleIVeService.activevalue$.subscribe(value=>{
      this.progressselected =value;
    });
    this.titleIVeService.activeeligibility$.subscribe(value=>{
      this.selectedbox =value;
      // this.eligibilitystatus(value);
    });
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.setUserRole();
    
    if (this.widgetcount && this.totalcount ) {
    this.unassigned ={percent:this.calculatepercentage(this.widgetcount?.unassignedcount,this.totalcount),count:this.widgetcount?.unassignedcount};
    this.pending= {percent:this.calculatepercentage(this.widgetcount?.pendingcount,this.totalcount),count:this.widgetcount?.pendingcount} 
    this.completed = {percent:this.calculatepercentage((this.widgetcount?.enrcount + this.widgetcount?.ercount + this.widgetcount?.ineligibilecount),this.totalcount),count:this.widgetcount?.enrcount + this.widgetcount?.ercount + this.widgetcount?.ineligibilecount} 
    }
  }
  ngOnChanges(changes: SimpleChanges): any {
    if (changes['widgetcount']) {
      
        if (this.widgetcount && this.totalcount ) {
          if(this.type ==='Approvals'){
            this.approvedcount={percent:this.calculatepercentage(this.widgetcount?.approvedcount,this.totalcount),count:this.widgetcount?.approvedcount};
          this.rejectedcount= {percent:this.calculatepercentage(this.widgetcount?.rejectedcount,this.totalcount),count:this.widgetcount?.rejectedcount};
          this.pendingcount= {percent:this.calculatepercentage(this.widgetcount?.pendingcount ,this.totalcount),count:this.widgetcount?.pendingcount}  
          }
          // this.unassigned ={percent:Math.round(((this.widgetcount?.unassignedcount/this.totalcount)*100)),count:this.widgetcount?.unassignedcount};
          // this.pending= {percent:Math.round(((this.widgetcount?.pendingcount/this.totalcount)*100)),count:this.widgetcount?.pendingcount} 
          // this.completed = {percent:Math.round((((this.widgetcount?.enrcount + this.widgetcount?.ercount + this.widgetcount?.ineligibilecount)/this.totalcount)*100)),count:this.widgetcount?.enrcount + this.widgetcount?.ercount + this.widgetcount?.ineligibilecount} 
          // this.overdue ={percent:Math.round(((this.widgetcount?.overduecount/this.totalcount)*100)),count:this.widgetcount?.overduecount};
          // this.duecount= {percent:Math.round(((this.widgetcount?.duecount/this.totalcount)*100)),count:this.widgetcount?.duecount} 


          this.unassigned ={percent:this.calculatepercentage(this.widgetcount?.unassignedcount,this.totalcount),count:this.widgetcount?.unassignedcount};
          this.pending= {percent:this.calculatepercentage(this.widgetcount?.pendingcount,this.totalcount),count:this.widgetcount?.pendingcount} 
          this.completed = {percent:this.calculatepercentage((this.widgetcount?.enrcount + this.widgetcount?.ercount + this.widgetcount?.ineligibilecount),this.totalcount),count:this.widgetcount?.enrcount + this.widgetcount?.ercount + this.widgetcount?.ineligibilecount} 
          this.overdue ={percent:this.calculatepercentage(this.widgetcount?.overduecount,this.totalcount),count:this.widgetcount?.overduecount};
          this.duecount= {percent:this.calculatepercentage(this.widgetcount?.duecount,this.totalcount),count:this.widgetcount?.duecount} 

          //  this.overdue ={percent:Math.round(((this.widgetcount?.overduecount/this.totalcount)*100)),count:this.widgetcount?.overduecount};
          // this.duecount= {percent:Math.round(((this.widgetcount?.duecount/this.totalcount)*100)),count:this.widgetcount?.duecount} 

        }else {
          this.unassigned ={percent:0,count:0};
          this.pending ={percent:0,count:0};
          this.completed ={percent:0,count:0};
          this.overdue ={percent:0,count:0};
          this.duecount ={percent:0,count :0}
          this.approvedcount ={percent:0,count:0};
          this.rejectedcount ={percent:0,count:0};
          this.pendingcount ={percent:0,count :0}
        }
        
    }
}


setUserRole(): void {
  if (this.activeModule === '4E SUPERVISOR' || this.activeModule === '4E QA' || this.activeModule === '4E Adminstrator' || this.activeModule === '4E AdminAssist') {
      this.userRole = 'ive-supervisor';

  } else if (this.activeModule === '4E Analyst' || this.activeModule === '4E SPECIALIST') {
      this.userRole = 'ive-specialist';
  }
}

//completed ={percent:3,count:10};

calculatepercentage(widgetcount: number,totalcount: number){
  if(!widgetcount || !totalcount){ 
    return 0;
  }
  return Math.round((widgetcount/totalcount)* 100 *100) /100;
  

}
filterlist(type:string){
  this.progressselected =type;
 this.showcompleted =true;
 this.titleIVeService.setprogressselectedactive(type);
this.selectedprogress.emit(type);


}
eligibilitystatus(eligibility:any){
  this.selectedeligibility.emit(eligibility);
  this.selectedbox =eligibility;
  this.titleIVeService.seteligibilityselectedactive(eligibility);
  this.selectedeligibility.emit(eligibility);
}
}
