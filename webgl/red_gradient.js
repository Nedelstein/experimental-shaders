//////////////////////////////////////////////
// vertex shader
const VS_SOURCE = `
    precision highp float;
    

    attribute vec4 aVertexPosition;
    
    void main(void) {
      gl_Position = aVertexPosition;
    }
`;

//////////////////////////////////////////////
// fragment shader
const FS_SOURCE = `
    precision highp float;

    void main(void) {
      gl_FragColor = vec4(gl_FragCoord.x / 640.0, 0.0, 0.0, 1.0);
    }
`;

main();
function main() {
  console.log("Hello, WebGL!");

  //////////////////////////////////////////////
  // create context
  const canvas = document.querySelector("#glcanvas");
  const gl = canvas.getContext("webgl");

  //////////////////////////////////////////////
  // ?

  // vertex shader compiling
  const vertex_shader = gl.createShader(gl.VERTEX_SHADER);
  gl.shaderSource(vertex_shader, VS_SOURCE);
  gl.compileShader(vertex_shader);

  // fragment shader compiling
  const fragment_shader = gl.createShader(gl.FRAGMENT_SHADER);
  gl.shaderSource(fragment_shader, FS_SOURCE);
  gl.compileShader(fragment_shader);

  // ?
  const shader_program = gl.createProgram();
  gl.attachShader(shader_program, vertex_shader);
  gl.attachShader(shader_program, fragment_shader);

  //links the two shaders together and checks for variables that need to be linked
  gl.linkProgram(shader_program);

  //////////////////////////////////////////////
  // create an ID within the program for that attribute
  const vertex_position_location = gl.getAttribLocation(
    shader_program,
    "aVertexPosition"
  );

  //////////////////////////////////////////////
  // ?

  //
  const position_buffer = gl.createBuffer();

  // do all the buffer work to this particular buffer
  gl.bindBuffer(gl.ARRAY_BUFFER, position_buffer);
  const positions = [
    1.0,
    1.0, // top right
    -1.0,
    1.0, // top left
    1.0,
    -1.0, // bottom right
    -1.0,
    -1.0 // bottom left
  ];

  //   copies buffer data over to the GPU
  gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(positions), gl.STATIC_DRAW);

  //describe to gl what is in the buffer

  gl.vertexAttribPointer(vertex_position_location, 2, gl.FLOAT, false, 0, 0); //last two numbers are stride (how many bytes to skip between data) and offset (how many bytes to skip up front)

  gl.enableVertexAttribArray(vertex_position_location);

  //////////////////////////////////////////////
  // config gl
  //only draw things that are less than or equal to the position
  gl.enable(gl.DEPTH_TEST);
  gl.depthFunc(gl.LEQUAL); //less than or equal to

  //////////////////////////////////////////////
  // ?

  // ?
  gl.clearColor(0.0, 0.0, 0.0, 1.0); //
  gl.clearDepth(1.0);
  gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT); //a mask of which things to clear

  // ?
  gl.useProgram(shader_program);
  gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
}
