import { Component, Input } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import moment from 'moment';

@Component({
    selector: 'provider-placment-details',
    templateUrl: './provider-placment-details.component.html',
    styleUrls: ['./provider-placment-details.component.scss'],
    standalone: false
})
export class ProviderPlacmentDetailsComponent {

  @Input() child: any;
  constructor(private router: Router, private route: ActivatedRoute) { }

  formatPhoneNumber(phoneNumberString: any) {
    const cleaned = ('' + phoneNumberString).replace(/\D/g, '');
    const match = cleaned.match(/^(\d{3})(\d{3})(\d{4})$/);
    if (match) {
      return '(' + match[1] + ') ' + match[2] + '-' + match[3];
    }
    return null;
  }

  settimein12hr(strtime: any) {
    if (strtime && moment(new Date(strtime), 'HH:mm', true).isValid()) {
      return moment(new Date(strtime), 'HH:mm', true).toDate();
    }
  }


}
