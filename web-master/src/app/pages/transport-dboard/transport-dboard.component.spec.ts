import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { TransportDboardComponent } from './transport-dboard.component';

describe('TransportDboardComponent', () => {
  let component: TransportDboardComponent;
  let fixture: ComponentFixture<TransportDboardComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ TransportDboardComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TransportDboardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
