function [Results,wilcoxon_test,friedman_p_value]=Cal_stats(Optimal_results)
% Results：
%          平均收敛曲线
%          最差值worst
%          最优值best
%          标准差值std 
%          均值mean 
%          中值median
%          wilcoxon_test： Wilcoxon符号秩检验、 Wilcoxon秩和检验
%          friedman_p_value： friedman检验
%% 统计值-结果保存在Results中
for k=1:size(Optimal_results, 2)
    Results{1,k} = Optimal_results{1,k};
    Results{2,k} = mean(Optimal_results{2,k},1);  % 平均收敛曲线，Optimal_results第2行保存的是收敛曲线
    Results{3,k} = min(Optimal_results{3,k});    % 最差值worst，Optimal_results第3行保存的是最优值
    Results{4,k} = max(Optimal_results{3,k});    % 最优值best，Optimal_results第3行保存的是最优值
    Results{5,k} = std(Optimal_results{3,k});      % 标准差值 std  ，Optimal_results第3行保存的是最优值
    Results{6,k} = mean(Optimal_results{3,k});     % 平均值 mean，Optimal_results第3行保存的是最优值
    Results{7,k} = median(Optimal_results{3,k});     % 中值   median，Optimal_results第3行保存的是最优值
end
%% Wilcoxon 秩检验
% 将目标算法放在第一个位置，计算其与其他对比算法的显著水平，p_value<0.05即为显著
obj_algo_mat = Results{2,1}; % 目标算法的平均收敛曲线，Results第2行保存的是平均收敛曲线
for i=2:size(Results,2) % 其他算法的平均收敛曲线数据
    other_algo_mat=Results{2,i}; % Results第2行保存的是平均收敛曲线
    [wilcoxon_test.signed_p_value(i-1),h,wilcoxon_stats]=signrank(obj_algo_mat,other_algo_mat);  % 调用符号秩检验
    [wilcoxon_test.ranksum_p_value(i-1),h2,ranksum_stats]=ranksum(obj_algo_mat,other_algo_mat); %调用秩和检验
end

%% friedman test p_value<0.05即为显著
test_mat = []; % 待测矩阵
for i=1:size(Results,2) % 其他算法
    test_mat =cat(1,test_mat,Results{2,i}); % Results第2行保存的是平均收敛曲线
end
[friedman_p_value,table,friedman_stats]=friedman(test_mat); % 调用friedman检验
if friedman_p_value<0.05
    disp(['Friedman Test值为' num2str(friedman_p_value) '<0.05，具有显著性差别'])
end
end