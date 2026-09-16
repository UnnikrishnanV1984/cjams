import { Component, EventEmitter, Injector, Input, OnInit, Output, SimpleChanges } from '@angular/core';
import { DataStoreService } from '../../../@core/services';

@Component({
  selector: 'widget-component',
  templateUrl: './widget-component.component.html',
  styleUrls: ['./widget-component.component.scss'],
  standalone: false
})
export class WidgetComponentComponent implements OnInit {
   @Input() totalcountlist:any ={};
  @Input() progressselected :string | undefined;
  @Input()userRole:string | undefined;
  @Input() widgetlist:any={}
  @Input() reset:boolean | undefined
  @Output() Gridselected = new EventEmitter<string>();
  @Output() selectedeligibility = new EventEmitter<string>();

  selectedGrid='FosterCare';
  private _dataStore: DataStoreService;

  constructor(private injector: Injector) {
    this._dataStore = this.injector.get<DataStoreService>(DataStoreService)

  }

  ngOnInit(): void {
    if(this._dataStore.getData('titleiveselectedgrid')){
      this.selectedGrid =this._dataStore.getData('titleiveselectedgrid')
  }else {
    this.selectedGrid ='FosterCare';
  }
}
  
displayList(value:string){

this.selectedGrid=value;
this.Gridselected.emit(value);
this.progressselected ='';
this._dataStore.setData('titleiveselectedgrid','');
}

checkifloaded(item:string) {
  return this.totalcountlist.hasOwnProperty(item)
}

}
