%step size model - new log likelihood
clear;
clc;

cd 'C:\Users\yaqliu\Desktop\Baboon'

load('allevents.mat');
load('baboon.mat');

t_j = allevents(:,2);
t_j_lag = allevents(:,3);
N_t_j_lag = allevents(:,4);
T = size(allevents,1);

u = baboon(:,2);
M = size(u,1);%total number of death(emigration) events

%initial values
c_max = -1e+10;
f_max = -1e+10;


for c = 71:358
    j = find(c <= u,1,'first'); %find the first element in u satisfies 
    D_c = j-1; %number of death(emigration) events up to day c
    D_T = M;
    aj = find(c <= t_j,1,'first')-1;
    N_t_mc = N_t_j_lag(aj);
    t_mc = t_j(aj);
    t_mc_1 = t_j(aj+1);

    f = D_c*log(D_c/(sum(N_t_j_lag(1:aj).*(t_j(1:aj) - t_j_lag(1:aj))) + N_t_mc*(c-t_mc))) ...
        + (D_T - D_c)*log((D_T - D_c)/(sum(N_t_j_lag(aj+2:T).*(t_j(aj+2:T) - t_j_lag(aj+2:T)))+N_t_mc*(t_mc_1 - c))) ...
        - D_c - (D_T - D_c);

    if f>f_max
        f_max = f;
        c_max = c;
        %solve for beta and g
        b_max = D_c/(sum(N_t_j_lag(1:aj).*(t_j(1:aj) - t_j_lag(1:aj))) + N_t_mc*(c-t_mc));
        g_max = (D_T - D_c)/(sum(N_t_j_lag(aj+2:T).*(t_j(aj+2:T) - t_j_lag(aj+2:T)))+N_t_mc*(t_mc_1 - c));
    end
    
end
    