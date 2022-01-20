%Keiding's recaled death

clear;
clc;

cd 'C:\Users\yaqliu\Desktop\Baboon'

load('allevents.mat');
load('baboon.mat');
load('auj.mat'); %indicator of death(+emigration) in all events

u = baboon(:,2);

t_j = allevents(:,2);
t_j_lag = allevents(:,3);
N_t_j_lag = allevents(:,4);
M = size(allevents,1);

%parameters estimates from stepmodel
c = 204;
b = 0.00097; %keidings
g = 0.00097; %keidings


%parameters from Keiding
lamda = 6.5e-4;
v = 8.0e-3;


%find the event times that occured up to c
mj = find(c <= u,1,'first')-1;
nj = find(u(mj) == t_j, 1, 'first');

%rescaled event times
%u_j<c
t_sum = zeros(mj,1);
for i = 1:mj
    t_sum(i) = sum(N_t_j_lag(1:auj(i)).*(t_j(1:auj(i)) - t_j_lag(1:auj(i))));
end
tao_bc = b*t_sum;

%u_j>c
mc = 9;
N_c = 45;
N_t_mc = 44;
t_mc = 203;
t_mc_one = 223;

tao_ac_p1 = b * sum(N_t_j_lag(1:mc).*(t_j(1:mc) - t_j_lag(1:mc)));
tao_ac_p2 = b * N_t_mc * (c - t_mc);
tao_ac_p3 = g * N_t_mc * (t_mc_one - c);

tao_ac_p4 = zeros(13,1);
for ii = 1:12
    
    tao_ac_p4(ii+1) = g*sum(N_t_j_lag(11:auj(ii+3)).*(t_j(11:auj(ii+3)) ...
                                                     - t_j_lag(11:auj(ii+3))));
end

tao_ac = tao_ac_p1 + tao_ac_p2 + tao_ac_p3 + tao_ac_p4;

tao_k = [tao_bc;tao_ac];

%interval
tao_k_lag = [0;tao_k(1:14)];
interval_k = tao_k - tao_k_lag;

