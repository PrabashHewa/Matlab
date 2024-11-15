function FlowTracking(V,t)
    vidReader = VideoReader(V);

    opticFlow = opticalFlowLK('NoiseThreshold', t);
    while hasFrame(vidReader)
        % Read the rgb frame
        frameRGB  = readFrame(vidReader);
        % Convert rgb to grayscale
        frameGray = rgb2gray(frameRGB);
        % Compute optical flow
        flow = estimateFlow(opticFlow, frameGray);
        % Display rgb video frame with flow vectors
        imshow(frameRGB);
        hold on;
        plot(flow, 'DecimationFactor', [5 5], 'ScaleFactor', 10);
        drawnow;
        hold off;
    end
end