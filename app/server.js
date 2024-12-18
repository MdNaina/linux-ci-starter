const express = require('express')
const app = express()
const port = 5000

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.get('/json', (req, res) => {
  const query = req.query
  res.json(query)
})

app.get('/:name', (req, res) => {
  res.send(`Hello ${req.params.name}`)
})


app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
