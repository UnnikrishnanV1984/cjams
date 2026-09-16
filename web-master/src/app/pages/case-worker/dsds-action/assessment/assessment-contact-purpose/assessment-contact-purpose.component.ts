import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';

@Component({
    selector: 'assessment-contact-purpose',
    templateUrl: './assessment-contact-purpose.component.html',
    styleUrls: ['./assessment-contact-purpose.component.scss'],
    imports:[MatFormFieldModule,MatInputModule,CommonModule],
    standalone: true
})
export class AssessmentContactPurposeComponent {
  @Input() icon!: boolean;
  openContactPurpose() {
    (<any>$('#contact-purpose')).modal('show');
  }
  CloseContactPurpose() {
    (<any>$('#contact-purpose')).modal('hide');
  }
}