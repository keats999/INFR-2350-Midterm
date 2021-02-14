#pragma once

#include "Graphics/Post/PostEffect.h"

class BloomEffect : public PostEffect
{
public:
	//Initializes framebuffer
	//Overrides post effect Init
	void Init(unsigned width, unsigned height) override;

	//Applies the effect to this buffer
	//passes the previous framebuffer with the texture to apply as parameter
	void ApplyEffect(PostEffect* buffer) override;

	//Getters
	float GetIntensity() const;
	float GetThreshold() const;

	//Setters
	void SetIntensity(float intensity);
	void SetThreshold(float threshold);
private:
	float _intensity = 0.0f;
	float _threshold = 0.5f;
};