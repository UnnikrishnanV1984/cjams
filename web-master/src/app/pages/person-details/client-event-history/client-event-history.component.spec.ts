import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ClientEventHistoryComponent } from './client-event-history.component';

describe('ClientEventHistoryComponent', () => {
  let component: ClientEventHistoryComponent;
  let fixture: ComponentFixture<ClientEventHistoryComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ClientEventHistoryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ClientEventHistoryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
