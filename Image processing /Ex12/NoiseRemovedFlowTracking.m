function NoiseRemovedFlowTracking(V,t)
    vidReader = VideoReader(V);
    opticFlow = opticalFlowLK('NoiseThreshold', t);
    while hasFrame(vidReader)
        % Read the rgb frame
        frameRGB  = readFrame(vidReader);
        % Convert rgb to grayscale
        BframeGray = rgb2gray(frameRGB);
        frameGray = wiener2(BframeGray,[3 3]);
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