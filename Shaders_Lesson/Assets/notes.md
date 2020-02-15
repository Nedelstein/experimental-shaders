## Basic_Builtin

- Cube, Camera, Directional Light
- Cube: Transform, Mesh, Mesh Renderer, Collider
- Environmental Lighting
- PBR Materials
- Rotate script: applied to cube, public properties in inspector.

## Unlit_rings

- Tour Unlit_Example.shader
- Unity shaders use an HLSL varient
- Unity translates shaders to match platform
- [Unity Shader Language](https://docs.unity3d.com/Manual/SL-ShadingLanguage.html)
- https://codepen.io/alaingalvan/post/glsl-vs-hlsl
- https://docs.microsoft.com/en-us/windows/uwp/gaming/glsl-to-hlsl-reference

## Unlit_Lit

- Albedo
- Ambient
- Diffuse
  - Why its cold in winter.
- Normals
- Dot Products
- Phong: Ambient + Diffuse + Specular
- Exposing parameters to UI

## Surface_Rings

- A surface shader computes the PBR properties of surface.
- Properties are then used by the standard shader lighting to determine fragment color.
