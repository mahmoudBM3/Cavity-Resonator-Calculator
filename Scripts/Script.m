%Defining the Speed of light and Constants
c=3*(10^8);
Muo=4*pi*10^-7;
eo=(10^-9)/(36*pi);
%***************Taking Cavity Parameters as input************%
%Enter the loss tangent and Calculating Qdielectric%
tandel=input("tan(δ) : ");
Qd=1/tandel;
%Enter the Dielectric Constant%
er=input("Enter The Dielectric Constant :");
cr=c/sqrt(er);
%Enter The Conductivity of the walls Metal%
cond=input("σ : ");
%Taking Cavity Dimensions as input
a=input("a in Cm : ")*(10^-2);
b=input("b in Cm : ")*(10^-2);
d=input("d in Cm : ")*(10^-2);
%***********************************************************%
%***************Calculating for the first resonance Frequency**************%
%Calculating First Res Freq TE101 and its Qulaity Factor%
fc_101=calcResFreq(a,b,d,1,0,1,cr);
fprintf("First Resonance Frequency corresponds to TE101 Mode\n");
fprintf("First Resonance Frequency = %d Hz\n",fc_101);
k_101=2*pi*fc_101/cr;
Eta=sqrt(Muo/(eo*er));
Rs_101=sqrt(pi*fc_101*Muo/cond);
Q_101=((k_101*a*d)^3)*b*Eta/((2*Rs_101*(pi^2))*(2*(a^3)*b+2*b*(d^3)+(a^3)*d+a*(d^3)));
Q=(Qd*Q_101)/(Qd+Q_101);
fprintf("Its Quality Factor= %d\n",Q);
fprintf("Its Fractional Bandwidth= %d %% \n",100/Q);
fprintf("Its Actual Bandwidth : %d Hz\n", fc_101/Q);
%Calculating for TE102%
fc_102=calcResFreq(a,b,d,1,0,2,cr);
k_102=2*pi*fc_102/cr;
Rs_102=sqrt(pi*fc_102*Muo/cond);
Q_102=((k_102*a*d)^3)*b*Eta/((2*Rs_102*(pi^2))*(8*(a^3)*b+2*b*(d^3)+4*(a^3)*d+a*(d^3)));
%Calculating for TE011%
fc_011=calcResFreq(a,b,d,0,1,1,cr);
w_011=2*pi*fc_011;
Rs_011=sqrt(pi*fc_011*Muo/cond);
Q_011=(w_011^3)*(Muo^2)*eo*er*(b^3)*a*d/(2*(pi^2)*Rs_011*(2*a*d+b*d+(b^3)/d+2*(b^3)*a/(d^2)));
if (fc_102<=fc_011)
    %The next resonance is TE102%
    fprintf("Next Resonance frequency corresponds to TE102 Mode\n");
    fprintf("Second Resonance Frequency = %d Hz\n",fc_102);
    Q=(Qd*Q_102)/(Qd+Q_102);
    fprintf("Its Quality Factor = %d\n",Q);
    fprintf("Its Fractional Bandwidth : %d %% \n", 100/Q);
    fprintf("Its Actual Bandwidth : %d Hz\n", fc_102/Q);
else
    %The next resonance is TE011%
    fprintf("Next Resonance frequency corresponds to TE011 Mode\n");
    fprintf("Second Resonance Frequency = %d Hz\n",fc_011);
    Q=(Qd*Q_011)/(Qd+Q_011);
    fprintf("Its Quality Factor = %d\n",Q);
    fprintf("Its Fractional Bandwidth : %d %% \n", 100/Q);
    fprintf("Its Actual Bandwidth : %d Hz\n", fc_011/Q);
end
function fc = calcResFreq(a,b,d,m,n,l,cr)
kx=(m*pi/a);
ky=(n*pi/b);
B=(l*pi/d);
k=sqrt((kx^2)+(ky^2)+(B^2));
fc=cr*k/(2*pi);
end