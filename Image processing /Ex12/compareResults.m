function compareResults(opticFlow, echo, titleStr)
    % Compare the results of original and smoothed frames
    figure;
    
    subplot(1, 2, 1);
    processEcho(echo, opticFlow, [titleStr ' - Original']);
    
    subplot(1, 2, 2);
    opticFlowSmoothed = opticalFlowLK('NoiseThreshold', 0.01); % Use the same NoiseThreshold as in (a)
    processEcho(echo, opticFlowSmoothed, [titleStr ' - Smoothed']);
end
