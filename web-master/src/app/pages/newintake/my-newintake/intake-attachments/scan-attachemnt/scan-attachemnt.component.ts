import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from "@angular/router";
import {  DataStoreService } from '../../../../../@core/services';
import { IntakeStoreConstants } from '../../my-newintake.constants';
@Component({
    selector: 'scan-attachemnt-new',
    templateUrl: './scan-attachemnt.component.html',
    standalone: false
})
export class ScanAttachemntComponent implements OnInit {
  private store: any;
  intakeNumber!: string;
  constructor( private router: Router, private route:ActivatedRoute,
    private _store: DataStoreService,) { 
      this.store = this._store.getCurrentStore();
    }

  ngOnInit(): void {
  this.intakeNumber = this.store[IntakeStoreConstants.intakenumber] ? this.store[IntakeStoreConstants.intakenumber] :this.route?.snapshot?.parent?.parent?.parent?.params['id'];
}


  modalDismiss() {
    (<any>$('#upload-scan-attachment')).modal('hide');
    const currentUrl = '/pages/newintake/my-newintake/' + this.intakeNumber + '/edit/attachment'
    this.router.navigate([currentUrl]);
  }

}
