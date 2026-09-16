import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InvestigationAppealComponent } from './investigation-appeal.component';

describe('InvestigationAppealComponent', () => {
  let component: InvestigationAppealComponent;
  let fixture: ComponentFixture<InvestigationAppealComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InvestigationAppealComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InvestigationAppealComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
