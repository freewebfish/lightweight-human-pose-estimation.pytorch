close all
clear all

global jointId;
global skeletonPair;

jointId = struct("Nose", 1, "Neck", 2, ...
            "RShoulder", 3, "RElbow", 4, "RWrist", 5, ...
            "LShoulder", 6, "LElbow", 7, "LWrist", 8, ...            
            "MidHip", 9, ...
            "RHip", 10, "RKnee", 11, "RAnkle", 12, ...
            "LHip", 13, "LKnee", 14, "LAnkle", 15, ...            
            "REye", 16, "LEye", 17, "REar", 18, "LEar", 19, ...
            "LBigToe", 20, "LSmallToe", 21, "LHeel", 22, ...            
            "RBigToe", 23, "RSmallToe", 24, "RHeel", 25, ...  
            "Background", 26);
skeletonPair = [[jointId.Nose,jointId.REye]; [jointId.REye,jointId.REar]; ...
                [jointId.Nose,jointId.LEye]; [jointId.LEye,jointId.LEar]; ...
                [jointId.Nose,jointId.Neck]; [jointId.Neck,jointId.MidHip]; ...
                [jointId.Neck,jointId.RShoulder]; [jointId.RShoulder,jointId.RElbow]; [jointId.RElbow,jointId.RWrist]; ...
                [jointId.Neck,jointId.LShoulder]; [jointId.LShoulder,jointId.LElbow]; [jointId.LElbow,jointId.LWrist]; ...
                [jointId.MidHip,jointId.RHip]; [jointId.RHip,jointId.RKnee]; [jointId.RKnee,jointId.RAnkle]; [jointId.RAnkle,jointId.RHeel]; ...
                [jointId.MidHip,jointId.LHip]; [jointId.LHip,jointId.LKnee]; [jointId.LKnee,jointId.LAnkle]; [jointId.LAnkle,jointId.LHeel]; ...
                [jointId.RAnkle,jointId.RBigToe]; [jointId.RBigToe,jointId.RSmallToe]; ...
                [jointId.LAnkle,jointId.LBigToe]; [jointId.LBigToe,jointId.LSmallToe]];
scorebar = 0.2;

filePath = 'D:\CodeBucket\openpose\bin\tmp';
fileList = dir(fullfile(filePath, 'prepchick_*_keypoints.json'));

figure; 
for kk=1:1:length(fileList)
    fileName = fileList(kk).name; 
    fid = fopen(fullfile(filePath, fileName)); % Opening the file
    raw = fread(fid,inf); % Reading the contents
    str = char(raw'); % Transformation
    fclose(fid); % Closing the file
    data = jsondecode(str); % Using the jsondecode function to parse JSON from string
    ts = regexp(fileName,'\d','match');
    fs = cat(2,ts{:});
    frameNumber = str2double(fs);
    gcf; clf; hold on;    
    if (~isempty(data.people))
        for jj = 1:1:length(data.people)
            px = data.people(jj).pose_keypoints_2d(1:3:end);
            py = 350 - data.people(jj).pose_keypoints_2d(2:3:end);
            ps = data.people(jj).pose_keypoints_2d(3:3:end);
            plot(px(ps>=scorebar), py(ps>=scorebar), '*');            
            for mm = 1:1:size(skeletonPair,1)
                if all(ps(skeletonPair(mm,:))>=scorebar)
                    plot(px(skeletonPair(mm,:)),py(skeletonPair(mm,:)));
                end
            end            
        end
    end
    gcf; grid on; xlim([0 640]); ylim([0 360]); box on;
    plot([250,250,350,350,250]',[50,150,150,50,50]');
    text(20,20,['frame# ' num2str(frameNumber)],'FontSize',10);
    gcf; hold off;        
    pause(0.1);
end


    

% // Result for BODY_25 (25 body parts consisting of COCO + foot)
% // const std::map<unsigned int, std::string> POSE_BODY_25_BODY_PARTS {
% //     {0,  "Nose"},
% //     {1,  "Neck"},
% //     {2,  "RShoulder"},
% //     {3,  "RElbow"},
% //     {4,  "RWrist"},
% //     {5,  "LShoulder"},
% //     {6,  "LElbow"},
% //     {7,  "LWrist"},
% //     {8,  "MidHip"},
% //     {9,  "RHip"},
% //     {10, "RKnee"},
% //     {11, "RAnkle"},
% //     {12, "LHip"},
% //     {13, "LKnee"},
% //     {14, "LAnkle"},
% //     {15, "REye"},
% //     {16, "LEye"},
% //     {17, "REar"},
% //     {18, "LEar"},
% //     {19, "LBigToe"},
% //     {20, "LSmallToe"},
% //     {21, "LHeel"},
% //     {22, "RBigToe"},
% //     {23, "RSmallToe"},
% //     {24, "RHeel"},
% //     {25, "Background"}