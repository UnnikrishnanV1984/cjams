import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class RandomIdGeneratorService {

  generateRandomId(): string {
    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
    const segments = [8, 4, 4, 4, 12];
    const randomBytes = new Uint8Array(16);
    const randomIdSegments: string[] = [];

    crypto.getRandomValues(randomBytes);

    let cursor = 0;
    segments.forEach((segmentLength, index) => {
        const segmentChars: string[] = [];
        for (let i = 0; i < segmentLength; i++) {
            const randomIndex = randomBytes[cursor] % characters.length;
            segmentChars.push(characters[randomIndex]);
            cursor = (cursor + 1) % randomBytes.length;
        }
        randomIdSegments.push(segmentChars.join(''));
    });

    return randomIdSegments.join('-');
  }
}
