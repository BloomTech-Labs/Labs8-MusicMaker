var QRCode = require('qrcode');

// this is the general QR code creation function, takes a string and returns the code
// using both console logs and returns for testing purposes

let code = QRCode.toString('test', function (err, string) {
  if(err) throw err;
  console.log(string);
});

// this is the version we'll want to store in the database, returns the QR code data itself

let data = QRCode.toDataURL('test', function (err, url) {
  if(err) throw err;
  console.log(url);
});

return code;
return data;

// async versions for reference and implementation if desired

// promise

// let asyncData = QRCode.toDataURL('async test')
//   .then(url => {
//     console.log(url)
//     return(url)
//   })
//   .catch(err => {
//     console.error(err.message)
//   });
//
// // await
//
// const asyncAwait = async url => {
//   try {
//     console.log(await QRCode.toDataURL(url))
//   } catch (err) {
//     console.error(err.message)
//   }
// }
