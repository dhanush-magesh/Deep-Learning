function Y = scatter_plot(X,y)
% This function uses LDA algorithm to examine single feature.
% It also gives 1-D scatter plot for each feature.
%
% Inputs: X is feature vector
%         y is the label of corresponding feature.
% Output: Y is the rescaled 1-D featureby using LDA algorithm.
% Use "scatter_mat" function created by S. Theodoridis, A. Pikrakis, K. Koutroumbas, D. Cavouras

global i

[Sw,Sb,Sm]=scatter_mat(X,y);
[V,D] = eig(inv(Sw)*Sb);
s = diag(D);
[s,ind] = sort(s,1,'descend');
V = V(:,ind);
c = 2;
A = V(:,1:c-1);
Y = A'*X;

% figure
% plot(Y(y == 0),0,'r.',Y(y == 1),0,'b.')
% if i == 1
%         title('LDA Presentation of "total utter length"')
%         xlabel('DataPoints')
% elseif i == 2
%         title('LDA Presentation of "fract speech length"')
%         xlabel('DataPoints') 
% elseif i == 3
%         title('LDA Presentation of "total n pauses"')
%         xlabel('DataPoints') 
% elseif i == 4
%         title('LDA Presentation of "fract pause length"')
%         xlabel('DataPoints')
% elseif i == 5
%         title('LDA Presentation of "fract pauses lt 0.5s"')
%         xlabel('DataPoints') 
% elseif i == 6
%         title('LDA Presentation of "fract pauses 0.5-1s"')
%         xlabel('DataPoints') 
% elseif i == 7
%         title('LDA Presentation of "fract pauses gt 1s"')
%         xlabel('DataPoints') 
% elseif i == 8
%         title('LDA Presentation of "fract pauses gt 2s"')
%         xlabel('DataPoints') 
% elseif i == 9
%         title('LDA Presentation of "fract pauses gt 5s"')
%         xlabel('DataPoints') 
% elseif i == 10
%         title('LDA Presentation of "fract pauses gt 10s"')
%         xlabel('DataPoints') 
% elseif i == 11
%         title('LDA Presentation of "fract pauses gt 15s"')
%         xlabel('DataPoints') 
% elseif i == 12
%         title('LDA Presentation of "frac_len_p_lt_0.5_s"')
%         xlabel('DataPoints')
% elseif i == 13
%         title('LDA Presentation of "frac_len_p_0.5-1_s"')
%         xlabel('DataPoints') 
% elseif i == 14
%         title('LDA Presentation of "frac_len_p_gt_1_s"')
%         xlabel('DataPoints') 
% elseif i == 15
%         title('LDA Presentation of "frac_len_p_gt_2_s"')
%         xlabel('DataPoints')
% elseif i == 16
%         title('LDA Presentation of "frac_len_p_gt_5_s"')
%         xlabel('DataPoints') 
% elseif i == 17
%         title('LDA Presentation of "frac_len_p_gt_10_s"')
%         xlabel('DataPoints') 
% elseif i == 18
%         title('LDA Presentation of "frac_len_p_gt_15_s"')
%         xlabel('DataPoints') 
% elseif i == 19
%         title('LDA Presentation of "frac_p_q1"')
%         xlabel('DataPoints') 
% elseif i == 20
%         title('LDA Presentation of "frac_p_q2"')
%         xlabel('DataPoints') 
% elseif i == 21
%         title('LDA Presentation of "frac_p_q3"')
%         xlabel('DataPoints') 
% elseif i == 22
%         title('LDA Presentation of "frac_p_q4"')
%         xlabel('DataPoints') 
%            
% end  
% pause
    
i = i+1;


