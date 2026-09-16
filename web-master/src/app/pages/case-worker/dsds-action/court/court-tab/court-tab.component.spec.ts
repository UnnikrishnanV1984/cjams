import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CourtTabComponent } from './court-tab.component';

describe('CourtTabComponent', () => {
  let component: CourtTabComponent;
  let fixture: ComponentFixture<CourtTabComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CourtTabComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CourtTabComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
