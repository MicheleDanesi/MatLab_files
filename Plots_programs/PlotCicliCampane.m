function [p, psx, psy, txX, txY, txtN] = PlotCicliCampane(nameX, nameY, R0_0, elongation)
Bool = 0;
am = []; aM = []; aim = []; aIM = [];
   
        frequency = 0.2; velocity = 0.4; wS = 1/frequency; nM = int32(elongation/(frequency*velocity));

        [m,im] = min(nameY(50+nM:50+nM+nM*2)); im = 50+nM+im-1; im0 = im; % finds the first minimum between the waiting time and the first peak
                                                                          % in the cycle
        am = [double(im0)*frequency,m/1];aim = [im0];     % calculates the x and y values of the first minimum

        IM0 = im0; % stores the value of the first minimum
        X = nameX(im0:length(nameX));
        Y = nameY(im0:length(nameY));
        
        for jj=1:15 % the for cycle is set to take 15 points (the maxima), but it can depend on the number of cycles
            if (im0+nM*2+wS)>= length(nameX);    LM = length(nameX); Bool = 1;
            else; LM = im0+nM*2+wS; end

            [M,I] = max(nameY(im0:LM));
            aM = [aM;(double(im0)+I-1)*frequency,M/1]; aIM = [aIM;im0+I-1];
            if Bool == 1; break; end

            if (im0+I-1+2*nM+wS)>= length(nameX);    lm = length(nameX); Bool = 1;
            else; lm = im0+I-1+2*nM+wS; end

            [m,im] = min(nameY(im0+I-1:lm)); im0 = im0 + I + im - 2;
            am = [am;double(im0)*0.2,m/1]; aim = [aim;im0];
            if Bool == 1; break; end
        end
        set_start_point = 3;
        plot(aM(set_start_point:end,1),aM(set_start_point:end,2),'*r','LineWidth',1.5)
        p = plot(X(aIM(set_start_point)-IM0:aIM(end)-IM0),polyval(polyfit(aM(set_start_point:end,1), aM(set_start_point:end,2), 4), X(aIM(set_start_point)-IM0:aIM(end)-IM0)),'LineWidth',2);
        txt = strcat('R_{0} ',' ', num2str(int32(R0_0)), '\Omega', ' - ', ' R_{abs} ', num2str(int32(max(aM(:,2))*1)), '\Omega');
        text(10+X(aIM(end)-IM0), aM(end,2), txt, 'FontName', 'Calibri Light', 'FontSize', 14)
        peakNumber = 8;
        psx = (X(aim(peakNumber)-IM0:aim(peakNumber+1)-IM0)-X(aIM(peakNumber)-IM0))*velocity;
        psy = Y(aim(peakNumber)-IM0:aim(peakNumber+1)-IM0)/1;
        txtN = strcat( 'R_{abs} ', num2str(int32(max(aM(:,2))*1)), '\Omega');
        txX = -1;
        txY = aM(peakNumber,2)+0.2;

end