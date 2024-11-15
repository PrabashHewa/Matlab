A = 0:255;
step = 256/4;
QA1 = quant(A, step);
partition = step:step:256-step;
codebook = step/2:step:256-step/2;
[indx,QA2] = quantiz(A, partition, codebook);

unique(QA1)
unique(QA2)