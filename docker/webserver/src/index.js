const express = require('express')
const app = express()
const PORT = 3000

app.get('/', (req, res) => res.send('Hello Express! on K8s!'))

app.listen(PORT, () => console.log(`the magic happens at: http://<k8s_IP>:${PORT}`))