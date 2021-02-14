#version 420

layout(location = 0) in vec2 inUV;

out vec4 frag_color;

layout (binding = 0) uniform sampler2D s_screenTex;

//Affects how bloomed
//Lower the number, closer we are to regular
uniform float u_Intensity = 1.0;

//Affects the threshold of light that gets the bloom effect
uniform float u_Threshold = 0.5;

void main() 
{
    vec4 source = texture(s_screenTex, inUV);

    //credit to David Lettier for the bloom tutorial https://lettier.github.io/3d-game-shaders-for-beginners/bloom.html

	int blurSize = 3;
    float blurSeparation = 4.0;
    vec2 texSize = textureSize(s_screenTex, 0).xy;
    vec4 result = vec4(0.0);
    vec4 color  = vec4(0.0);

    float brightnessValue = 0.0;
    int count = 0;

    for (int i = -blurSize; i <= blurSize; ++i) {
        for (int j = -blurSize; j <= blurSize; ++j) {
            color = texture(s_screenTex, (vec2(i, j) * blurSeparation + gl_FragCoord.xy) / texSize);

            brightnessValue = max(color.r, max(color.g, color.b));
            if (brightnessValue < u_Threshold)
            {
                color = vec4(0.0);
            }

            result += color;
            count++;
        }
    }

    result /= float(count);
    result += source;

	frag_color.rgb = mix(source.rgb, result.rgb, u_Intensity);
    frag_color.a = source.a;
}