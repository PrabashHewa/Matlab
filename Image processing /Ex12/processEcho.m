function processEcho(echo, opticFlow, titleStr)
    % Process the echo video using the given opticFlow object
    while hasFrame(echo)
        % Read the grayscale frame
        frameGray = rgb2gray(readFrame(echo));
        
        % Compute optical flow
        flow = estimateFlow(opticFlow, frameGray);
        
        % Display frame with flow vectors
        imshow(frameGray);
        hold on;
        plot(flow, 'DecimationFactor', [5 5], 'ScaleFactor', 10);
        title(titleStr);
        drawnow;
        hold off;
    end
end