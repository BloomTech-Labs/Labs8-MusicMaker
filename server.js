const express = require('express');

const app = express();

// test GET request for firebase

app.get('/', (req, res) => {
  console.log('GET request test');
  res.send('hello');
});

const server = app.listen(8000, function () {

  const host = server.address().address;
  const port = server.address().port;

  console.log(`Server listening on port ${port}.`);
});
