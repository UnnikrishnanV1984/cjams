export class FileUtils {
    public static getFileName(fileExtension:any) {
        const currentDate = new Date();
        return (
            'DHS-' +
            currentDate.getUTCFullYear() +
            currentDate.getUTCMonth() +
            currentDate.getUTCDate() +
            '-' +
            this.getRandomString() +
            '.' +
            fileExtension
        );
    }

    public static getRandomString() {
        // Use the Web Crypto API to generate a secure random value
    const array = new Uint32Array(1);
    window.crypto.getRandomValues(array);
    const randomValue = array[0] * new Date().getTime(); // Combine with current time for additional randomness

    // Convert to base36 and remove the '.' character
    return randomValue.toString(36).replace(/\./g, '');
    }
    public static generateAccountNo(): number {
        // Create a Uint32Array of length 1 to store our random value
        const array = new Uint32Array(1);
        // Use the Web Crypto API to fill the array with cryptographically secure random numbers
        window.crypto.getRandomValues(array);
        // Convert the random value to ensure it falls within the desired range (between 100000000 and 99999999)
        return 100000000 + array[0] % 90000000;
      }
//     public static generateAccountNo() {
     
    public static generateAccountNumber() {
        const numbers :number[]= [];
        let randomnumber;
        do {
            // Use the Web Crypto API to generate a secure random number
    const array = new Uint32Array(1);
    window.crypto.getRandomValues(array);
    randomnumber = Math.floor(array[0] / (0xffffffff + 1) * (999999 - 100000 + 1)) + 100000;
        } while (numbers.includes(randomnumber));
        numbers.push(randomnumber);
        return randomnumber;
      }

      static newGuid() {
        const cryptoObj = window.crypto ; // for IE 11
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
            // Use crypto API for secure random numbers
            const r = cryptoObj.getRandomValues(new Uint8Array(1))[0] % 16;
            const v = c === 'x' ? r : (r & 0x3 | 0x8);
            return v.toString(16);
        // return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        //     var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
        //     return v.toString(16);
    });}
}
