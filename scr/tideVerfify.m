%% 
%%%------------------------------------------------------------------------
%%%                          PATH CONFIGURATION
%%%------------------------------------------------------------------------
diary on;
% Which system am I using?
if ismac    % On Mac
    basedir = '/Users/yulong/Documents/';
    addpath([basedir,'tools/fvcom-toolbox/']);
    addpath([basedir,'tools/fvcom-toolbox/fvcom_prepro/']);
    addpath([basedir,'tools/fvcom-toolbox/utilities/']);
elseif isunix       % Unix?
    basedir = '/home/usr0/n70110d/';
    addpath([basedir,'github/fvcom-toolbox/']);
    addpath([basedir,'github/fvcom-toolbox/fvcom_prepro/']);
    addpath([basedir,'github/fvcom-toolbox/utilities/']);
elseif ispc     % Or Windows?
    basedir = 'C:/Users/Yulong WANG/Documents/GitHub/';      
    addpath([basedir,'fvcom-toolbox/']);
    addpath([basedir,'fvcom-toolbox/fvcom_prepro/']);
    addpath([basedir,'fvcom-toolbox/utilities/']);
end

outputFiles.base = [basedir,'works/hsi_case/test_tide_small_mesh/'];
tideObserve.base = [basedir,'data/jdoss_tide/'];

tideObserve.stationName = {...
    '0161','kurihamako';...
    '3002','dainikaiho';...
    'GS01','aburatsubo';...
    'GS11','katsuura';...
    'HD06','chiba';...
    'HD29','yokohamashinko';...
    'MA14','mera';...
    'MA15','tokyo';...
    'MA17','okada'...
    };

%% 
%%%------------------------------------------------------------------------
%%%                          SPATIAL CONFIGURATION
%%%------------------------------------------------------------------------

tideObserve.readYear = '2011';
tideObserve.readMonth = '01';
plotdata.startDate = [2011,01,02,00,00,00];
plotdata.endDate = [2011,01,16,00,00,00];
plotdata.startDateMJD = greg2mjulian(plotdata.startDate(1),...
    plotdata.startDate(2),plotdata.startDate(3),plotdata.startDate(4),...
    plotdata.startDate(5),plotdata.startDate(6));
plotdata.endDateMJD = greg2mjulian(plot.endDate(1),...
    plotdata.endDate(2),plotdata.endDate(3),plotdata.endDate(4),...
    plotdata.endDate(5),plotdata.endDate(6));
list.month = {'01';'02';'03';'04';'05';'06';'07';'08';'09';'10';'11';'12'};
list.day1 = {'31';'28';'31';'30';'31';'30';'31';'31';'30';'31';'30';'31'};
list.day2 = {'31';'29';'31';'30';'31';'30';'31';'31';'30';'31';'30';'31'};

tideObserve.stationChange.kurihamako = {...
    '2001','01','01','-182.40';...
    '2002','01','01','-186.70';...
    '2015','06','01','-193.50'};
tideObserve.stationChange.dainikaiho = {...
    '2011','01','01','-108.40';...
    '2014','01','01','-103.20'};
tideObserve.stationChange.aburatsubo = {...
    '1933','01','01','-180.50';...
    '1991','01','01','-184.60';...
    '1997','01','01','-248.40';...
    '2002','04','01','-251.50';...
    '2011','11','01','-258.40'};
tideObserve.stationChange.katsuura = {...
    '1967','01','01','-293.10';...
    '1991','01','01','-296.20';...
    '2002','04','01','-299.80'};...
tideObserve.stationChange.chiba = {...
    '1964','07','01','-166.30';...
    '1987','01','01','-177.40'};
tideObserve.stationChange.yokohamashinko = {...
    '1997','09','01','-216.20';...
    '2009','01','01','-217.90'};
tideObserve.stationChange.mera = {...
    '1965','01','01','-124.50';...
    '1968','01','01','-126.40';...
    '1969','01','01','-129.90';...
    '1975','01','01','-128.40';...
    '1987','01','01','-127.00';...
    '1994','01','01','-134.00';...
    '1999','01','01','-132.60';...
    '2000','01','01','-134.80';...
    '2002','01','01','-131.90';...
    '2003','01','01','-137.40';...
    '2009','01','01','-138.40'};
tideObserve.stationChange.tokyo = {...
    '1961','01','01','-180.00';...
    '1968','01','01','-181.10';...
    '1978','01','01','-182.90';...
    '1982','04','01','-184.10';...
    '1988','01','01','-185.20';...
    '2011','03','11','-188.40'};
tideObserve.stationChange.okada = {...
    '1964','01','01','-155.00'};

%%
[m(1,1),~] = size(tideObserve.stationChange.kurihamako);
[m(2,1),~] = size(tideObserve.stationChange.dainikaiho);
[m(3,1),~] = size(tideObserve.stationChange.aburatsubo);
[m(4,1),~] = size(tideObserve.stationChange.katsuura);
[m(5,1),~] = size(tideObserve.stationChange.chiba);
[m(6,1),~] = size(tideObserve.stationChange.yokohamashinko);
[m(7,1),~] = size(tideObserve.stationChange.mera);
[m(8,1),~] = size(tideObserve.stationChange.tokyo);
[m(9,1),~] = size(tideObserve.stationChange.okada);

%%
i = 0;
while i<=max(m)
    if str2num(tideObserve.stationChange.kurihamako{i+1,1}) < str2num(tideObserve.readYear)
        i = i + 1;
    else
        break
    end
end
m(1,2) = i;
i = 0;
while i<=max(m)
    if str2num(tideObserve.stationChange.dainikaiho{i+1,1}) < str2num(tideObserve.readYear)
        i = i + 1;
    else
        break
    end
end
m(2,2) = i;
i = 0;
while i<=max(m)
    if str2num(tideObserve.stationChange.aburatsubo{i+1,1}) < str2num(tideObserve.readYear)
        i = i + 1;
    else
        break
    end
end
m(3,2) = i;
i = 0;
while i<=max(m)
    if str2num(tideObserve.stationChange.katsuura{i+1,1}) < str2num(tideObserve.readYear)
        i = i + 1;
    else
        break
    end
end
m(4,2) = i;
i = 0;
while i<=max(m)
    if str2num(tideObserve.stationChange.chiba{i+1,1}) < str2num(tideObserve.readYear)
        i = i + 1;
    else
        break
    end
end
m(5,2) = i;
i = 0;
while i<=max(m)
    if str2num(tideObserve.stationChange.yokohamashinko{i+1,1}) < str2num(tideObserve.readYear)
        i = i + 1;
    else
        break
    end
end
m(6,2) = i;
i = 0;
while i<=max(m)
    if str2num(tideObserve.stationChange.mera{i+1,1}) < str2num(tideObserve.readYear)
        i = i + 1;
    else
        break
    end
end
m(7,2) = i;
i = 0;
while i<=max(m)
    if str2num(tideObserve.stationChange.tokyo{i+1,1}) < str2num(tideObserve.readYear)
        i = i + 1;
    else
        break
    end
end
m(8,2) = i;
i = 0;
while i<=max(m)
    if str2num(tideObserve.stationChange.okada{i+1,1}) < str2num(tideObserve.readYear)
        i = i + 1;
    else
        break
    end
end
m(9,2) = i;
%% 
%%%------------------------------------------------------------------------
%%%                          READ OBSERVATION DATA
%%%------------------------------------------------------------------------

for i=1:length(tideObserve.stationName)
    tideObserve.foldername{i,1} = [tideObserve.base,tideObserve.stationName{i,1},'_',tideObserve.stationName{i,2},'/'];
    % fprintf('%s\n',tideObserve.foldername{i,1});
    filename = [tideObserve.stationName{i,1},'-',tideObserve.readYear];
    tideObserve.filename{i,1} = [tideObserve.foldername{i,1},filename,'.txt'];
    % fprintf('%s\n',tideObserve.filename{i,1});
end
clear i j filename

tideObserve.data.kurihamako = importJdossTide(tideObserve.filename{1,1}, 1, 365);
tideObserve.data.dainikaiho = importJdossTide(tideObserve.filename{2,1}, 1, 365);
tideObserve.data.aburatsubo = importJdossTide(tideObserve.filename{3,1}, 1, 365);
tideObserve.data.katsuura = importJdossTide(tideObserve.filename{4,1}, 1, 365);
tideObserve.data.chiba = importJdossTide(tideObserve.filename{5,1}, 1, 365);
tideObserve.data.yokohamashinko = importJdossTide(tideObserve.filename{6,1}, 1, 365);
tideObserve.data.mera = importJdossTide(tideObserve.filename{7,1}, 1, 365);
tideObserve.data.tokyo = importJdossTide(tideObserve.filename{8,1}, 1, 365);
tideObserve.data.okada = importJdossTide(tideObserve.filename{9,1}, 1, 365);

tideObserve.data.kurihamako = tideObserve.data.kurihamako';
tideObserve.data.dainikaiho = tideObserve.data.dainikaiho';
tideObserve.data.aburatsubo = tideObserve.data.aburatsubo';
tideObserve.data.katsuura = tideObserve.data.katsuura';
tideObserve.data.chiba = tideObserve.data.chiba';
tideObserve.data.yokohamashinko = tideObserve.data.yokohamashinko';
tideObserve.data.mera = tideObserve.data.mera';
tideObserve.data.tokyo = tideObserve.data.tokyo';
tideObserve.data.okada = tideObserve.data.okada';

tideObserve.data.kurihamako = reshape(tideObserve.data.kurihamako,365*24,1);
tideObserve.data.dainikaiho = reshape(tideObserve.data.dainikaiho,365*24,1);
tideObserve.data.aburatsubo = reshape(tideObserve.data.aburatsubo,365*24,1);
tideObserve.data.katsuura = reshape(tideObserve.data.katsuura,365*24,1);
tideObserve.data.chiba = reshape(tideObserve.data.chiba,365*24,1);
tideObserve.data.yokohamashinko = reshape(tideObserve.data.yokohamashinko,365*24,1);
tideObserve.data.mera = reshape(tideObserve.data.mera,365*24,1);
tideObserve.data.tokyo = reshape(tideObserve.data.tokyo,365*24,1);
tideObserve.data.okada = reshape(tideObserve.data.okada,365*24,1);

%% 
%%%------------------------------------------------------------------------
%%%                       ASSIMILITE OBSERVATION DATA
%%%------------------------------------------------------------------------

tideObserve.log(1,1) = length(tideObserve.stationChange.kurihamako);
tideObserve.log(2,1) = length(tideObserve.stationChange.dainikaiho);
tideObserve.log(3,1) = length(tideObserve.stationChange.aburatsubo);
tideObserve.log(4,1) = length(tideObserve.stationChange.katsuura);
tideObserve.log(5,1) = length(tideObserve.stationChange.chiba);
tideObserve.log(6,1) = length(tideObserve.stationChange.yokohamashinko);
tideObserve.log(7,1) = length(tideObserve.stationChange.mera);
tideObserve.log(8,1) = length(tideObserve.stationChange.tokyo);
tideObserve.log(9,1) = length(tideObserve.stationChange.okada);

% ncdisp tokyobay_station_timeseries.nc
sim.elevation = ncread('tokyobay_station_timeseries.nc','zeta');
sim.datetime = plotdata.startDateMJD:1/24:plotdata.endDateMJD;
sim.datetime = sim.datetime';
sim.TimeDT = datetime(sim.datetime, 'ConvertFrom', 'modifiedjuliandate', 'Format', 'yyyy-MM-dd hh:mm:ss');

correct.kurihamako = str2num(tideObserve.stationChange.kurihamako{2,4})*ones(365*24,1);
tideNew.kurihamako = (tideObserve.data.kurihamako + correct.kurihamako)*0.01;
X1 = sim.TimeDT;
YMatrix1(1,:) = tideNew.kurihamako(24:15*24,1)';
YMatrix1(2,:) = sim.elevation(1,15:15*24-9);
createfigure(X1, YMatrix1, 'Kurihamako');


correct.dainikaiho = str2num(tideObserve.stationChange.dainikaiho{1,4})*ones(365*24,1);
tideNew.dainikaiho = (tideObserve.data.dainikaiho + correct.dainikaiho)*0.01;
X2 = sim.TimeDT;
YMatrix2(1,:) = tideNew.dainikaiho(24:15*24,1)';
YMatrix2(2,:) = sim.elevation(2,15:15*24-9);
createfigure(X2, YMatrix2, 'Dainikaiho');


correct.aburatsubo = str2num(tideObserve.stationChange.aburatsubo{5,4})*ones(365*24,1);
tideNew.aburatsubo = (tideObserve.data.aburatsubo + correct.aburatsubo)*0.01;
X3 = sim.TimeDT;
YMatrix3(1,:) = tideNew.aburatsubo(24:15*24,1)';
YMatrix3(2,:) = sim.elevation(3,15:15*24-9);
createfigure(X3, YMatrix3, 'Aburatsubo');


correct.katsuura = str2num(tideObserve.stationChange.katsuura{3,4})*ones(365*24,1);
tideNew.katsuura = (tideObserve.data.katsuura + correct.katsuura)*0.01;
X4 = sim.TimeDT;
YMatrix4(1,:) = tideNew.katsuura(24:15*24,1)';
YMatrix4(2,:) = sim.elevation(4,15:15*24-9);
createfigure(X4, YMatrix4, 'Katsuura');


correct.chiba = str2num(tideObserve.stationChange.chiba{2,4})*ones(365*24,1);
tideNew.chiba = (tideObserve.data.chiba + correct.chiba)*0.01;
X5 = sim.TimeDT;
YMatrix5(1,:) = tideNew.chiba(24:15*24,1)';
YMatrix5(2,:) = sim.elevation(5,15:15*24-9);
createfigure(X5, YMatrix5, 'Chiba');


correct.yokohamashinko = str2num(tideObserve.stationChange.yokohamashinko{2,4})*ones(365*24,1);
tideNew.yokohamashinko = (tideObserve.data.yokohamashinko + correct.yokohamashinko)*0.01;
X6 = sim.TimeDT;
YMatrix6(1,:) = tideNew.yokohamashinko(24:15*24,1)';
YMatrix6(2,:) = sim.elevation(6,15:15*24-9);
createfigure(X6, YMatrix6, 'Yokohamashinko');


correct.mera = str2num(tideObserve.stationChange.mera{11,4})*ones(365*24,1);
tideNew.mera = (tideObserve.data.mera + correct.mera)*0.01;
X7 = sim.TimeDT;
YMatrix7(1,:) = tideNew.mera(24:15*24,1)';
YMatrix7(2,:) = sim.elevation(7,15:15*24-9);
createfigure(X7, YMatrix7, 'Mera');


correct.tokyo = str2num(tideObserve.stationChange.tokyo{5,4})*ones(365*24,1);
tideNew.tokyo = (tideObserve.data.tokyo + correct.tokyo)*0.01;
X8 = sim.TimeDT;
YMatrix8(1,:) = tideNew.tokyo(24:15*24,1)';
YMatrix8(2,:) = sim.elevation(8,15:15*24-9);
createfigure(X8, YMatrix8, 'Tokyo');