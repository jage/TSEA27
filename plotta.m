%%Plot
global history;
global history_index;

if(history_index > 500)
    x_min = history_index - 500;
    x_max = history_index;
else
    x_min = 0;
    x_max = history_index;
end

figure(1);

subplot(321),plot((history(:, 2)- 10), '.'),axis([x_min x_max -12 12]),title('Tejp data');
subplot(322),plot(history(:, 3), '.'),axis([x_min x_max 0 260]),title('Avstånd fram');
subplot(323),plot(history(:, 4), '.'),axis([x_min x_max 0 260]),title('Avstånd höger');
subplot(324), plot(history(:, 5), '.'),axis([x_min x_max 0 260]),title('Avstånd vänster');
subplot(325), plot(history(:, 7), '.'),axis([x_min x_max 0 260]),title('Gyro');
