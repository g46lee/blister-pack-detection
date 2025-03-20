function visualize(img, part_img, capsule_data, results_dir)
    % Extract capsule bounding boxes from binary image
    stat = regionprops(part_img, 'BoundingBox');
    
    figure;
    imshow(img); 
    hold on;

    % Outline detected capsules on the analyzed img
    for i = 1: length(stat)
        rectangle('Position', stat(i).BoundingBox, 'EdgeColor', 'g');
    end 
    
    % Overlay capsule information on the analyzed img
    text(0.01, 0.05, ['Status: ' capsule_data.status], 'Units', ...
                        'normalized'); % top left
    text(0.02, 0.95, ['Capsules: ' num2str(capsule_data.detected_count) ...
                      ' / ' num2str(capsule_data.expected)], 'Units', ...
                      'normalized'); % bottom left 
    hold off;
    saveas(gcf, fullfile(results_dir, "original_analyzed.png"));
end

    

