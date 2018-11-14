var QRCode = require('qrcode');

// this is the general QR code creation function, takes a string and returns the code

QRCode.toString('test', function (err, string) {
  if(err) throw err;
  console.log(string);
  return(string);
})
