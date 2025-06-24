const exec = require('child_process').exec

exec('./script.sh', (err, stdout, stderr) => {
    if(stdout) process.stdout.write(stdout)
    if(stderr) process.stderr.write(stderr)
})
