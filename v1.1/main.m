
img = imread('input_img/sample_blister.jpg'); % renamed input img file name

% Extract date&time, and create file directory (if x already exists)
time = string(datetime("now", "Format", "yyyyMMdd_HHmmss"));
results_dir = fullfile("results", time);
if ~exist(results_dir, "dir")
    mkdir(results_dir);
end

% processed_img = preprocess(img, results_dir);
part_img = part_analyze(img, results_dir);  % pass original RGB image
capsule_data = identify(part_img, 10, results_dir); % identify + analyze detected capsules
% disp(capsule_data.status);
visualize(img, part_img, capsule_data, results_dir);