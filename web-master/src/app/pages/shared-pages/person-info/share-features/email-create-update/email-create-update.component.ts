import { Component, OnInit, Input, EventEmitter, Output  } from '@angular/core';

@Component({
    selector: 'email-create-update',
    templateUrl: './email-create-update.component.html',
    styleUrls: ['./email-create-update.component.scss'],
    standalone: false
})
export class EmailCreateUpdateComponent implements OnInit {

  @Input() list: any[]=[];
  @Output() emiallistemit: EventEmitter<any> = new EventEmitter();

  ngOnInit() {
    //No operation needed here
  }


  emailvalue(event:any)
  {
    this.emiallistemit.emit(this.list);
  }


}
