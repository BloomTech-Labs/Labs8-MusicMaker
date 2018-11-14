var QRCode = require('qrcode');

// this is the general QR code creation function, takes a string and returns the code

let code = QRCode.toString('test', function (err, string) {
  if(err) throw err;
  console.log(string);
  return(string);
});

// this is the version we'll want to store in the database

let data = QRCode.toDataURL('test', function (err, url) {
  if(err) throw err;
  console.log(url);
  return(url);
});

return code;
return data;
