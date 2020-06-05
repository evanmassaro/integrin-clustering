% load the images
len = fileVersion;
images = cell(len,1);
name = folderName;

for i = 1:len+1
    str = [name,'_', num2str(i-1), '.png'];
    images{i} = imread(str);
    disp(i/(len+1))
end

writerObj = VideoWriter([name,'.avi']);
writerObj.FrameRate = 30; %frames per second
open(writerObj);

% write the frames to the video
for u = 1:length(images)
    % convert the image to a frame
    frame = im2frame(images{u});
        writeVideo(writerObj, frame);
        disp(u/length(images))
end
% close the writer object
close(writerObj);

