#! /usr/bin/env node

const gltfPipeline = require("gltf-pipeline");
const fsExtra = require("fs-extra");

const processGltf = gltfPipeline.processGltf;

function convert(input, output) {
    const gltf = fsExtra.readJsonSync(input);
    const options = {
        dracoOptions: {
            compressionLevel: 10,
        },
    };
    processGltf(gltf, options).then(function (results) {
        fsExtra.writeJsonSync(output, results.gltf);
    });
}

const argv = process.argv

convert(argv[2], argv[3])
