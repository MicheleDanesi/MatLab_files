% Rough plotting of the data
function RoughPlot(dataX, dataY)
    figure(1000)
    plot(dataX, dataY, 'LineWidth', 2)
    title('Plot', 'FontName', 'Calibri Light', 'FontSize', 16)
    ylim([0 1e5]);
end