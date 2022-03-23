#! /usr/bin/env node

//import { readFileSync } from 'fs';
//import { extname } from 'path';
const fs = require('fs')
const path = require('path')

function toDataUrl(file) {
    const ext = path.extname(file).replace('.', '')
    var imageAsBase64 = fs.readFileSync(file, 'base64');
    console.log(`data:image/${ext};base64,${imageAsBase64}`)
}

const argv = process.argv

toDataUrl(argv[2])
