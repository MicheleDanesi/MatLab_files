function indentation(indX, indY)
    xa = [];
    ya = [];
    figure(103)
    hold on
    plot(indX, indY,'r', 'LineWidth', 2)
    for ii=1:int32(length(indX)/50)-2
        xa = [xa, indX(ii*50)];
        max(indY(ii*50:ii*50+50));
    end
    start = 40;
    for jj=1:30
        xline((start+jj*10));
    end
    Ang = char(197);
    title(strcat('Esil *** - Indentation'), 'FontName', 'Calibri Light', 'FontSize', 16)
    xlabel('time [s]', 'FontName', 'Calibri Light', 'FontSize', 14)
    ylabel('R [Ω]', 'FontName', 'Calibri Light', 'FontSize', 14)
    %txt = strcat('R_{abs} ', num2str(int32(max(ind{1,2}(:,2))*R0_0)), '\Omega');
    %text(10+X(aIM(end)-IM0), aM(end,2), txt, 'FontName', 'Calibri Light', 'FontSize', 14)
    hold off
    xlim([50 500]);
    ylim([0 1e5]);
end