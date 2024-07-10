clc,clear all,close

% Parametreler
grid_size = 5; % Grid boyutu (5x5x5)
num_fireflies = grid_size * grid_size * grid_size; % Ateş böceği sayısı
max_iter = 200; % Maksimum iterasyon sayısı
dt = 0.9; % Zaman adımı
threshold = 1; % Eşik değeri (flaşlama için)
coupling_strength = .75; % Bağlanma kuvveti

% Ateş böceklerinin başlangıç fazları (0 ile 1 arasında)
phases = rand(grid_size, grid_size, grid_size);

% Simülasyon
figure;
for iter = 1:max_iter
    % Ateş böceklerinin fazlarını güncelle
    new_phases = phases; % Geçici faz matrisi
    for i = 1:grid_size
        for j = 1:grid_size
            for k = 1:grid_size
                if phases(i, j, k) >= threshold
                    new_phases(i, j, k) = 0; % Flaşlama (fazı sıfırla)
                else
                    new_phases(i, j, k) = phases(i, j, k) + dt; % Fazı artır
                end

                % Bağlanma etkisi
                neighbors = get_neighbors(phases, i, j, k, grid_size);
                if any(neighbors(:) >= threshold)
                    new_phases(i, j, k) = new_phases(i, j, k) + coupling_strength * (1 - new_phases(i, j, k));
                end
            end
        end
    end

    % Fazları güncelle
    phases = new_phases;

    % Ateş böceklerinin durumlarını çiz
    clf;
    hold on;
    view(45,25)
    for i = 1:grid_size
        for j = 1:grid_size
            for k = 1:grid_size
                if phases(i, j, k) >= threshold
                    plot3(i, j, k, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 5); % Flaşlayan ateş böceği
                else
                    plot3(i, j, k, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 5); % Flaşlamayan ateş böceği
                end
            end
        end
    end
    title(['Iteration: ', num2str(iter)]);
    xlim([0 grid_size+1]);
    ylim([0 grid_size+1]);
    zlim([0 grid_size+1]);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    drawnow;
end

% Sonuçları yazdır
disp('Senkronizasyon tamamlandı.');


function neighbors = get_neighbors(phases, x, y, z, grid_size)
% Verilen pozisyondaki ateş böceğinin komşularını döndür
neighbors = [];
for i = max(1, x-1):min(grid_size, x+1)
    for j = max(1, y-1):min(grid_size, y+1)
        for k = max(1, z-1):min(grid_size, z+1)
            if i ~= x || j ~= y || k ~= z
                neighbors = [neighbors, phases(i, j, k)];
            end
        end
    end
end
end