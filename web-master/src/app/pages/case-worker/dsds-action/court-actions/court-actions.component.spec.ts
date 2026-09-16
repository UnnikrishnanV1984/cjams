import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CourtActionsComponent } from './court-actions.component';

describe('CourtActionsComponent', () => {
  let component: CourtActionsComponent;
  let fixture: ComponentFixture<CourtActionsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CourtActionsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CourtActionsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
