function [Results,wilcoxon_test,friedman_p_value]=Cal_stats(Optimal_results)
% Results��
%          ƽ����������
%          ���ֵworst
%          ����ֵbest
%          ��׼��ֵstd 
%          ��ֵmean 
%          ��ֵmedian
%          wilcoxon_test�� Wilcoxon�����ȼ��顢 Wilcoxon�Ⱥͼ���
%          friedman_p_value�� friedman����
%% ͳ��ֵ-���������Results��
for k=1:size(Optimal_results, 2)
    Results{1,k} = Optimal_results{1,k};
    Results{2,k} = mean(Optimal_results{2,k},1);  % ƽ���������ߣ�Optimal_results��2�б��������������
    Results{3,k} = min(Optimal_results{3,k});    % ���ֵworst��Optimal_results��3�б����������ֵ
    Results{4,k} = max(Optimal_results{3,k});    % ����ֵbest��Optimal_results��3�б����������ֵ
    Results{5,k} = std(Optimal_results{3,k});      % ��׼��ֵ std  ��Optimal_results��3�б����������ֵ
    Results{6,k} = mean(Optimal_results{3,k});     % ƽ��ֵ mean��Optimal_results��3�б����������ֵ
    Results{7,k} = median(Optimal_results{3,k});     % ��ֵ   median��Optimal_results��3�б����������ֵ
end
%% Wilcoxon �ȼ���
% ��Ŀ���㷨���ڵ�һ��λ�ã��������������Ա��㷨������ˮƽ��p_value<0.05��Ϊ����
obj_algo_mat = Results{2,1}; % Ŀ���㷨��ƽ���������ߣ�Results��2�б������ƽ����������
for i=2:size(Results,2) % �����㷨��ƽ��������������
    other_algo_mat=Results{2,i}; % Results��2�б������ƽ����������
    [wilcoxon_test.signed_p_value(i-1),h,wilcoxon_stats]=signrank(obj_algo_mat,other_algo_mat);  % ���÷����ȼ���
    [wilcoxon_test.ranksum_p_value(i-1),h2,ranksum_stats]=ranksum(obj_algo_mat,other_algo_mat); %�����Ⱥͼ���
end

%% friedman test p_value<0.05��Ϊ����
test_mat = []; % �������
for i=1:size(Results,2) % �����㷨
    test_mat =cat(1,test_mat,Results{2,i}); % Results��2�б������ƽ����������
end
[friedman_p_value,table,friedman_stats]=friedman(test_mat); % ����friedman����
if friedman_p_value<0.05
    disp(['Friedman TestֵΪ' num2str(friedman_p_value) '<0.05�����������Բ��'])
end
end