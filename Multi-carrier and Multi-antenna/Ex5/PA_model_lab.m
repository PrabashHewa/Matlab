function [PA_output,input_signal_scaling,output_signal_scaling] = PA_model_lab(PA_input,backoff)



P_1dB = 5.025;
Pout_clip = 5.596;
Pin_clip = P_1dB + 2.3;
input_signal_scaling = rms(PA_input);
PA_input = PA_input/input_signal_scaling;
Init_BO = P_1dB - 20*log10(rms(PA_input));
Desired_BO = 10^((backoff-Init_BO)/20);
PA_input = PA_input/Desired_BO;

PA_model = [0.9558 + 0.0000i;
    0.0161 + 0.0023i;
    -0.0169 - 0.0075i;
    0.0017 + 0.0015i;
    -0.0000 - 0.0001i]

basis_functions = [PA_input PA_input.*abs(PA_input).^2 PA_input.*abs(PA_input).^4 ...
    PA_input.*abs(PA_input).^6 PA_input.*abs(PA_input).^8];

PA_output = basis_functions*PA_model;
PA_output(abs(PA_input)>= 10^((Pin_clip)/20)) = 10^(Pout_clip/20)*exp(1i*angle(PA_output(abs(PA_input)>= 10^((Pin_clip)/20))));
PA_output = PA_output*input_signal_scaling/rms(PA_output);

end

