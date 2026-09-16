import { Component, Inject, OnInit } from "@angular/core";
import { MatDialogRef, MAT_DIALOG_DATA } from "@angular/material/dialog";
import { AlertService } from '../../../@core/services';
@Component({
  selector: 'person-record-pop-up',
  templateUrl: './person-record-pop-up.component.html',
  styleUrls: ['./person-record-pop-up.component.scss']
})
export class PersonRecordPopUpComponent implements OnInit {

  selectedPerson: any;

  constructor(
    public dialogRef: MatDialogRef<PersonRecordPopUpComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private _alertService: AlertService,
  ){
  }

  ngOnInit(): void {}

  close(): void{
    this.dialogRef.close();
  }

  selectPerson(p) {
    this.selectedPerson = p;
  }

  validateSelectedPerson() {
    if (this.selectedPerson) {
      this.dialogRef.close({person: this?.data?.person, action: 'validateSelectedPerson'});
    } else {
      this._alertService.error('Please select person');
    }
  }


}