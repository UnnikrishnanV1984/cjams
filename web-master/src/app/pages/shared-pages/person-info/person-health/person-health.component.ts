import { Component, OnInit } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { PersonHealthService } from './person-health.service';
import { Router, ActivatedRoute } from '@angular/router';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-health',
    templateUrl: './person-health.component.html',
    styleUrls: ['./person-health.component.scss'],
    standalone: false
})
export class PersonHealthComponent implements OnInit {

    physicianForm!: FormGroup;
    healthSections: any[] = [];
    djshealthSections: any[] = [
        { id: 'physician-information', name: 'Physician Information', isActive: true },
        { id: 'health-insurance-information', name: 'Health Insurance Information', isActive: false },
        { id: 'medication-including-psychotropic', name: 'Medication Including Psychotropic', isActive: false },
        { id: 'health-examination', name: 'Health Examination/Evaluations', isActive: false },
        { id: 'medical-conditions', name: 'Medical Conditions', isActive: false },
        { id: 'behavioral-health-info', name: 'Behavioral Health Info', isActive: false },
        { id: 'history-of-abuse', name: 'History of Abuse', isActive: false },
        { id: 'substance-abuse', name: 'Substance Abuse', isActive: false },   
        { id: 'log', name: 'Log', isActive: false }
    ];
    cwhealthSections: any[] = [
        { id: 'person-health-summary-cw', name: 'Person Health Summary', isActive: false, path: 'person-health-summary' },
        { id: 'examination-cw', name: 'Examination', isActive: false, path: 'examination' },
        { id: 'birth-information-cw', name: 'Birth/Neonatal Information', isActive: false, path: 'birth-info' },
        { id: 'sexual-information-cw', name: 'Reproductive Health', isActive: false, path: 're-productive-health' },
        { id: 'hospitalization-cw', name: 'Hospitalization', isActive: false, path: 'hospitalization' },
        { id: 'immunization-cw', name: 'Immunization', isActive: false, path: 'immunization' },
        { id: 'behavioral-health-info-cw', name: 'Behavioral Health/Substance Use', isActive: false, path: 'behavioral-health' },

        { id: 'person-disability-cw', name: 'Disabilities/Special Needs', isActive: false, path: 'disability' },

        { id: 'family-history-cw', name: 'Family History', isActive: false, path: 'family-history' },
        { id: 'feeding-info', name: 'Feeding Information', isActive: false, path: 'feeding-info' },


        { id: 'insurance-information-cw', name: 'Insurance Information', isActive: false, path: 'insurance-info' },
        { id: 'medical-conditions-cw', name: 'Conditions/Disorders', isActive: false, path: 'diseases-conditions' },
        { id: 'medication-including-psychotropic-cw', name: 'Medication Including Psychotropic', isActive: false, path: 'medication-psychotropic' },

        { id: 'provider-dental-information-cw', name: 'Provider Information', isActive: false, path: 'provider-info' },
        { id: 'mobility-speech', name: 'Mobility/Speech', isActive: false, path: 'mobility-speech' },
        { id: 'sleeping-info-cw', name: 'Sleeping', isActive: false, path: 'sleeping-info' },
        { id: 'elimination-info-cw', name: 'Elimination', isActive: false, path: 'elimination' },
        { id: 'health-passport-cw', name: 'Health Passport', isActive: false, path: 'health-passport' },

    ];


    selectedHealthSection: any;
    physicianEditInd = -1;


    constructor(
        public healthService: PersonHealthService,
        private _router: Router,
        private route: ActivatedRoute) {
    }

    ngOnInit() {
        const path: any = this._router.url.split('/').pop();
        const queryParams = this.route.snapshot.queryParams;
        const currentPath = this.cwhealthSections.find(item => path.includes(item.path));
        this.healthSections = this.cwhealthSections;
        this.showHealthSection(currentPath ? currentPath : this.healthSections[0], queryParams);
        this.healthService.getActiveSection().subscribe(sectionId => {
            const section = this.healthSections.find(sec => sec.id === sectionId);
            if (section) {
                this.showHealthSection(section);
            }
        });
    }

    showHealthSection(healthSection: any, queryParams?: any) {
        this.healthSections.forEach(section => section.isActive = false);
        healthSection.isActive = true;
        this.selectedHealthSection = healthSection;
        this._router.navigate([healthSection.path], { relativeTo: this.route, queryParams });
    }
}

