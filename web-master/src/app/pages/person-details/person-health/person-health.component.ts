import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../../@core/services';
import { Router } from '@angular/router';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-health',
    host: {
        class: 'person-health'
    },
    templateUrl: './person-health.component.html',
    styleUrls: ['./person-health.component.scss'],
    standalone: false
})
export class PersonHealthComponent implements OnInit {
  substanceabuse = 'substance-abuse';
  providerdentalinformation = 'provider-dental-information';
  healthSections: any[] = [];
  djshealthSections = [
    { id: 'physician-information', name: 'Physician Information', isActive: true , 'route': 'physician'},
    { id: 'health-insurance-information', name: 'Medical Insurance Information', isActive: false, 'route': 'health-insurance' },
    { id: 'medication-including-psychotropic', name: 'Medications', isActive: false, 'route': 'medication-psychotropic'},
    { id: 'health-examination', name: 'Medical Exams/Health Evaluations', isActive: false, 'route': 'health-examination' },
    { id: 'medical-conditions', name: 'Medical Conditions', isActive: false, 'route': 'medical-conditions' },
    { id: 'behavioral-health-info', name: ' Behavioral /Mental Health Situation/ Assessments', isActive: false, 'route': 'behavioral-health-info' },
    { id: 'history-of-abuse', name: 'History of Abuse', isActive: false, 'route': 'history-of-abuse' },
    { id: this.substanceabuse, name: 'Substance Use / Abuse Assessments', isActive: false, 'route': this.substanceabuse },
    { id: this.providerdentalinformation, name: 'Dental', isActive: false, 'route': this.providerdentalinformation},
    { id: this.providerdentalinformation, name: 'Vision', isActive: false, 'route': 'vision'},
    { id: this.providerdentalinformation, name: 'Immunizations', isActive: false, 'route': 'immunization'}
   /*  { id: 'log', name: 'Log', isActive: false,  'route': 'logs' } */
  ];

  cwhealthSections = [
    { id: 'provider-dental-information-cw', name: 'Provider Information', isActive: true, 'route': 'provider-dental-information-cw'},
    { id: 'insurance-information-cw', name: 'Insurance Information', isActive: false, 'route': 'insurance-information-cw' },
    { id: 'medication-including-psychotropic-cw', name: 'Medication Including Psychotropic', isActive: false, 'route': 'medication-including-psychotropic-cw' },
    { id: 'medical-conditions-cw', name: 'Medical Conditions', isActive: false, 'route': 'medical-conditions-cw' },
    { id: 'behavioral-health-info-cw', name: 'Behavioral Health Info', isActive: false , 'route': 'behavioral-health-info-cw'},
    { id: this.substanceabuse, name: 'Substance Abuse', isActive: false, 'route': this.substanceabuse},
  ];

  isDJS = false;
  selectedHealthSection: any;
  constructor(private _authService: AuthService, private router: Router) { }

  ngOnInit() {
    this.isDJS = this._authService.isDJS();

    if (this.isDJS) {
      this.healthSections = this.djshealthSections;
    } else {
      this.healthSections = this.cwhealthSections;
    }


  }
  showHealthSection(healthSection: any) {
    this.healthSections.forEach(section => section.isActive = false);
    healthSection.isActive = true;
    this.selectedHealthSection = healthSection;
  }

}
