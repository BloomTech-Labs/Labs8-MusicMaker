var QRCode = require('qrcode');

// this is the general QR code creation function, takes a string and returns the code
// using both console logs and returns for testing purposes

// adding a random string generator to test a variety of cases rather than a simple 'test' string each time
// 16 characters for now

let stringGen = Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, 16);

let code = QRCode.toString(stringGen, function (err, string) {
  if(err) throw err;
  console.log(string);
});

// this is the version we'll want to store in the database, returns the QR code data itself

let data = QRCode.toDataURL(stringGen, function (err, url) {
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
