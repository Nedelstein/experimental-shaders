const VS_SOURCE = `
    precision mediump float;
    attribute vec3 vertPosition;
    attribute vec3 vertColor;
    varying vec3 fragColor;

    uniform mat4 mWorld;
    uniform mat4 mView;
    uniform mat4 mProj;   

    void main(){
        fragColor = vertColor;

        gl_Position = mProj * mView * mWorld * vec4(vertPosition, 1.0);
    }`;

const FS_SOURCE = `
    precision mediump float;
    varying vec3 fragColor;

    uniform float u_time;
    uniform vec2 u_resolution;

    void main(){
      vec2 coord = 6.0 * gl_FragCoord.xy / u_resolution;
      vec3 color = vec3(0.0);


      //watercolor sim below. multiply coord * 6
      for(int n = 1; n < 6; n++){
        float i = float(n);
        coord *= vec2(0.8 / i * sin(i * coord.y + u_time + 0.3 * i) + 0.8, 0.4 / i * sin(coord.x + u_time + 0.3 * i) + 1.6);
      } 

      coord = vec2(0.7* sin(coord.y + u_time + 0.3) + 0.8, 0.4 * sin(coord.x + u_time + 0.3) + 1.6);


      color = vec3(0.5 * sin(coord.x) + 0.5, 0.5 * sin(coord.y) + 0.5, sin(coord.x + coord.y));

        color += sin(coord.x * sin(u_time / 60.0) * 300.0) + sin(coord.y * cos(u_time / 60.0) * 90.0);
        color += sin(coord.y * sin(u_time / 60.0) * 200.0) + sin(coord.x * cos(u_time / 20.0) * 120.0);

        color *= sin(u_time / 5.0) * 0.5;

        color *= fragColor;
        gl_FragColor = vec4(color,1.0);
    }`;

let InitDemo = () => {
  console.log("working");

  let canvas = document.getElementById("my-canvas");
  let gl = canvas.getContext("webgl");

  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  gl.viewport(0, 0, window.innerWidth, window.innerHeight);

  let vertexShader = gl.createShader(gl.VERTEX_SHADER);
  let fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);

  gl.shaderSource(vertexShader, VS_SOURCE);
  gl.shaderSource(fragmentShader, FS_SOURCE);

  gl.compileShader(vertexShader);
  gl.compileShader(fragmentShader);

  //error catching
  if (!gl.getShaderParameter(vertexShader, gl.COMPILE_STATUS)) {
    console.error(
      "Error compiling vertex shader",
      gl.getShaderInfoLog(vertexShader)
    );
    return;
  }

  if (!gl.getShaderParameter(fragmentShader, gl.COMPILE_STATUS)) {
    console.error(
      "Error compiling fragment shader",
      gl.getShaderInfoLog(fragmentShader)
    );
    return;
  }

  const shader_program = gl.createProgram();
  gl.attachShader(shader_program, vertexShader);
  gl.attachShader(shader_program, fragmentShader);

  gl.linkProgram(shader_program);

  //linking error catching
  if (!gl.getProgramParameter(shader_program, gl.LINK_STATUS)) {
    console.error(
      "Error linking program",
      gl.getProgramInfoLog(shader_program)
    );
    return;
  }

  const u_time_location = gl.getUniformLocation(shader_program, "u_time");
  const u_resolution_location = gl.getUniformLocation(
    shader_program,
    "u_resolution"
  );

  //create buffer
  // prettier-ignore
  let triangleVerts = 
  [ 0.0, 0.5, 0.0,   1.0,0.7,0.4,
    -0.5, -0.5, 0.0, 0.6, 0.6, 0.9,
     0.5, -0.5, 0.0, 0.5, 0.2, 0.7
    ];

  let triangleVertexBufferObject = gl.createBuffer();
  gl.bindBuffer(gl.ARRAY_BUFFER, triangleVertexBufferObject);
  gl.bufferData(
    gl.ARRAY_BUFFER,
    new Float32Array(triangleVerts),
    gl.STATIC_DRAW
  );

  let positionAttributeLocation = gl.getAttribLocation(
    shader_program,
    "vertPosition"
  );

  let colorAttributeLocation = gl.getAttribLocation(
    shader_program,
    "vertColor"
  );

  gl.vertexAttribPointer(
    positionAttributeLocation, //atribute location
    3, //num elements per attribute,
    gl.FLOAT, //type of elements,
    false, //normalized?,
    6 * Float32Array.BYTES_PER_ELEMENT, //size of individual vert,
    0 //offset from beginning of single vert to this attribute
  );

  gl.vertexAttribPointer(
    colorAttributeLocation, //atribute location
    3, //num elements per attribute,
    gl.FLOAT, //type of elements,
    false, //normalized?,
    6 * Float32Array.BYTES_PER_ELEMENT, //size of individual vert,
    2 * Float32Array.BYTES_PER_ELEMENT //offset from beginning of single vert to this attribute
  );

  gl.enableVertexAttribArray(positionAttributeLocation);
  gl.enableVertexAttribArray(colorAttributeLocation);

  //tell opengl which program should be active
  gl.useProgram(shader_program);

  let matWorldUniformLocation = gl.getUniformLocation(shader_program, "mWorld");
  let matViewUniformLocation = gl.getUniformLocation(shader_program, "mView");
  let matProjUniformLocation = gl.getUniformLocation(shader_program, "mProj");

  let worldMatrix = new Float32Array(16);
  let viewMatrix = new Float32Array(16);
  let projMatrix = new Float32Array(16);
  glMatrix.mat4.identity(worldMatrix);

  glMatrix.mat4.lookAt(viewMatrix, [0, 0, -2], [0, 0, 0], [0, 1, 0]);
  glMatrix.mat4.perspective(
    projMatrix,
    glMatrix.glMatrix.toRadian(45),
    canvas.width / canvas.height,
    0.1,
    1000.0
  );
  gl.uniformMatrix4fv(matWorldUniformLocation, false, worldMatrix);
  gl.uniformMatrix4fv(matViewUniformLocation, false, viewMatrix);
  gl.uniformMatrix4fv(matProjUniformLocation, false, projMatrix);

  let identityMatrix = new Float32Array(16);
  glMatrix.mat4.identity(identityMatrix);
  let startTime = Date.now();
  let angle = 0;
  function render() {
    angle = (performance.now() / 1000 / 15) * 2 * Math.PI;
    glMatrix.mat4.rotate(worldMatrix, identityMatrix, angle, [0, 1, 0]);
    gl.uniformMatrix4fv(matWorldUniformLocation, false, worldMatrix);

    gl.uniform1f(u_time_location, (Date.now() - startTime) * 0.001);

    gl.uniform2f(u_resolution_location, gl.canvas.width, gl.canvas.height);

    gl.clearColor(0.8, 0.6, 0.6, 1.0);
    gl.clear(gl.COLOR_BUFFER_BIT | gl.Depth_BUFFER_BIT);
    gl.drawArrays(gl.TRIANGLES, 0, 3);

    requestAnimationFrame(render);
  }
  requestAnimationFrame(render);
};
