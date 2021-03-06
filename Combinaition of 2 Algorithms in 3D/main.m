clc;
clear;
%% initialization

% Define the position of the robots
% % Robot_position=[1,2;1,4;1,6;1,8;1,10];
% UAV_position=[5,7;3,2;7,13;6,9;5,5];
% % Define the target positions
% Target_position=[3,6;5,4;5,6;5,8;8,6];

% Random position
UAV_number=3; % The number of UAVs
task_number=5; % The number of Target positions
SizeofMap = [1 100]; % Map size
size_UAV = 0;
size_task = 0;

% while (size_UAV<UAV_number && size_task < task_number)
%     UAV_position = randi(SizeofMap,UAV_number,3);
%     Target_position = randi(SizeofMap,task_number,3);
%     % UAV_position = unique(UAV_position,'rows');
%     % Target_position = unique(Target_position,'rows');
%     size_UAV = size(unique(UAV_position,'rows'),1);
%     size_task = size(unique(Target_position,'rows'),1);
% end


Target_position =[63,87,84;22,24,100;74,41,51;44,59,4;68,61,36];
UAV_position = [6,6,85;88,6,3;92,98,16];
% Initial the speed of UAVs
UAV_speed=ones(UAV_number,1)*10;

% Define the plot color for each UAV
Color_all = [0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1; 0 0 0];
Color = zeros(UAV_number,3);
% for i = 1 : UAV_number
%     Color(i,:) = Color_all(randi(6),:) ;
% end
Color(1,:)= [0 0 0];
Color(2,:)= [1 0 1];
Color(3,:)= [0 1 0];

maxT=10; % The maximum tasks can be done by a single worker
task_fixed_number=1; % The number of workers are required for a single task
% unfinishtask_number=task_number;

ant_num_TA=30; % The numbder of ants in Task Allocation
ant_num_PP=30; % The numbder of ants in Path Planning
iteratornum_TA=30; % The iteration times in Task Allocation
iteratornum_PP=30; % The iteration times in Path Planning

%% The implementation of Hungrain Algorithm
[time_cost_Hungrain, distance_cost_Hungrain, travelled_time_Hungrain] = HungrainAlgorithmMethod(UAV_position,Target_position,UAV_number,UAV_speed,task_number,...
    SizeofMap, Color);
%% The implementation of Ant Colony Algorithm
[time_cost_ant,distance_cost_ant, travelled_time_ant]=AntColonyAlgorithmMethod(UAV_position,Target_position,UAV_number,UAV_speed,task_number,...
    ant_num_TA, iteratornum_TA, maxT,task_fixed_number, ant_num_PP, iteratornum_PP,SizeofMap, Color);

%% The implementation of Ant Colony Algorithm in real time
[time_cost_ant_realtime, distance_cost_ant_realtime,travelled_time_ant_realtime] = AntColonyAlgorithmMethod_realtime(UAV_position,Target_position,UAV_number,UAV_speed,task_number,...
    ant_num_TA, iteratornum_TA, maxT,task_fixed_number, SizeofMap, Color);

%% Comparision
figure(4);
% type = categorical({'Hungrain','Ant Colony','Ant Colony Real Time'});
time_cost = [time_cost_Hungrain, distance_cost_Hungrain, travelled_time_Hungrain;...
    time_cost_ant,distance_cost_ant, travelled_time_ant;...
    time_cost_ant_realtime, distance_cost_ant_realtime, travelled_time_ant_realtime];
%
% bar(type, time_cost)
% xlabel('Algorithms')
% ylabel('Costs')
% title('Comparision between different Algorithms applied on Task Allocation')
% legend('Computational time (s)', 'Sum of UAVs Travelled Distance (m)', 'Sum of UAVs Travelled Time (m)');
bar(time_cost, 'grouped')
set(gca, 'XTickLabel',{'Hungrain', 'Ant Colony', 'Ant Colony Real Time'}, 'FontSize', 18);
set(gca, 'ygrid','on','GridLineStyle','-');

xlabel('Algorithms','FontSize',18)
ylabel('The meansured data used to appraise algorithm performance','FontSize',18)
title('Comparision of the performance between different algorithms in MRTA problem','FontSize',18)
legend('Computational time (s)', 'Sum of UAVs Travelled Distance (m)', 'Sum of UAVs Traveled Time (s)','FontSize',18);