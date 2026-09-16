import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ScanAttachemntComponent } from './scan-attachemnt.component';

describe('ScanAttachemntComponent', () => {
  let component: ScanAttachemntComponent;
  let fixture: ComponentFixture<ScanAttachemntComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ScanAttachemntComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ScanAttachemntComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
