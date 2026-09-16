import { Component, Inject } from "@angular/core";
import { MatDialogRef, MAT_DIALOG_DATA } from "@angular/material/dialog";

@Component({
    selector: 'primary-phone-number-dialog',
    templateUrl: './primary-phone-number-dialog.component.html',
    styleUrls: ['./primary-phone-number-dialog.component.scss'],
    standalone: false
})
export class PrimaryPhoneNumberDialogComponent {
  constructor(
    public dialogRef: MatDialogRef<PrimaryPhoneNumberDialogComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any) {
  }

  onCancel(): void {
    this.dialogRef.close();
  }

  onConfirm(): void {
    this.dialogRef.close(true);
  }
}