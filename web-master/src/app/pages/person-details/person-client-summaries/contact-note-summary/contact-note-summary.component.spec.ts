import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ContactNoteSummaryComponent } from './contact-note-summary.component';

describe('ContactNoteSummaryComponent', () => {
  let component: ContactNoteSummaryComponent;
  let fixture: ComponentFixture<ContactNoteSummaryComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ContactNoteSummaryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContactNoteSummaryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
