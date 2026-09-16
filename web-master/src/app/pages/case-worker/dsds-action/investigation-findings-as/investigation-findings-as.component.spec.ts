import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InvestigationFindingsAsComponent } from './investigation-findings-as.component';

describe('InvestigationFindingsAsComponent', () => {
  let component: InvestigationFindingsAsComponent;
  let fixture: ComponentFixture<InvestigationFindingsAsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InvestigationFindingsAsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InvestigationFindingsAsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
