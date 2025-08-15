#!/bin/bash

# set variables
MODULE_NAME=$1
TEMPLATE_PATH="./templates"
OUTPUT_PATH="./generated_modules"

# create output directory if it doesn't exist
if [ ! -d "$OUTPUT_PATH" ]; then
  mkdir -p $OUTPUT_PATH
fi

# generate module boilerplate
BOILERPLATE=$(cat <<EOF
// ${MODULE_NAME}.js
import { Scene, Mesh, Vector3 } from 'aframe';

let ${MODULE_NAME} = {
  init: function(scene) {
    let mesh = new Mesh();
    mesh.setGeometry('box', { width: 1, height: 1, depth: 1 });
    mesh.setMaterial('material', 'color', 'red');
    scene.appendMesh(mesh);
  }
};

export default ${MODULE_NAME};
EOF
)

# generate HTML file for testing
HTML=$(cat <<EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>${MODULE_NAME} Test</title>
  <script src="https://aframe.io/releases/1.2.0/aframe.min.js"></script>
</head>
<body>
  <a-scene>
    <a-assets>
      <script id="${MODULE_NAME}" src="${MODULE_NAME}.js"></script>
    </a-assets>
    <a-box ${MODULE_NAME} color="blue" position="-1 0 -3" rotation="0 45 0" scale="0.7 0.7 0.7"></a-box>
  </a-scene>
</body>
</html>
EOF
)

# write boilerplate to file
echo "$BOILERPLATE" > $OUTPUT_PATH/${MODULE_NAME}.js

# write HTML to file
echo "$HTML" > $OUTPUT_PATH/${MODULE_NAME}.html

# open HTML file in default browser
xdg-open $OUTPUT_PATH/${MODULE_NAME}.html