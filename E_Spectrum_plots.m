close all

load("S_36percent.mat")
Y_exp=S.Amplitude_exp;
Y_fit=S.Amplitude_fit;
x_ppm=S.ppm;

figure(1)
plot(x_ppm,Y_exp,'r--',x_ppm,Y_fit,'k','LineWidth',1.0)
xlim([-2.5 7.2]);
ylim([-0.13 1.25]);
legend('SVS-STEAM data','AMARES Fit');
xlabel('\delta_{cs} in ppm');
ylabel('Signal in a.u.');
ax            = gca;
ax.XTick      = -8:1:8;
ax.YGrid      ="on";
ax.XGrid      = "on";
ax.XMinorGrid = "on";
ax.YMinorGrid = "on";
ax.FontSize   = 13;
saveas(gcf,'Acetone_36Pervent_AMARES_Spectrum.png')
%% 60% 

load("S_60percent.mat")
Y_exp=S.Amplitude_exp;
Y_fit=S.Amplitude_fit;
x_ppm=S.ppm;

figure(2)
plot(x_ppm,Y_exp,'r--',x_ppm,Y_fit,'k','LineWidth',1.0)
xlim([-2.5 7.2]);
ylim([-0.13 1.25]);
legend('SVS-STEAM data','AMARES Fit');
xlabel('\delta_{cs} in ppm');
ylabel('Signal in a.u.');
ax            = gca;
ax.XTick      = -8:1:8;
ax.YGrid      ="on";
ax.XGrid      = "on";
ax.XMinorGrid = "on";
ax.YMinorGrid = "on";
ax.FontSize   = 13;

saveas(gcf,'Acetone_60Pervent_AMARES_Spectrum.png')
