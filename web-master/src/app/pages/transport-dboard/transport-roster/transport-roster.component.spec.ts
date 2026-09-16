import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { TransportRosterComponent } from './transport-roster.component';

describe('TransportRosterComponent', () => {
  let component: TransportRosterComponent;
  let fixture: ComponentFixture<TransportRosterComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ TransportRosterComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TransportRosterComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
