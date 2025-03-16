
function processed_img = preprocess(img, results_dir)
    % convert to grayscale if image is RGB
    if size(img, 3) == 3
        img = rgb2gray(img);
    end

    sigma = 1; % stdev for gaussfilt
    img = imgaussfilt(img, sigma); % gaussian filtering
    img = imadjust(img); % contrast enhancement 

    processed_img = img;
    imwrite(processed_img, fullfile(results_dir, "preprocessed.jpg"));
end 