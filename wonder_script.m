function wonder_script()
% Finds the test.txt file in the dataDir directory
% Read the content of the test.txt file and 
% concatenate it with extra information, e.g, hostname, OS, Matlab version, etc.
% Saves new content as results.txt in dataDir

% Read test.txt
testFilename = 'test.txt';
dataDir = 'data';
testFilename = fullfile(dataDir, testFilename);
content = fileread(testFilename);

% Date
dateStr = ['DateTime: ' char(datetime, "yyyy-MM-dd HH:mm:ss")];

% OS information
if strncmp(computer,'PC',2)
    [~, ver] = system('ver');
    osInfo = strtrim(ver);

elseif strncmp(computer,'MAC',3)
    % OS info
    [~, sw_vers] = system('sw_vers');
    osName = regexp(sw_vers, '(?<=ProductName:)(.*?)(?=\n)', 'match');
    osName = strtrim(osName{1});
    osVer = regexp(sw_vers, '(?<=ProductVersion:)(.*?)(?=\n)', 'match');
    osVer = strtrim(osVer{1});
    [~, osHw] = system('uname -m');
    osHw = strtrim(osHw);
    osInfo = [osName, ' ' osVer, ' (', osHw, ')'];

elseif strncmp(computer,'GLNX',4)
    % OS info
    os_release = fileread('/etc/os-release');
    osName = regexp(os_release, '(?<=PRETTY_NAME=")(.*?)(?=")', 'match');
    osName = osName{1};
    [~, kernelVer] = system('uname -r');
    kernelVer = strtrim(kernelVer);
    osInfo = [osName, ' (' kernelVer, ')'];

else
    osInfo = 'Strange host';
end
osInfo = ['OS: ' osInfo];

% Hostname
[~, hostName] = system('hostname');
hostName = ['hostname: '  strtrim(hostName)];
    
% Get Matlab version
matlabVer = ['Matlab:', ' ', version('-release')];

% New content
contentNew = [content 10, dateStr, 10, osInfo, 10, hostName, 10, matlabVer];

% Save results
resultFileName = 'results.txt';
resultFileName = fullfile(dataDir, resultFileName);
fileID = fopen(resultFileName,'w');
fprintf(fileID, contentNew);
fclose(fileID);
    