const express = require('express')
const app = express()
const PORT = 3000

app.get('/', (req, res) => res.send('Hello Express! on K8s!'))
app.get('/hello', (req, res) => res.send('World'))
app.all('/*', (req, res) => res.send('This route does not exist'))

app.listen(PORT, () => console.log(`the magic happens at: http://<k8s_IP>:${PORT}`))