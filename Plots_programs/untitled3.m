figure(105)


p19= plot([5,10,20],[t19x5,t19x10,t19x20], '*g', 'LineWidth', 2);
hold on
plot([5,10,20],[t19x5,t19x10,t19x20], '-g', 'LineWidth', 2)
p21=plot([5,10,30,40,50], [t21x5, t21x10, t21x30, t21x40,t21x50], '*b', 'LineWidth', 2);
plot([5,10,30,40,50], [t21x5, t21x10, t21x30, t21x40,t21x50], '-b', 'LineWidth', 1)
p25=plot([10,20,30,40,50], [t25x10, t25x20, t25x30, t25x40,t25x50], '*r', 'LineWidth', 2);
plot([10,20,30,40,50], [t25x10, t25x20, t25x30, t25x40,t25x50], '-r', 'LineWidth', 1)
p27=plot([10,20,30,40,50], [t27x10, t27x20, t27x30, t27x40,t27x50], '*c', 'LineWidth', 2);
plot([10,20,30,40,50], [t27x10, t27x20, t27x30, t27x40,t27x50], '-c', 'LineWidth', 2)
legend([p19 p21 p25 p27],{'Rate 30','Rate 17','Rate 18','Rate 10'}, 'Location','northwest', 'FontName', 'Calibri Light','FontSize', 14)
title('Maxima Bell curves','FontName', 'Calibri Light', 'FontSize', 16)
xlabel('Elongation [%]', 'FontName', 'Calibri Light', 'FontSize', 14)
ylabel('R/R0', 'FontName', 'Calibri Light', 'FontSize', 14)
hold off