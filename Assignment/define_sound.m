function Stimulus_freq= define_sound(test_data, i)
Basefreq = test_data(i, 4);
bias = test_data(i, 3);
Stimulus_freq = Basefreq + bias;
end