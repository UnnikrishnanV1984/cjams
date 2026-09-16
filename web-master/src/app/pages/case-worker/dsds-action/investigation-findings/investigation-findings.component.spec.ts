import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InvestigationFindingsComponent } from './investigation-findings.component';

describe('InvestigationFindingsComponent', () => {
  let component: InvestigationFindingsComponent;
  let fixture: ComponentFixture<InvestigationFindingsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InvestigationFindingsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InvestigationFindingsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
