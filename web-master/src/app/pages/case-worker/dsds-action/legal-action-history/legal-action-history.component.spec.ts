import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { LegalActionHistoryComponent } from './legal-action-history.component';

describe('LegalActionHistoryComponent', () => {
  let component: LegalActionHistoryComponent;
  let fixture: ComponentFixture<LegalActionHistoryComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ LegalActionHistoryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LegalActionHistoryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
