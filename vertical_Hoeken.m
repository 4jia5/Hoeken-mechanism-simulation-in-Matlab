clc;

% 以下为标准Hoeken mechanism的长度比例。a为大小系数。
a=35;
A = 1*a; B =2.5*a; C = 2.5*a; D = 2*a; F = B;


ang_speed = 1/2 * pi;

t=0:0.05:10;
t1=0.05:0.05:10;


theta = ang_speed * t;     % ang_speed = 2;

P1 = [0;0];        %p1为短杆（A杆）固定点
P4 = D * [0;1];    %p4为长杆（C杆）固定点


P2_x = A*cos(theta);       %theta为p1p2转过的角度（与x正方向夹角）
P2_y = A*sin(theta);
P2 = [P2_x; P2_y];    %p2为圆周转动点

E = sqrt(A^2 + D^2 - 2*A*D*cos(pi/2-theta));      % p2p4=E
alfa = asin(A*sin(pi/2-theta)./E);                % alfa为p1p4和p2p4夹角
beta = acos((E.^2 + C^2 - B^2)./(2*E*C));     %beta为p2p4和p3p4夹角
P3 = [C*sin(alfa+beta);D - C*cos(alfa+beta)];      %p3为最长杆中间点


P3_x = P3(1,:);                         % P3为长杆与短杆的交点，也是长杆的中间点
P3_y = P3(2,:);
P3_vx = diff(P3_x)./diff(t);
P3_vy = diff(P3_y)./diff(t);
P3_v = sqrt(P3_vx.^2 + P3_vy.^2);



% P5                   %p5为最长杆末端点
P5_x = P2_x + 2 .* (P3_x - P2_x);
P5_y = P2_y + 2 .* (P3_y - P2_y);
P5 = [P5_x; P5_y];

P5_vx = diff(P5_x)./diff(t);
P5_vy = diff(P5_y)./diff(t);
P5_v = sqrt(P5_vx.^2 + P5_vy.^2);





for i=1:length(t);
    
    ani = subplot(2,1,1);
    P1_circle = viscircles(P1',0.05);
    P2_circle = viscircles(P2(:,i)',0.05);
    P3_circle = viscircles(P3(:,i)',0.05);
    P4_circle = viscircles(P4',0.05);
    
    A_bar = line([P1(1) P2(1,i)],[P1(2) P2(2,i)]);
    B_bar = line([P2(1,i) P3(1,i)],[P2(2,i) P3(2,i)]);
    C_bar = line([P3(1,i) P4(1)],[P3(2,i) P4(2)]);
    
   
    F_bar = line([P3(1,i) P5(1,i)],[P3(2,i) P5(2,i)]);      % P5
    
    
    axis(ani, 'equal');
    set(gca,'Xlim',[-60 300],'Ylim',[-30 200]);
    
    str1 = '*';

    P5_text = text(P5(1,i),P5(2,i)+0.4,str1);       % P5
    pause(0.005)
    if i<length(t)
        delete(P1_circle);
        delete(P2_circle);
        delete(P3_circle);
        delete(P4_circle);
        delete(A_bar);
        delete(B_bar);
        delete(C_bar);
        
        delete(F_bar);     % P5
        
        delete(Time);

        vel = subplot(2,1,2);
        plot(vel,t(1:i),P5_v(1:i));        % P5  v

        set(vel, 'XLim',[0 10],'YLim',[0 300]);
        xlabel(vel, 'Time (s)');
        ylabel(vel, 'Velocity (mm/s)');
        title(vel, 'Speed of P5');
        grid on;
    end
    
end 




