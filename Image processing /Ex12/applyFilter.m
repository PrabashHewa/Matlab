function smoothedEcho = applyFilter(echo, filterType)
    % Smooth the grayscale frames using wiener2 or imdiffusefilt
    smoothedEcho = VideoWriter(['smoothed_' echo.Name], 'Uncompressed AVI');
    open(smoothedEcho);
    
    while hasFrame(echo)
        frameGray = rgb2gray(readFrame(echo));
        smoothedFrame = feval(filterType, frameGray);
        writeVideo(smoothedEcho, cat(3, smoothedFrame, smoothedFrame, smoothedFrame));
    end
    
    close(smoothedEcho);
end