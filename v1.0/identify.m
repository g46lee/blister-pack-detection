
% bwconncomp(): scans a binary image and finds all the connected components
%   returns a structure cc = Connectivity: 8, ImageSize: [512 512]
%                               NumObjects: 7, PixelIdxList: {1x7 cell}

function capsule_data = identify(part_img, expected_count)
    cc = bwconncomp(part_img);

    detected_count = cc.NumObjects;
    missing_count = expected_count - detected_count; 

    if missing_count == 0
       status = 'Pass';
    else 
        status = 'Fail';
    end 

    fprintf("detected: %d, missing: %d, status: %s\n", ...
            detected_count, missing_count, status); % debugging

    capsule_data.expected = expected_count;
    capsule_data.detected_count = detected_count; 
    capsule_data.missing_count = missing_count; 
    capsule_data.status = status; 
end

    
