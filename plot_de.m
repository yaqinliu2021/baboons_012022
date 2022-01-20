%plot our + keiding's recaled death

clear;
clc;

cd 'C:\Users\yaqliu\Desktop\Baboon'

load('interval_de.mat');

interval_us = interval(:,1);
interval_k = interval(:,2);


%create percentage 
for i = 1:15
    count_us = sum(interval_us > interval_us(i));
    p_us(i,1) = count_us/15;
    
    count_k = sum(interval_k > interval_k(i));
    p_k(i,1) = count_k/15;
end

%smooth line
x = (0:0.01:6)';
yp = exp(-x);

pa = NaN(size(x,1),1);
pk = NaN(size(x,1),1);
%fill in gaps
for i = 1:size(x,1)
    for j = 1:15
    if round(x(i),2) == round(interval_us(j),2)
        pa(i) = p_us(j);
    end
    
    if round(x(i),2) == round(interval_k(j),2)
        pk(i) = p_k(j);
    end
    end
end
% nnz(~isnan(pa))
% nnz(~isnan(pk))


%plot
scatter(x,pa,'ro','MarkerEdgeColor','k')
hold on
plot(x,yp,'black')
% xlabel('Re-scaled interval','FontSize',12,'FontWeight','bold'); 
% ylabel('Survival function','FontSize',12,'FontWeight','bold');
xlabel('Re-scaled interval','FontSize',12); 
ylabel('Survival function','FontSize',12);
hold on
scatter(x,pk,'x','black')
hold off

