function [pathValid]  = blackListPath(blacklist,pt,neighbors,imsize)	

	pathValid = logical(ones([length(neighbors(:,1)),1]));
    idx = zeros([[max(imsize)],1]);
    
	for w = 1:size(neighbors,1)
		trig = false;
		destination = neighbors(w,:);
		dist = destination - pt;

		if dist(2) > 0
			cstep = 1;
		else
			cstep = -1;
		end

		if dist(2) == 0
			temp1 = pt(1); %start row
			temp2 = destination(1); %end row
			numgridpassed = abs(temp2-temp1) + 1;
			ccurr = pt(2); %start column
			if temp1 < temp2
				idx(1:numgridpassed) = sub2ind(imsize,temp1:1:temp2,repmat(ccurr,[1,numgridpassed]));
			else
				idx(1:numgridpassed) = sub2ind(imsize,temp1:-1:temp2,repmat(ccurr,[1,numgridpassed]));
			end
			
			for p = 1:numgridpassed
				if any(blacklist == idx(p))
					pathValid(w) = 0;
					trig = 1;
					break;
				end
            end
        else
			slope = dist(1)/dist(2);
			rcurr = pt(1);
			for q = 1:abs(dist(2))
				ccurr = pt(2) + q*cstep;
				temp1 = floor(rcurr); %start row
				rcurr = rcurr + cstep*slope;
	            
	            if (round(rcurr) ~= imsize(1)) && (abs(round(rcurr)-rcurr) < 1e-5 || round(rcurr) == 1)
	                temp2 = ceil(rcurr); %end row
	            else
	                temp2 = ceil(rcurr)-1; %end row
	            end
				

				numgridpassed = abs(temp2-temp1) + 1;
				if temp1 < temp2
					idx(1:numgridpassed) = sub2ind(imsize,temp1:1:temp2,repmat(ccurr,[1,numgridpassed]));
				else
					idx(1:numgridpassed) = sub2ind(imsize,temp1:-1:temp2,repmat(ccurr,[1,numgridpassed]));
				end

				for p = 1:numgridpassed
					if any(blacklist == idx(p))
						pathValid(w) = 0;
						trig = true;
						break;
					end
				end

				if trig
					break;
				end
			end
		end
	end
end