import { Component, Input, Output, EventEmitter, OnChanges } from '@angular/core';
import { AlertService } from '../../../@core/services/alert.service';
@Component({
    selector: 'custom-search',
    templateUrl: './custom-search.component.html',
    styleUrls: ['./custom-search.component.scss'],
    standalone: false
})
export class CustomSearchComponent implements OnChanges {
@Input() searchKey?:any;
@Input() isReset = false;
@Input() placeholder: any;
@Input() isDateColumn: any;
@Output() searchEvent: EventEmitter<any> = new EventEmitter() ;

searchTemplateRef : any = null;

  constructor( private _alertservice: AlertService) {}

  ngOnChanges(): void {
    if (this.isReset) {
        if(this.searchTemplateRef) {
          this.searchTemplateRef.value  = ''
        } else {
          this.searchTemplateRef = null;
        }
    }
  }

  handleSearch(searchRef:any): void {
    this.searchTemplateRef = searchRef
    const  obj = {};
    (obj as any)[`${this.searchKey}`] =  searchRef.value ? searchRef.value : null ;

    if (this.searchKey !== 'cost_no'  &&  this.searchKey !== 'voucher'&& searchRef.value && searchRef.value.length < 1 ) {
     this._alertservice.error('Please enter at least 3 characters to proceed');
     this.isReset = false;
      return;
  }
  
    this.searchEvent.emit(JSON.stringify(obj))
  }



}
