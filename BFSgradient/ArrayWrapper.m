classdef ArrayWrapper < handle
	
	properties
		data
	end

	methods
		function ArrayWrapper = ArrayWrapper(data)
			ArrayWrapper.data = data;
		end

		function [] = setData(ArrayWrapper,r,c,in)
			ArrayWrapper.data(r,c,:) = in;
		end

		function out = getData(ArrayWrapper,r,c)
			if r < 1 || r > size(ArrayWrapper.data,1) || c < 1 || c > size(ArrayWrapper.data,2)
				out = false;
			else
				out = ArrayWrapper.data(r,c,:);
			end
		end
	end

end