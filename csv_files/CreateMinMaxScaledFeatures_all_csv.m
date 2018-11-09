%Same as CreateFeatures_all_csv.m, but saves features scaled using z score so that all
%values have a stdev of one

% Script that finds all csv files in current folder and creates a large
% feature table by appending them all together

%CSVFiles = dir('*.csv');
%CSVFiles = dir(fullfile('C:','Users','User','Downloads', 'Matlab', 'fakedata', '*.csv'));
%CSVFiles = dir(fullfile('C:','Users','User','Documents', 'GitHub', 'ids_svm_slidingwindow', 'fakedata', '*.csv'));
CSVFiles = dir(fullfile('C:','Users','User','Documents', 'GitHub', 'ids_svm_slidingwindow','csv_files', '*.csv'));
%CSVFiles = dir(fullfile('C:','Users','User','Documents', 'GitHub', 'ids_svm_slidingwindow', 'allsplitfiles','*.csv'));%right now this ignores a few files not labeled as csvs
%CSVFiles = dir(fullfile('C:','Users','User','Documents', 'GitHub', 'ids_svm_slidingwindow','inside_5_3_split_3_queso_probe.csv'));

TimeWindows = [1 2 4 8 16 32 60];
%{
% Structure to Store All Features for All Clean Attacks:
AllFeatures = struct;
AllFeatures.CVPacketSize = [];
AllFeatures.ThirdMomentPacketSize = [];
AllFeatures.CVPacketInterarrival = [];
AllFeatures.ThirdMomentPacketInterarrival = [];
AllFeatures.CorJavaScriptCount = [];
AllFeatures.HTTPorFTPandExeCodeCount = [];
AllFeatures.HTTPandMalformedCount = [];
AllFeatures.FTPandCcodeCount = [];
AllFeatures.SYNCount = [];
AllFeatures.ECHOCount = [];

AllLabels = struct;
AllLabels.HLClass = [];
AllLabels.LLClass = [];

%added initialization to remove any issues with Labels
Labels = struct;
Labels.HLClass = [];
Labels.LLClass = [];

% Structure for DoS Attacks:

dosFeatures = struct;
dosFeatures.CVPacketSize = [];
dosFeatures.ThirdMomentPacketSize = [];
dosFeatures.CVPacketInterarrival = [];
dosFeatures.ThirdMomentPacketInterarrival = [];
dosFeatures.CorJavaScriptCount = [];
dosFeatures.HTTPorFTPandExeCodeCount = [];
dosFeatures.HTTPandMalformedCount = [];
dosFeatures.FTPandCcodeCount = [];
dosFeatures.SYNCount = [];
dosFeatures.ECHOCount = [];

dosLabels = struct;
dosLabels.HLClass = [];
dosLabels.LLClass = [];

% Structure for Probe Attacks:

probeFeatures = struct;
probeFeatures.CVPacketSize = [];
probeFeatures.ThirdMomentPacketSize = [];
probeFeatures.CVPacketInterarrival = [];
probeFeatures.ThirdMomentPacketInterarrival = [];
probeFeatures.CorJavaScriptCount = [];
probeFeatures.HTTPorFTPandExeCodeCount = [];
probeFeatures.HTTPandMalformedCount = [];
probeFeatures.FTPandCcodeCount = [];
probeFeatures.SYNCount = [];
probeFeatures.ECHOCount = [];

probeLabels = struct;
probeLabels.HLClass = [];
probeLabels.LLClass = [];

% Structure for User to Root Attacks:

u2rFeatures = struct;
u2rFeatures.CVPacketSize = [];
u2rFeatures.ThirdMomentPacketSize = [];
u2rFeatures.CVPacketInterarrival = [];
u2rFeatures.ThirdMomentPacketInterarrival = [];
u2rFeatures.CorJavaScriptCount = [];
u2rFeatures.HTTPorFTPandExeCodeCount = [];
u2rFeatures.HTTPandMalformedCount = [];
u2rFeatures.FTPandCcodeCount = [];
u2rFeatures.SYNCount = [];
u2rFeatures.ECHOCount = [];

u2rLabels = struct;
u2rLabels.HLClass = [];
u2rLabels.LLClass = [];

% Structure for Remote to Local Attacks:

r2lFeatures = struct;
r2lFeatures.CVPacketSize = [];
r2lFeatures.ThirdMomentPacketSize = [];
r2lFeatures.CVPacketInterarrival = [];
r2lFeatures.ThirdMomentPacketInterarrival = [];
r2lFeatures.CorJavaScriptCount = [];
r2lFeatures.HTTPorFTPandExeCodeCount = [];
r2lFeatures.HTTPandMalformedCount = [];
r2lFeatures.FTPandCcodeCount = [];
r2lFeatures.SYNCount = [];
r2lFeatures.ECHOCount = [];

r2lLabels = struct;
r2lLabels.HLClass = [];
r2lLabels.LLClass = [];


disp("before iteration");
fprintf('the length of the set of CSVFiles is %i\n', length(CSVFiles));
for i = 1:length(CSVFiles)
    disp("iterate through file ");disp(i);disp(CSVFiles(i).name);
    [Features, Labels] = CreateScaledFeatures_function( CSVFiles(i, 1).name, TimeWindows );
    AllLabels.HLClass = [AllLabels.HLClass; Labels.HLClass];
    AllLabels.LLClass = [AllLabels.LLClass; Labels.LLClass];
    AllFeatures.CVPacketSize = [AllFeatures.CVPacketSize; Features.CVPacketSize];
    AllFeatures.ThirdMomentPacketSize = [AllFeatures.ThirdMomentPacketSize; Features.ThirdMomentPacketSize];
    AllFeatures.CVPacketInterarrival = [AllFeatures.CVPacketInterarrival; Features.CVPacketInterarrival];
    AllFeatures.ThirdMomentPacketInterarrival = [AllFeatures.ThirdMomentPacketInterarrival; Features.ThirdMomentPacketInterarrival];
    AllFeatures.CorJavaScriptCount = [AllFeatures.CorJavaScriptCount; Features.CorJavaScriptCount];
    AllFeatures.HTTPorFTPandExeCodeCount = [AllFeatures.HTTPorFTPandExeCodeCount; Features.HTTPorFTPandExeCodeCount];
    AllFeatures.HTTPandMalformedCount = [AllFeatures.HTTPandMalformedCount; Features.HTTPandMalformedCount];
    AllFeatures.FTPandCcodeCount = [AllFeatures.FTPandCcodeCount; Features.FTPandCcodeCount];
    AllFeatures.SYNCount = [AllFeatures.SYNCount; Features.SYNCount];
    AllFeatures.ECHOCount = [AllFeatures.ECHOCount; Features.ECHOCount];
    
end


%normalize with z scores
AllFeatures.CVPacketSize = normalize(AllFeatures.CVPacketSize,'range');
AllFeatures.ThirdMomentPacketSize = normalize(AllFeatures.ThirdMomentPacketSize,'range');
AllFeatures.CVPacketInterarrival = normalize(AllFeatures.CVPacketInterarrival,'range');
AllFeatures.ThirdMomentPacketSize = normalize(AllFeatures.ThirdMomentPacketSize,'range');
AllFeatures.CorJavaScriptCount = normalize(AllFeatures.CorJavaScriptCount,'range');
AllFeatures.HTTPorFTPandExeCodeCount = normalize(AllFeatures.HTTPorFTPandExeCodeCount,'range');
AllFeatures.HTTPandMalformedCount = normalize(AllFeatures.HTTPandMalformedCount,'range');
AllFeatures.FTPandCcodeCount = normalize(AllFeatures.FTPandCcodeCount,'range');
AllFeatures.SYNCount = normalize(AllFeatures.SYNCount,'range');
AllFeatures.ECHOCount = normalize(AllFeatures.ECHOCount,'range');

%note- the missing time windows are created as NaN for now. Compare with leaving as -1 and getting a score and see which performs better.
 %leaving as -1 will cause normalization of -1 and give an value that will
 %be evaluated, but since SVM only uses support vectors, it may not be a
 %problem

%}

% Save output:
save ..\minmax_feature_sets\AllFeatures.mat AllFeatures
save ..\minmax_feature_sets\AllLabels.mat AllLabels


fprintf('the length of the set of CSVFiles is %i\n', length(CSVFiles));
