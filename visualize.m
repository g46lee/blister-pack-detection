function visualize(img, processed_img, part_img, capsule_data, results_dir)
    % Get capsule bounding boxes from binary image
    stats = regionprops(part_img, 'BoundingBox');
    
    figure;
    subplot(1,3,1);
    imshow(img); 
    
    hold on;
    title('Original Image')

    for i = 1: length(stats)
        rectangle('Position', stats(i).BoundingBox, 'EdgeColor', 'g');
    end 

    text(0.01, 0.05, ['Status: ' capsule_data.status], 'Units', ...
                        'normalized');
    text(0.02, 0.95, ['Capsules: ' num2str(capsule_data.detected_count) ...
                      ' / ' num2str(capsule_data.expected)], 'Units', ...
                      'normalized');
    hold off;

    subplot(1,3,2);
    imshow(processed_img);
    title('Pre-processed Image')

    subplot(1,3,3);
    imshow(part_img);
    title('Analyzed Image')

    saveas(gcf, fullfile(results_dir, "comparison_img.png"));
end

    

