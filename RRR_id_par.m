clc
clear 

hold on
f1 = figure(1);
axis([-3.5 3.5 -3.5 3.5])

sym_time = 60;
dt = 0.01;

K_p = 20;
K_pi = 0.4;

q1 = 0;
q2 = 0;
q3 = 0;

q = [q1;q2;q3]
q_dot = [0;0;0]

l1 = 1;
l2 = 1;
l3 = 1;

l1_hat = 1.2;
l2_hat = 0.7;
l3_hat = 0.5;

pi = [l1; l2; l3];                  %PARAMERI VERI
pi_hat = [l1_hat ;l2_hat; l3_hat];  %PARAMETRI STIMATI
pi_tild = pi - pi_hat;              %ERRORE NEI PARAMETRI



W = [1,0,0,0,0,0;
    0,1,0,0,0,0;
    0,0,0,0,0,0;
    0,0,0,0,0,0;
    0,0,0,0,0,0;
    0,0,0,0,0,0];

Xi_des_X_fun = @(t) ( 2 * sin(t) + 1 * sin(8*t)  )
Xi_des_Y_fun = @(t) ( 2 * cos(t) + 1 * cos(8*t) )

for i = 1: 1000
    X_tr(i) = Xi_des_X_fun(dt*i);
    Y_tr(i) = Xi_des_Y_fun(dt*i);
end

 plot(X_tr,Y_tr);




Xi_des = [Xi_des_X_fun(dt),Xi_des_Y_fun(dt),0,0,0,0]';


h0 = plot(Xi_des(1),Xi_des(2),'.','MarkerSize',20 ,'Color','red' )
H1 = plotrobot(pi,q,'black');
H2 = plotrobot(pi_hat,q,'blue');

Xi_hat = ni(Q(pi_hat,q));
Xi = ni(Q(pi,q));



for t = dt : dt : sym_time
    
    
    
    Xi_des = [Xi_des_X_fun(t) ; Xi_des_Y_fun(t) ; 0 ;0 ;0;0]
    Xi_des_dot = ( Xi_des - [Xi_des_X_fun(t-dt) ; Xi_des_Y_fun(t-dt) ; 0 ;0 ;0;0] ) / (2 * dt)
    
    
    Jac = J(pi,q) ;
    Xi = ni( Q(pi,q) ) ;
    e = Xi_des - Xi ;
    u =   pinv( W * Jac   ) * (Xi_des_dot +  K_p * e) ;
    q_dot = u ;
    q = q + q_dot * dt ;    

    Jac_hat = J(pi_hat,q) ;
    Xi_hat = ni( Q(pi_hat,q));
    e = Xi_des - Xi_hat ;
    u =  K_p * pinv( W * Jac_hat) * (Xi_des_dot + K_p * e) ;
    Y_pi = J_pi(pi_hat,q) ;
    u_pi =  K_pi *( Y_pi(1:2,:) )' * e(1:2);
    pi_hat_dot = u_pi;
    pi_hat = pi_hat + pi_hat_dot * dt ;

    

    delete(h0)
    delplot(H1)
    delplot(H2)
    h0 = plot(Xi_des(1),Xi_des(2),'.','MarkerSize',20 ,'Color','red' );
    H1 = plotrobot(pi_hat,q,'black');
    H2 = plotrobot(pi,q,'blue');
    
    pause(0.01)
    
end

 
function H = plotrobot(pi,q,color)
    hold on
    Xi_1 = ni( Q([pi(1),0,0]',q) ) ;
    Xi_2 = ni( Q([pi(1),pi(2),0]',q)  );
    Xi_3 = ni( Q([pi(1),pi(2),pi(3)]',q)  ) ;
    x_0 = 0;
    y_0 = 0;
    x_1 = Xi_1(1);
    y_1 = Xi_1(2);
    x_2 = Xi_2(1);
    y_2 = Xi_2(2);
    x_3 = Xi_3(1);
    y_3 = Xi_3(2);
    h1 = plot(0,0,'.','MarkerSize',40 ,'Color',color );
    h2 = line([0,x_1],[0,y_1],'LineWidth',3,'Color',color );
    h3 = plot(x_1,y_1,'.','MarkerSize',40 ,'Color',color );
    h4 = line([x_1,x_2],[y_1,y_2],'LineWidth',3,'Color',color );
    h5 = plot(x_2,y_2,'.','MarkerSize',40 ,'Color',color );
    h6 = line([x_2,x_3],[y_2,y_3],'LineWidth',3,'Color',color );
    h7 = plot(x_3,y_3,'.','MarkerSize',40,'Color',color);
    
    H = [h1;h2;h3;h4;h5;h6;h7];
end

function delplot(H)
delete(H(1))
delete(H(2))
delete(H(3))
delete(H(4))
delete(H(5))
delete(H(6))
delete(H(7))
end




function h = circle2(x,y,r)
d = r*2;
px = x-r;
py = y-r;
h = rectangle('Position',[px py d d],'Curvature',[1,1]);
end