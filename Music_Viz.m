%% Visualizing the Music
%Bar plots for the constant variables (and averaged features over time)
figure %Valence
for i = 1:6
subplot(2,3,i)
bar(CB1_Features(i,:))
xticks(1:25)
xlim([0 25])
xtickangle(45)
xticklabels(sub_Labels)
title(Feature_Labels{i}, 'FontSize', 14)
end
suptitle('Average Valence Features by Piece')
clear i
%%
figure% Bar plot for arousal
for i = 1:6
subplot(2,3,i)
bar(A_Features(i,:))
xticks(1:25)
xlim([0 25])
xtickangle(45)
xticklabels(sub_Labels)
title(Feature_Labels{i+6}, 'FontSize', 14)
end
suptitle('Average Arousal Features by Piece')
clear i
%%
% Feature correlations
length = 39; %change this for different times. NB: the shortest excerpt is 39s long.
Viz_Features_V = cell(1,6);%pre-allocate the cell
Viz_Features_A = cell(1,6);
Viz_SF = cell(1,6);
for i = 1:6
Viz_Features_V{1,i} = zeros(25,length);%MORE pre-allocation
Viz_Features_A{1,i} = zeros(25,length);%MORE pre-allocation
Viz_SF{1,i} = zeros(25,3208);
end
clear i
%Transfering the data from piece-cells to feature-cells
for s = 1:25
    for f = 1:5
    Viz_Features_V{1,f}(s,:) = F_Valence{1,s}(f,1:length);
    Viz_Features_A{1,f}(s,:) = F_Arousal{1,s}(f,1:length);
    Viz_SF{1,f}(s,:) = Secondary_Features{f,s}(1,1:3208); 
    end
    Viz_Features_V{1,6}(s,:) = (Pitch_RS{1,s}(1:length,1))';
    Viz_Features_A{1,6}(s,:) = (Tempo_RS{1,s}(1:length,1))';
    Viz_SF{1,6}(s,:) = Secondary_Features{6,s}(1,1:3208);
end
clear s f length
%%
% The correlations
Viz_V_r = cell(1,6);%pre-allocation forever
Viz_A_r = cell(1,6);
Viz_SF_r = cell(1,6);
for f = 1:6 %6 features
[rV, ~] = corrcoef(Viz_Features_V{1,f}'); %piece-piece correlation rather than second-second
Viz_V_r{1,f} = rV; %printing r matrix to the cell
[rA,~] = corrcoef(Viz_Features_A{1,f}');
Viz_A_r{1,f} = rA;
[rSF,~] = corrcoef(Viz_SF{1,f}');
Viz_SF_r{1,f} = rSF;
end
clear f rV rA rSF %make look nice
%% The plots
figure
for i = 1:4
subplot(2,2,i)
imagesc(Viz_V_r{1,i+2}(Controls,Controls))%Controls
%imagesc(Viz_V_r{1,i+2}(Experiment, Experiment))%Experimental
%xticks(1:25)%all
%xticks(1:19)%Experimental Pieces
xticks(1:6)% Control Pieces
xticklabels(sub_Labels(Controls))%Controls
%xticklabels(sub_Labels(Experiment))%Experimental
xtickangle(45)
title(Feature_Labels{i+2})
end
suptitle('Feature Correlations Valence')
colorbar
%%
figure
for i = 1:4
subplot(2,2,i)
imagesc(Viz_A_r{1,i+2}(Controls,Controls))%Controls
%imagesc(Viz_A_r{1,i+2}(Experiment,Experiment))%Experimental
%xticks(1:25)%all
%xticks(1:19)%Experimental Pieces
xticks(1:6)% Control Pieces
xticklabels(sub_Labels(Controls))%Controls
%xticklabels(sub_Labels(Experiment))%Experimental
xtickangle(45)
title(Feature_Labels{i+8})
end
suptitle('Feature Correlations Arousal')
colorbar
clear i
%%
%SF Plot
figure
for i = 1:6
subplot(2,3,i)
%imagesc(Viz_SF_r{1,i}(Experiment,Experiment))%Experimental
imagesc(Viz_SF_r{1,i}(Controls,Controls))%Controls
%imagesc(Viz_SF_r{1,i}%all
%xticks(1:25)%all
%xticks(1:19)%Experimental Pieces
xticks(1:6)% Control Pieces
%xticklabels(sub_Labels)%all
xticklabels(sub_Labels(Controls))%Controls
%xticklabels(sub_Labels(Experiment))%Experimental
xtickangle(45)
title(Secondary_Feature_Labels{i})
end
suptitle('Feature Correlations: Secondary Features')
colorbar
clear i
