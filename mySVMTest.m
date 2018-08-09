load fisheriris
dosfeaturesfilename = 'dosFeatures.mat';
doslabelsfilename = 'dosLabels.mat';
u2rfeaturesfilename = 'u2rFeatures.mat';
u2rlabelsfilename = 'u2rLabels.mat';
u2rFeatures = load(u2rfeaturesfilename)
u2rLabels = load(u2rlabelsfilename)
dosFeatures = load(dosfeaturesfilename)
dosLabels = load(doslabelsfilename)

remove_probes = ~strcmp(u2rLabels.u2rLabels.HLClass, 'probe');
remove_r2l = ~strcmp(u2rLabels.u2rLabels.HLClass, 'r2l');
u2rinds = remove_probes & remove_r2l;
u2rX = u2rFeatures.u2rFeatures.HTTPorFTPandExeCodeCount(u2rinds, 1:7);
u2ry = u2rLabels.u2rLabels.HLClass(u2rinds);
u2rSVMModel = fitcsvm(u2rX,u2ry,'KernelFunction','gaussian')
u2rclassOrder = u2rSVMModel.ClassNames

u2rindsneg = strcmp(u2rLabels.u2rLabels.HLClass, 'R');
newu2rX = u2rFeatures.u2rFeatures.HTTPorFTPandExeCodeCount(u2rinds, 1:7);%using u2rinds means that the indexes will not match up with the labels file. Find solution
u2routcome = predict(u2rSVMModel, newu2rX);

%to do this correctly the below line needs to contain all lines from the file.
%this contains r2l label. look at cause of this and find problem.
dosinds = ~strcmp(dosLabels.dosLabels.HLClass, 'r2l');%be careful here. This requires spaces. This may need to be changed later.
dosX = dosFeatures.dosFeatures.SYNCount(dosinds, 4:7);
dosy = dosLabels.dosLabels.HLClass(dosinds);

dosSVMModel = fitcsvm(dosX,dosy,'KernelFunction','gaussian')%gaussian must be specifed for any results. With the linear kernel, everything is predicted as 'R'

%dosclassOrder = dosSVMModel.ClassNames

%dossv = dosSVMModel.SupportVectors;
%figure
%gscatter(dosX(:,1),dosX(:,2),dosy)
%hold on
%plot(dossv(:,1),dossv(:,2),'.','MarkerSize',10)
%legend('dos','r','Support Vector')
%hold off


dosindsneg = strcmp(dosLabels.dosLabels.HLClass, ' R');
newDosX = dosFeatures.dosFeatures.SYNCount(dosinds,4:7);
dosoutcome = predict(dosSVMModel, newDosX);

%inds = ~strcmp(species,'setosa');
%X = meas(inds,3:4);
%y = species(inds);

%SVMModel = fitcsvm(X,y,'KernelFunction','linear','Standardize',true')
%SVMModel = fitcsvm(X,y)

%classOrder = SVMModel.ClassNames
%{
sv = SVMModel.SupportVectors;
figure
gscatter(X(:,1),X(:,2),y)
hold on
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
legend('versicolor','virginica','Support Vector')
hold off
%}
%indsneg = strcmp(species,'setosa');
%newX = meas(inds,3:4);
%predict(SVMModel, newX)