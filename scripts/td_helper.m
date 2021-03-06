%% td_helper
% Miscellaneous impromptu routines
%% Collect median psds over channels from ft freq structures
[fnam, pth] = uigetfile({'^psd*_clean.mat'},'MultiSelect','on');
psd_controls = zeros(length(fnam),45);

for subi  = 1:length(fnam)
    thisfile = deblank([pth filesep fnam{1,subi}]);
    load(thisfile);
    psd_controls(subi,:) = median(psd.powspctrm,1);
    clear psd
end
%%
PSD.data = [psd_controls;psd_patients];    
PSD.groups = [zeros(size(psd_controls,1),1); ones(size(psd_patients,1),1)];  
PSD.freq   = 2:0.5:24;
save PSD.mat PSD
%% Collect model fits
[fnam, pth] = uigetfile({'^model*clean.mat'},'MultiSelect','on');
ff = 2:0.1:24;
osci_patients = zeros(length(fnam),221);
back_patients = osci_patients;

for subi  = 1:length(fnam)
    thisfile = deblank([pth filesep fnam{1,subi}]);
    load(thisfile);
    osci_patients(subi,:) = model.osc;
    back_patients(subi,:) = model.back;
end

figure;
plot(ff,osci_patients','Color',[.8 .8 .8]);
hold
plot(ff,mean(osci_patients)','LineWidth',3,'LineStyle',':');
%% Collect CF

[fnam, pth] = uigetfile({'^zfit*clean.mat'},'MultiSelect','on');
cf = zeros(length(fnam),1);
for subi  = 1:length(fnam)
    thisfile = deblank([pth filesep fnam{1,subi}]);
    load(thisfile);
    cf(subi) = params.osc.centerfreq;
end


%% Collect osci model

[fnam, pth] = uigetfile({'^model*clean.mat'},'MultiSelect','on');
m = zeros(length(fnam),221);
for subi  = 1:length(fnam)
    thisfile = deblank([pth filesep fnam{1,subi}]);
    load(thisfile);
    m(subi,:) = model.osc;
end
%%
OSC.data = [cm;pm];    
OSC.groups = [zeros(size(cm,1),1); ones(size(pm,1),1)];  
OSC.freq   = 2:0.1:24;
save OSC.mat OSC
%% Collect amp

[fnam, pth] = uigetfile({'^zfit*clean.mat'},'MultiSelect','on');
pamp = zeros(length(fnam),1);
for subi  = 1:length(fnam)
    thisfile = deblank([pth filesep fnam{1,subi}]);
    load(thisfile);
    pamp(subi) = params.osc.amplitude;
end