const express = require('express');
const app = express();

app.use(express.json());

app.post('/calculate-age', (req, res) => {
  const dateOfBirth = req.body.dateOfBirth;
  const birthDate = new Date(dateOfBirth);
  const currentDate = new Date();
  const age = currentDate.getFullYear() - birthDate.getFullYear();
  const month = currentDate.getMonth() - birthDate.getMonth();
  if (month < 0 || (month === 0 && currentDate.getDate() < birthDate.getDate())) {
    age--;
  }
  res.json({ age: `${age} years old` });
});

app.listen(3000, () => {
  console.log('Server started on port 3000');
});