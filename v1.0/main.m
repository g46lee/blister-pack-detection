
img = imread('data/sample_blister.jpg');

time = string(datetime("now", "Format", "yyyyMMdd_HHmmss"));
results_dir = fullfile("results", time);
if ~exist(results_dir, "dir")
    mkdir(results_dir);
end

processed_img = preprocess(img, results_dir); % preprocess the image
part_img = part_analyze(processed_img, results_dir); % segment the image
capsule_data = identify(part_img, 10); % identify + analyze detected capsules
% disp(capsule_data.status);
visualize(img, processed_img, part_img, capsule_data, results_dir);