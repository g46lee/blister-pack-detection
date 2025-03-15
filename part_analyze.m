% graythresh(processed_img): finds the opt threshold to convert a grayscale
%   img into binary (BW). 
%   Output: threshold b/w 0 -> 1
%   if pixel values > level -> white (capsule)
%                   < level -> black (bg)

% imbinarize(processed_img, level): Img binarization
%   converts the grayscale img -> binary (logical) img using the threshold
%   binary imgs are easier to segment and process - x need pixel intensities anymore
%   Output: 1 = object, 0 background 
%       converts img to BW, where capsules appear white

% bwareaopen(binary_img, 200): remove small objects
%   deletes connected blobs (white regions) with fewer than 200 pixels) 
%   why use it: after binarization, small specks of noise may show up as objects
%   Effect: keeps only larger, meanignful obj (like capsules)


function part_img = part_analyze(processed_img, results_dir)
    % Otsu's method (global thresholding)
    level = graythresh(processed_img); 
    binary_img = imbinarize(processed_img, level);

    binary_img = bwareaopen(binary_img, 300);

    part_img = binary_img;
    imwrite(part_img, fullfile(results_dir, "binary_img.png"));
end
