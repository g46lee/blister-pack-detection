% bwareaopen(binary_img, 200): remove small objects
%   deletes connected blobs (white regions) with fewer than 200 pixels) 
%   why use it: after binarization, small specks of noise may show up as 
%   objects
%   Effect: keeps only larger, meanignful obj (like capsules)

% HSV = rgb2hsv(RGB)
%   derive H, S, V values to achieve yellow color isolation to take
%   advantage of yellow-colored capsules. 

function part_img = part_analyze(img, results_dir)
    hsv_img = rgb2hsv(img); % rgb to hsv conversion
    H = hsv_img(:,:,1); % hue
    S = hsv_img(:,:,2); % saturation 
    V = hsv_img(:,:,3); % value 

    % yellow color isolation via masking
    yellow_mask = (H > 0.01 & H < 0.2) & (S > 0.3) & (V > 0.5);

    % morphological operations
    morph_img = imfill(yellow_mask, 'holes');
    % se = strel('rectangle',1);
    se = strel('disk', 1); % structuring element (disk shape)
    morph_img = imdilate(morph_img, se);
    morph_img = imerode(morph_img, se); 
    morph_img = bwareaopen(morph_img, 700);

    part_img = morph_img; 
    imwrite(part_img, fullfile(results_dir, "binary_img.png"));
end