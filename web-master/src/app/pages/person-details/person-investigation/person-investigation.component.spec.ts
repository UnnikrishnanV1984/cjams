import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonInvestigationComponent } from './person-investigation.component';

describe('PersonInvestigationComponent', () => {
  let component: PersonInvestigationComponent;
  let fixture: ComponentFixture<PersonInvestigationComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonInvestigationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonInvestigationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
