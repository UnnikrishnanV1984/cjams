import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { EligibleWorksheetFormComponent } from './eligible-worksheet-form.component';

describe('EligibleWorksheetFormComponent', () => {
  let component: EligibleWorksheetFormComponent;
  let fixture: ComponentFixture<EligibleWorksheetFormComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ EligibleWorksheetFormComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(EligibleWorksheetFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
