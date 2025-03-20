
% bwconncomp(): scans a binary image and finds all the connected components
%   returns a structure cc = Connectivity: 8, ImageSize: [512 512]
%                               NumObjects: 7, PixelIdxList: {1x7 cell}

function capsule_data = identify(part_img, expected_count, results_dir)
    cc = bwconncomp(part_img);

    % Extract detailed capsule information
    % A. Missing units:
    detected_count = cc.NumObjects;
    missing_count = expected_count - detected_count; 

    % set status according to missing capsule(s) count
    if missing_count == 0
       status = 'Pass';
    else 
        status = 'Fail';
    end 

    fprintf("Detected: %d, Missing: %d, Status: %s\n", ...
            detected_count, missing_count, status); % debugging
   
    % B. Bounding box(es), area(s), position(s), size(s)
    stat = regionprops(cc, 'BoundingBox', 'Area');
    position = zeros(length(stat), 4); % [x, y, width, height]
    size = zeros(length(stat), 1); % area in px

    % Store capsule data 
    for i = 1:length(stat)
        position(i,:) = stat(i).BoundingBox; 
        size(i) = stat(i).Area;
    end 

    capsule_data.expected = expected_count;
    capsule_data.detected_count = detected_count; 
    capsule_data.missing_count = missing_count; 
    capsule_data.status = status; 
    capsule_data.position = position;
    capsule_data.size = size;
    
    % Save all capsule data as a txt file
    file = fopen(fullfile(results_dir, 'capsule_data.txt'), 'w');
    fprintf(file, 'Status: %s\n\n', capsule_data.status);
    fprintf(file, 'Expected count: %d\n', capsule_data.expected);
    fprintf(file, 'Detected count: %d\n', capsule_data.detected_count);
    fprintf(file, 'Missing count: %d\n', capsule_data.missing_count);
    for i = 1:length(stat)
        fprintf(file, ['Capsule %d - Position: [%.2f, %.2f, %.2f, %.2f],' ...
                         'Size (Area): %.2f pixels\n'], ...
                i, position(i,1), position(i,2), position(i,3), ...
                position(i,4), size(i));
    end
    fclose(file);
end
