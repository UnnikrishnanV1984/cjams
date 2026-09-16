import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PersonInfoComponent } from './person-info.component';




const routes: Routes = [
  {
    path: '',
    component: PersonInfoComponent,
    children: [
      {
        path: '',
        redirectTo: 'profile',
        pathMatch: 'full'
      },
      {
        path: 'profile',
        loadChildren: () => import( '././person-profile/person-profile.module').then(m => m.PersonProfileModule)
      },
      {
        path: 'address',
        loadChildren: () => import( '././address-details/address-details.module').then(m => m.AddressDetailsModule)
      },
      {
        path: 'living-arrangement',
        loadChildren: () => import( './living-arrangement-details/living-arrangement-details.module').then(m => m.LivingArrangementModule)
      },
      {
        path: 'contacts',
        loadChildren: () => import( './contact-info/contact-info.module').then(m => m.ContactInfoModule)
      },
      {
        path: 'education',
        loadChildren: () => import( './education/education.module').then(m => m.EducationModule)
      },
      {
        path: 'health',
        loadChildren: () => import( './person-health/person-health-info.module').then(m => m.PersonHealthInfoModule)
      },
      {
        path: 'employment',
        loadChildren: () => import( './employment-profile/employment-profile.module').then(m => m.EmploymentProfileModule)
      },
      {
        path: '18-21',
        loadChildren: () => import( './eighteen21/eighteen21.module').then(m => m.Eighteen21Module)
      },
      {
        path: 'finance',
        loadChildren: () => import( './finance/person-finance.module').then(m => m.PersonFinanceModule)
      },
      {
        path: 'military',
        loadChildren: () => import( './military/military.module').then(m => m.MilitaryModule)
      },
      {
        path: 'mdm-person-info',
        loadChildren: () => import( './mdm-person-info/mdm-person-info.module').then(m => m.MdmPersonInfoModule)
      },
      {
        path: 'life-skills-assessment',
        loadChildren: () => import( './life-skills-assessment/life-skills-assessment.module').then(m => m.LifeSkillsAssessmentModule)
      },
      { 
        path: 'nytd', 
        loadChildren: () => import( '../../shared-pages/nytd/nytd-survey.module').then(m => m.NytdSurveyModule)
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PersonInfoRoutingModule { }
