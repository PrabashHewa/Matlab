%% ROLLING A FAIR 6‐FACED DICE (DISCRETE VALIABLE)

N_faces = 6; %Number of faces in the dice
N_trials = 10000; %Number of trials (how many times the dice is rolled)
trials = randi(N_faces,1,N_trials); % Getting random integers 1...6
x_histogram_centers = 1:6; %x-axis for the bin center coordinates
% x-axis for the bin edge coordinates (last edge is for the right edge)
histogram_edges = 0.5:1:6.5;
% Below the ~ sign means that we discard that specific output argument
[hist_count, ~]= histcounts(trials,histogram_edges);
figure
bar(x_histogram_centers,hist_count)
xlabel('Rolled number')
ylabel('occurrence number')

grid on % Set a grid in the plotted figure
title('Dice rolling histogram')

% Histograms can plotted directly as "h = histogram(trials,'BinLimits',[0.5
% 6.5],'BinMethod','integers')", where h is the histogram object. 

%%
%Normalize the histogram values with N_trials 
pdf_experimental = hist_count/N_trials;
figure
bar(x_histogram_centers,pdf_experimental)
xlabel('Rolled number')
ylabel('pdf')
grid on
title('Dice rolling normalized histogram')
one_face_probability = 1/N_faces; % probability of one face of the dice
hold on % avoids removing the previous plot
% plotting true pdf (a line between two points)
plot([0.5 6.5],[one_face_probability one_face_probability],'r')
hold off
% Using legend we can name different data curves in the plot (in order of
% appearance)
legend('Experimental pdf','True pdf') 

%%
%NORMAL/GAUSSIAN DISTRIBUTED RANDOM VARIABLE
N_samples = 1000;
mu = 3;
sigma = sqrt(4); % the variance is 4 (i.e. sigma^2=4) 
bin_width = 0.5; %bin width (in the x-axis) 
bin_centers = -7:bin_width:13; %x-axis for the bin center coordinates
% x-axis for the bin edge coordinates (last edge is for the right edge):
% (Three dots “…” continues the command in the following line)
bin_edges = (bin_centers(1)-bin_width/2):bin_width:(bin_centers(end)+bin_width/2);
% ~ means that we discard that output argument
[hist_count, ~]= histcounts(X,bin_edges);
pdf_experimental = hist_count/sum(hist_count*bin_width);
figure
bar(bin_centers,pdf_experimental,1)
% and so on with the titles, xlabels,… 

pdf_true = 1/(sqrt(2*pi)*sigma)*exp(-(mu-bin_edges).^2/(2*sigma^2));
hold on
plot(bin_edges,pdf_true,'r','LineWidth',3) % defines a specific line width
% … and so on with the titles, xlabels,… (remember the legend also) 

b = 5.25;
indices_with_bin_center_larger_than_b = bin_centers > b;
considered_bin_values = pdf_experimental(indices_with_bin_center_larger_than_b);
%area of the considered bins
probability_X_larger_than_b = sum(considered_bin_values*bin_width) 
analytic_probability = qfunc((b-mu)/sigma) 
